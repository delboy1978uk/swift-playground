# project 14 whack a penguin
## setting up
- create a new game project
- call it project 14
- choose spritekit as game technology
- choose ipad only
- choose landscape left and right only
- copy 
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
- change the scene size to 960 x 540
- delete actions.sks
## SKCropNode
- add properties to game scene
```swift
var gameScore: SKLabelNode!
var score = 0 {
    didSet {
        gameScore.text = "Score: \(score)"
    }
}
```
- add to didmove function
```swift
let background = SKSpriteNode(imageNamed: "whackBackground")
background.position = CGPoint(x: 480, y: 270)
background.blendMode = .replace
background.zPosition = -1
addChild(background)

gameScore = SKLabelNode(fontNamed: "Chalkduster")
gameScore.text = "Score: 0"
gameScore.position = CGPoint(x: 8, y: 8)
gameScore.horizontalAlignmentMode = .left
gameScore.fontSize = 48
addChild(gameScore)
```
- new file iOS > Source > Cocoa Touch Class
- call it WhackSlot
- subclass of SKNode
- add to top of new class
```swift
import SpriteKit
```
- add a configure method
```swift
func configure(at position: CGPoint) {
    self.position = position

    let sprite = SKSpriteNode(imageNamed: "whackHole")
    addChild(sprite)
}
```
- add an array of them to the game scene class
```swift
var slots = [WhackSlot]()
```
- add a create slot func
```swift
func createSlot(at position: CGPoint) {
    let slot = WhackSlot()
    slot.configure(at: position)
    addChild(slot)
    slots.append(slot)
}
```
- add to the end of `didMove(to:)`
```swift
for i in 0 ..< 5 { createSlot(at: CGPoint(x: 100 + (i * 170), y: 410)) }
for i in 0 ..< 4 { createSlot(at: CGPoint(x: 180 + (i * 170), y: 320)) }
for i in 0 ..< 5 { createSlot(at: CGPoint(x: 100 + (i * 170), y: 230)) }
for i in 0 ..< 4 { createSlot(at: CGPoint(x: 180 + (i * 170), y: 140)) }
```
- in whackslot, add a property for the penguin node
```swift
var charNode: SKSpriteNode!
```
- now add this to configure func
```swift
let cropNode = SKCropNode()
cropNode.position = CGPoint(x: 0, y: 15)
cropNode.zPosition = 1
cropNode.maskNode = nil

charNode = SKSpriteNode(imageNamed: "penguinGood")
charNode.position = CGPoint(x: 0, y: -90)
charNode.name = "character"
cropNode.addChild(charNode)

addChild(cropNode)
```
- run the game and you'll see everything in position but with no crop
- change in the slot the maskmode = nil line
```swift
cropNode.maskNode = SKSpriteNode(imageNamed: "whackMask")
```
## making penguins appear
- add properties to whack slot
```swift
var isVisible = false
var isHit = false
```
- create a show method
```swift
func show(hideTime: Double) {
    if isVisible { return }

    charNode.run(SKAction.moveBy(x: 0, y: 80, duration: 0.05))
    isVisible = true
    isHit = false

    if Int.random(in: 0...2) == 0 {
        charNode.texture = SKTexture(imageNamed: "penguinGood")
        charNode.name = "charFriend"
    } else {
        charNode.texture = SKTexture(imageNamed: "penguinEvil")
        charNode.name = "charEnemy"
    }
}
```
- add this to game scene
```
var popupTime = 0.85
```
For reference, here is how to run a closure after a delay
```swift
DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
    self?.doStuff()
}
```
- add the createEnemy() function
```swift
func createEnemy() {
    popupTime *= 0.991

    slots.shuffle()
    slots[0].show(hideTime: popupTime)

    if Int.random(in: 0...12) > 4 { slots[1].show(hideTime: popupTime) }
    if Int.random(in: 0...12) > 8 {  slots[2].show(hideTime: popupTime) }
    if Int.random(in: 0...12) > 10 { slots[3].show(hideTime: popupTime) }
    if Int.random(in: 0...12) > 11 { slots[4].show(hideTime: popupTime)  }

    let minDelay = popupTime / 2.0
    let maxDelay = popupTime * 2
    let delay = Double.random(in: minDelay...maxDelay)

    DispatchQueue.main.asyncAfter(deadline: .now() + delay) { [weak self] in
        self?.createEnemy()
    }
}
```
- now add this to didMove
```swift
DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
    self?.createEnemy()
}
```
- add a hide method to the whack slot
```swift
func hide() {
    if !isVisible { return }

    charNode.run(SKAction.moveBy(x: 0, y: -80, duration: 0.05))
    isVisible = false
}
```
-add this to the end of `show()`
```swift
DispatchQueue.main.asyncAfter(deadline: .now() + (hideTime * 3.5)) { [weak self] in
    self?.hide()
}
```
## whack to win: SKAction sequences
1 `SKAction.wait(forDuration:)` creates an action that waits for a period of time, measured in seconds.
2 `SKAction.run(block:)` will run any code we want, provided as a closure. "Block" is Objective-C's name for a Swift closure.
3 `SKAction.sequence()` takes an array of actions, and executes them in order. Each action won't start executing until the previous one finished.
- put this method into the WhackSlot class
```swift
func hit() {
    isHit = true

    let delay = SKAction.wait(forDuration: 0.25)
    let hide = SKAction.moveBy(x: 0, y: -80, duration: 0.5)
    let notVisible = SKAction.run { [unowned self] in self.isVisible = false }
    charNode.run(SKAction.sequence([delay, hide, notVisible]))
}
```
- fill in touches began method
```swift
override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    guard let touch = touches.first else { return }
    let location = touch.location(in: self)
    let tappedNodes = nodes(at: location)

    for node in tappedNodes {
        if node.name == "charFriend" {
            // they shouldn't have whacked this penguin
        } else if node.name == "charEnemy" {
            // they should have whacked this one
        }
    }
}
```
- in the friendly penguin if block add this
```swift
guard let whackSlot = node.parent?.parent as? WhackSlot else { continue }
if !whackSlot.isVisible { continue }
if whackSlot.isHit { continue }

whackSlot.hit()
score -= 5

run(SKAction.playSoundFileNamed("whackBad.caf", waitForCompletion:false))
```
- and in the evil penguin else
```swift
guard let whackSlot = node.parent?.parent as? WhackSlot else { continue }
if !whackSlot.isVisible { continue }
if whackSlot.isHit { continue }

whackSlot.charNode.xScale = 0.85
whackSlot.charNode.yScale = 0.85

whackSlot.hit()
score += 1

run(SKAction.playSoundFileNamed("whack.caf", waitForCompletion:false))
```
- add this to gamescene
```swift
var numRounds = 0
```
- put this code just before the popupTime assignment in createEnemy()
```swift
numRounds += 1

if numRounds >= 30 {
    for slot in slots {
        slot.hide()
    }

    let gameOver = SKSpriteNode(imageNamed: "gameOver")
    gameOver.position = CGPoint(x: 512, y: 384)
    gameOver.zPosition = 1
    addChild(gameOver)

    return
}
```
## challenges 
- Record your own voice saying "Game over!" and have it play when the game ends.
- When showing “Game Over” add an SKLabelNode showing their final score.
- Use SKEmitterNode to create a smoke-like effect when penguins are hit, and a separate mud-like effect when they go into or come out of a hole.
