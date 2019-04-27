# project 11
SpriteKit, physics, blend modes, radians, CGFloat, NSKeyedUnarchiver
## setting up
- create a new project, and this time select game
- call it project 11
- choose spritekit as game technology
- choose ipad only
- choose ladscape left and right only
- run the app and you will see default template stuff
- open GameScene.swift, delete and replace 
```swift
import SpriteKit

class GameScene: SKScene {
    override func didMove(to view: SKView) {
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
}
```
- open GameScene.sks to get scene editor
- attributes inspector
- click scene, set Anchor Point as 0,0
- change the scene size to 1024 x 768
- delete actions.sks
### falling boxes
Now the template stuff is gone and we have a clean project
- drag the images into the assets folder
- put the following code in didMove() to give it a background
```swift
let background = SKSpriteNode(imageNamed: "background.jpg")
background.position = CGPoint(x: 512, y: 384)
background.blendMode = .replace
background.zPosition = -1
addChild(background)
```
- run the app and check we have the background
- create a box where the screen gets touched in touchesBegan()
```swift
if let touch = touches.first {
    let location = touch.location(in: self)
    let box = SKSpriteNode(color: UIColor.red, size: CGSize(width: 64, height: 64))
    box.position = location
    addChild(box)
}
```
- run and check it out again
- before adding the position, add this code
```swift
box.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 64, height: 64))
```
- add this to the endo of didMoveTo()
```swift
physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
```
- run again, and we have gravity!
## bouncing balls: circleOfRadius
- replace box code with ball
```swift
let ball = SKSpriteNode(imageNamed: "ballRed")
ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.size.width / 2.0)
ball.physicsBody?.restitution = 0.4
ball.position = location
addChild(ball)
```
- add bouncer code to end of didMove()
```swift
let bouncer = SKSpriteNode(imageNamed: "bouncer")
bouncer.position = CGPoint(x: 512, y: 0)
bouncer.physicsBody = SKPhysicsBody(circleOfRadius: bouncer.size.width / 2.0)
bouncer.physicsBody?.isDynamic = false
addChild(bouncer)
```
- run it and see the bouncer
- add this method
```swift
func makeBouncer(at position: CGPoint) {
    let bouncer = SKSpriteNode(imageNamed: "bouncer")
    bouncer.position = position
    bouncer.physicsBody = SKPhysicsBody(circleOfRadius: bouncer.size.width / 2.0)
    bouncer.physicsBody?.isDynamic = false
    addChild(bouncer)
}
```
- replace didMove bouncer code with this
```swift
makeBouncer(at: CGPoint(x: 0, y: 0))
makeBouncer(at: CGPoint(x: 256, y: 0))
makeBouncer(at: CGPoint(x: 512, y: 0))
makeBouncer(at: CGPoint(x: 768, y: 0))
makeBouncer(at: CGPoint(x: 1024, y: 0))
```
# spinning slots: SKAction
- create a makeSlot() function
```swift
func makeSlot(at position: CGPoint, isGood: Bool) {
    var slotBase: SKSpriteNode

    if isGood {
        slotBase = SKSpriteNode(imageNamed: "slotBaseGood")
    } else {
        slotBase = SKSpriteNode(imageNamed: "slotBaseBad")
    }

    slotBase.position = position
    addChild(slotBase)
}
```
- add to diMove() before bouncers
```swift
makeSlot(at: CGPoint(x: 128, y: 0), isGood: true)
makeSlot(at: CGPoint(x: 384, y: 0), isGood: false)
makeSlot(at: CGPoint(x: 640, y: 0), isGood: true)
makeSlot(at: CGPoint(x: 896, y: 0), isGood: false)
```
- add a glow to slot
```
func makeSlot(at position: CGPoint, isGood: Bool) {
    var slotBase: SKSpriteNode
    var slotGlow: SKSpriteNode

    if isGood {
        slotBase = SKSpriteNode(imageNamed: "slotBaseGood")
        slotGlow = SKSpriteNode(imageNamed: "slotGlowGood")
    } else {
        slotBase = SKSpriteNode(imageNamed: "slotBaseBad")
        slotGlow = SKSpriteNode(imageNamed: "slotGlowBad")
    }

    slotBase.position = position
    slotGlow.position = position

    addChild(slotBase)
    addChild(slotGlow)
}
```
- add a spin in make slot
```swift
let spin = SKAction.rotate(byAngle: .pi, duration: 10)
let spinForever = SKAction.repeatForever(spin)
slotGlow.run(spinForever)
```
## collision cdetection SKPhysicsContactDelegate
We need to add rectangle physics to the slots
- add before addChild with slotBase
```swift
slotBase.physicsBody = SKPhysicsBody(rectangleOf: slotBase.size)
slotBase.physicsBody?.isDynamic = false
```
- modify code, give the slots a name
```swift
if isGood {
    slotBase = SKSpriteNode(imageNamed: "slotBaseGood")
    slotGlow = SKSpriteNode(imageNamed: "slotGlowGood")
    slotBase.name = "good"
} else {
    slotBase = SKSpriteNode(imageNamed: "slotBaseBad")
    slotGlow = SKSpriteNode(imageNamed: "slotGlowBad")
    slotBase.name = "bad"
}
```
- add this where the balls are created
```swift
ball.name = "ball"
```
- make our scene the contact delegate of the physics world
```swift
class GameScene: SKScene, SKPhysicsContactDelegate {
```
- add tghis below where we set scenes physics body
```swift
physicsWorld.contactDelegate = self
```
- set balls contactTestBitMask property to be equal to their collisionBitMask above balls restitution being set
```swift
ball.physicsBody!.contactTestBitMask = ball.physicsBody!.collisionBitMask     
```
- add these two methods
```swift
func collisionBetween(ball: SKNode, object: SKNode) {
    if object.name == "good" {
        destroy(ball: ball)
    } else if object.name == "bad" {
        destroy(ball: ball)
    }
}

func destroy(ball: SKNode) {
    ball.removeFromParent()
}
```
- add the contact checking method
```swift
func didBegin(_ contact: SKPhysicsContact) {
    if contact.bodyA.node?.name == "ball" {
        collisionBetween(ball: contact.bodyA.node!, object: contact.bodyB.node!)
    } else if contact.bodyB.node?.name == "ball" {
        collisionBetween(ball: contact.bodyB.node!, object: contact.bodyA.node!)
    }
}
```
- run the game and check it out now
- tap furiously and eventually the game will crash, this is due to both slots triggering code, second time though it is nil!
- refactor didBegin
```swift
func didBegin(_ contact: SKPhysicsContact) {
    guard let nodeA = contact.bodyA.node else { return }
    guard let nodeB = contact.bodyB.node else { return }

    if nodeA.name == "ball" {
        collisionBetween(ball: nodeA, object: nodeB)
    } else if nodeB.name == "ball" {
        collisionBetween(ball: nodeB, object: nodeA)
    }
}
```
## scores on the board
- declare these properties at the top of the class
```swift
var scoreLabel: SKLabelNode!

var score = 0 {
    didSet {
        scoreLabel.text = "Score: \(score)"
    }
}
```
- add this to didMove()
```swift
scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
scoreLabel.text = "Score: 0"
scoreLabel.horizontalAlignmentMode = .right
scoreLabel.position = CGPoint(x: 980, y: 700)
addChild(scoreLabel)
```
- modify collision code
```swift
func collisionBetween(ball: SKNode, object: SKNode) {
    if object.name == "good" {
        destroy(ball: ball)
        score += 1
    } else if object.name == "bad" {
        destroy(ball: ball)
        score -= 1
    }
}
```
- add the following properties
```swift
var editLabel: SKLabelNode!

var editingMode: Bool = false {
    didSet {
        if editingMode {
            editLabel.text = "Done"
        } else {
            editLabel.text = "Edit"
        }
    }
}
```
- add to didMove()
```swift
editLabel = SKLabelNode(fontNamed: "Chalkduster")
editLabel.text = "Edit"
editLabel.position = CGPoint(x: 80, y: 700)
addChild(editLabel)
```
- under let location refactor let ball, add this
```swift
let location = touch.location(in: self)

let objects = nodes(at: location)

if objects.contains(editLabel) {
    editingMode.toggle()
} else {
    let ball = SKSpriteNode(imageNamed: "ballRed")
    // rest of ball code
}
```
- in the else statement where the ball is made, refactor again
```swift
if editingMode {
    // create a box
} else {
    // existing create a ball code here
}
```
- add the box creation code
```swift
let size = CGSize(width: Int.random(in: 16...128), height: 16)
let box = SKSpriteNode(color: UIColor(red: CGFloat.random(in: 0...1), green: CGFloat.random(in: 0...1), blue: CGFloat.random(in: 0...1), alpha: 1), size: size)
box.zRotation = CGFloat.random(in: 0...3)
box.position = location

box.physicsBody = SKPhysicsBody(rectangleOf: box.size)
box.physicsBody?.isDynamic = false

addChild(box)
```
## special effects: SKEmitterNode
- modify the destroy method
```swift
func destroy(ball: SKNode) {
    if let fireParticles = SKEmitterNode(fileNamed: "FireParticles") {
        fireParticles.position = ball.position
        addChild(fireParticles)
    }

    ball.removeFromParent()
}
```
- go into assets folder
- delete the fireparticles file
- now back in finder drag that file into main project folder instead
- click on the file to open particle editor
Here are the options

-  Particle Texture: what image to use for your particles.
-  Particles Birthrate: how fast to create new particles.
-  Particles Maximum: the maximum number of particles this emitter should create before finishing.
-  Lifetime Start: the basic value for how many seconds each particle should live for.
-  Lifetime Range: how much, plus or minus, to vary lifetime.
-  Position Range X/Y: how much to vary the creation position of particles from the emitter node's position.
-  Angle Start: which angle you want to fire particles, in degrees, where 0 is to the right and 90 is straight up.
-  Angle Range: how many degrees to randomly vary particle angle.
-  Speed Start: how fast each particle should move in its direction.
-  Speed Range: how much to randomly vary particle speed.
-  Acceleration X/Y: how much to affect particle speed over time. This can be used to simulate gravity or wind.
-  Alpha Start: how transparent particles are when created.
-  Alpha Range: how much to randomly vary particle transparency.
-  Alpha Speed: how much to change particle transparency over time. A negative value means "fade out."
-  Scale Start / Range / Speed: how big particles should be when created, how much to vary it, and how much it should change over time. A negative value means "shrink slowly."
-  Rotation Start / Range / Speed: what Z rotation particles should have, how much to vary it, and how much they should spin over time.
-  Color Blend Factor / Range / Speed: how much to color each particle, how much to vary it, and how much it should change over time.
## challenges @todo
- The pictures we’re using in have other ball pictures rather than just “ballRed”. Try writing code to use a random ball color each time they tap the screen.
- Right now, users can tap anywhere to have a ball created there, which makes the game too easy. Try to force the Y value of new balls so they are near the top of the screen.
- Give players a limit of five balls, then remove obstacle boxes when they are hit. Can they clear all the pins with just five balls? You could make it so that landing on a green slot gets them an extra ball.

