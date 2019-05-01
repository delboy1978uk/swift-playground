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
