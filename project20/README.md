# project 20 - Fireworks Night 
Timer, follow(path:), sprite color blending, shake gestures
## setting up
- create a new SpriteKit project in Xcode, name it project 20
- adjust its project setting so that it runs on landscape iPads
- download and drag the Content folder into your Xcode project
- go through the cleaning process to make Apple’s template usable
- game scene make sure its anchor point is X:0 Y:0 and its size is 1024x768
## ready... aim... fire: Timer and follow()
- add the following properties
```swift
var gameTimer: Timer?
var fireworks = [SKNode]()

let leftEdge = -22
let bottomEdge = -22
let rightEdge = 1024 + 22

var score = 0 {
    didSet {
        // your code here
    }
}
```
- add the background in `didMove()`
```swift
override func didMove(to view: SKView) {
    let background = SKSpriteNode(imageNamed: "background")
    background.position = CGPoint(x: 512, y: 384)
    background.blendMode = .replace
    background.zPosition = -1
    addChild(background)

    gameTimer = Timer.scheduledTimer(timeInterval: 6, target: self, selector: #selector(launchFireworks), userInfo: nil, repeats: true)
}
```
- add `createFirework()` method
```swift
func createFirework(xMovement: CGFloat, x: Int, y: Int) {
    // Create an SKNode that will act as the firework container, and place it at the position that was specified.
    let node = SKNode()
    node.position = CGPoint(x: x, y: y)

    // Create a rocket sprite node, give it the name "firework" so we know that it's the important thing, adjust its colorBlendFactor property so that we can color it, then add it to the container node.
    let firework = SKSpriteNode(imageNamed: "rocket")
    firework.colorBlendFactor = 1
    firework.name = "firework"
    node.addChild(firework)

    // Give the firework sprite node one of three random colors: cyan, green or red. I've chosen cyan because pure blue isn't particularly visible on a starry sky background picture.
    switch Int.random(in: 0...2) {
    case 0:
        firework.color = .cyan

    case 1:
        firework.color = .green

    case 2:
        firework.color = .red

    default:
        break
    }

    // Create a UIBezierPath that will represent the movement of the firework.
    let path = UIBezierPath()
    path.move(to: .zero)
    path.addLine(to: CGPoint(x: xMovement, y: 1000))

    // Tell the container node to follow that path, turning itself as needed
    let move = SKAction.follow(path.cgPath, asOffset: true, orientToPath: true, speed: 200)
    node.run(move)

    // Create particles behind the rocket to make it look like the fireworks are lit.
    if let emitter = SKEmitterNode(fileNamed: "fuse") {
        emitter.position = CGPoint(x: 0, y: -22)
        node.addChild(emitter)
    }

    // Add the firework to our fireworks array and also to the scene.
    fireworks.append(node)
    addChild(node)
}
```
- create `launchFirework()` method]
```swift
@objc func launchFireworks() {
    let movementAmount: CGFloat = 1800

    switch Int.random(in: 0...3) {
    case 0:
        // fire five, straight up
        createFirework(xMovement: 0, x: 512, y: bottomEdge)
        createFirework(xMovement: 0, x: 512 - 200, y: bottomEdge)
        createFirework(xMovement: 0, x: 512 - 100, y: bottomEdge)
        createFirework(xMovement: 0, x: 512 + 100, y: bottomEdge)
        createFirework(xMovement: 0, x: 512 + 200, y: bottomEdge)

    case 1:
        // fire five, in a fan
        createFirework(xMovement: 0, x: 512, y: bottomEdge)
        createFirework(xMovement: -200, x: 512 - 200, y: bottomEdge)
        createFirework(xMovement: -100, x: 512 - 100, y: bottomEdge)
        createFirework(xMovement: 100, x: 512 + 100, y: bottomEdge)
        createFirework(xMovement: 200, x: 512 + 200, y: bottomEdge)

    case 2:
        // fire five, from the left to the right
        createFirework(xMovement: movementAmount, x: leftEdge, y: bottomEdge + 400)
        createFirework(xMovement: movementAmount, x: leftEdge, y: bottomEdge + 300)
        createFirework(xMovement: movementAmount, x: leftEdge, y: bottomEdge + 200)
        createFirework(xMovement: movementAmount, x: leftEdge, y: bottomEdge + 100)
        createFirework(xMovement: movementAmount, x: leftEdge, y: bottomEdge)

    case 3:
        // fire five, from the right to the left
        createFirework(xMovement: -movementAmount, x: rightEdge, y: bottomEdge + 400)
        createFirework(xMovement: -movementAmount, x: rightEdge, y: bottomEdge + 300)
        createFirework(xMovement: -movementAmount, x: rightEdge, y: bottomEdge + 200)
        createFirework(xMovement: -movementAmount, x: rightEdge, y: bottomEdge + 100)
        createFirework(xMovement: -movementAmount, x: rightEdge, y: bottomEdge)

    default:
        break
    }
}
```
## swipe to select
- add `checkTouches()` method
```swift
func checkTouches(_ touches: Set<UITouch>) {
    guard let touch = touches.first else { return }

    let location = touch.location(in: self)
    let nodesAtPoint = nodes(at: location)

    for case let node as SKSpriteNode in nodesAtPoint {
        guard node.name == "firework" else { continue }

        for parent in fireworks {
            guard let firework = parent.children.first as? SKSpriteNode else { continue }

            if firework.name == "selected" && firework.color != node.color {
                firework.name = "firework"
                firework.colorBlendFactor = 1
            }
        }

        node.name = "selected"
        node.colorBlendFactor = 0
    }
}
```
- add `touchesBegan()` and `touchesMoved()`
```swift
override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesBegan(touches, with: event)
    checkTouches(touches)
}

override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesMoved(touches, with: event)
    checkTouches(touches)
}
```
- add the `update()` method
```swift
override func update(_ currentTime: TimeInterval) {
    for (index, firework) in fireworks.enumerated().reversed() {
        if firework.position.y > 900 {
            // this uses a position high above so that rockets can explode off screen
            fireworks.remove(at: index)
            firework.removeFromParent()
        }
    }
}
```
## making things go bang: SKEmitterNode
- add explode code
```swift
func explode(firework: SKNode) {
    if let emitter = SKEmitterNode(fileNamed: "explode") {
        emitter.position = firework.position
        addChild(emitter)
    }

    firework.removeFromParent()
}
```
- add explode firework method
```swift
func explodeFireworks() {
    var numExploded = 0

    for (index, fireworkContainer) in fireworks.enumerated().reversed() {
        guard let firework = fireworkContainer.children.first as? SKSpriteNode else { continue }

        if firework.name == "selected" {
            // destroy this firework!
            explode(firework: fireworkContainer)
            fireworks.remove(at: index)
            numExploded += 1
        }
    }

    switch numExploded {
    case 0:
        // nothing – rubbish!
        break
    case 1:
        score += 200
    case 2:
        score += 500
    case 3:
        score += 1500
    case 4:
        score += 2500
    default:
        score += 4000
    }
}
```
- add shake detection to game Controller
```swift
override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
    guard let skView = view as? SKView else { return }
    guard let gameScene = skView.scene as? GameScene else { return }
    gameScene.explodeFireworks()
}
```
