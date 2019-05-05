# project17 - space race
- create new spritekit project called project17
- do the usual boilerplate cleanup crap
- copy the assets into the project
## starfield, image, score
- declare properties in the gamescene
```swift
var starfield: SKEmitterNode!
var player: SKSpriteNode!

var scoreLabel: SKLabelNode!
var score = 0 {
    didSet {
        scoreLabel.text = "Score: \(score)"
    }
}
```
- add to `didMove(to:)`
```swift
backgroundColor = .black
        
        starfield = SKEmitterNode(fileNamed: "starfield")!
        starfield.position = CGPoint(x: 960, y: 270)
        starfield.advanceSimulationTime(10)
        addChild(starfield)
        starfield.zPosition = -1
        
        player = SKSpriteNode(imageNamed: "player")
        player.position = CGPoint(x: 100, y: 384)
        player.physicsBody = SKPhysicsBody(texture: player.texture!, size: player.size)
        player.physicsBody?.contactTestBitMask = 1
        addChild(player)
        
        scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
        scoreLabel.position = CGPoint(x: 16, y: 16)
        scoreLabel.horizontalAlignmentMode = .left
        addChild(scoreLabel)
        
        score = 0
        
        physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        physicsWorld.contactDelegate = self
```
- implement `SKPhysicsContactDelegate`
```swift
class GameScene: SKScene, SKPhysicsContactDelegate {
```
## Timer, linearDamping, angularDamping
- add three new properties
```swift
let possibleEnemies = ["ball", "hammer", "tv"]
var isGameOver = false
var gameTimer: Timer?
```
- add to `didMove(to:)`
```swift
gameTimer = Timer.scheduledTimer(timeInterval: 0.35, target: self, selector: #selector(createEnemy), userInfo: nil, repeats: true)
```
- add createEnemy() function
```swift

```
- add the update() function
```swift
override func update(_ currentTime: TimeInterval) {
    for node in children {
        // delete nodes scrolled off screen
        if node.position.x < -300 {
            node.removeFromParent()
        }
    }

    if !isGameOver {
        score += 1
    }
}
```
- run the game and you'll see stuff flying towards your ship
## contact: didBegin()
- add a `touchesMoved()` method
```swift
override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    guard let touch = touches.first else { return }
    var location = touch.location(in: self)

    if location.y < 100 {
        location.y = 100
    } else if location.y > 668 {
        location.y = 668
    }

    player.position = location
}
```
- add the collision code
```swift
func didBegin(_ contact: SKPhysicsContact) {
    let explosion = SKEmitterNode(fileNamed: "explosion")!
    explosion.position = player.position
    addChild(explosion)

    player.removeFromParent()

    isGameOver = true
}
```
## challenges @todo
- Stop the player from cheating by lifting their finger and tapping elsewhere – try implementing touchesEnded() to make it work.
- Make the timer start at one second, but then after 20 enemies have been made subtract 0.1 seconds from it so it’s triggered every 0.9 seconds. After making 20 more, subtract another 0.1, and so on. Note: you should call invalidate() on gameTimer before giving it a new value, otherwise you end up with multiple timers.
- Stop creating space debris after the player has died.

