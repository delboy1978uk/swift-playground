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
