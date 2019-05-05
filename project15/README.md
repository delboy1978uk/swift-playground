# project 15 animation
- create a single view app lanscape ipad 
- copy the assets from the hacking bwith swift projectr files
- add a button in interface builder near the bottom
- ctrl drag the button in the interface tree to the view above it
- select Bottom Space to Safe Area
- ctrl drag again select Center Horizontally in Safe Area.
- open assistant editor, ctrl drag into controller class
- created action called tapped
- close assistant editor and open controller
- add the following
```swift
var imageView: UIImageView!
var currentAnimation = 0
```
- load the image into our view in `viewDidLoad()`
```swift
imageView = UIImageView(image: UIImage(named: "penguin"))
imageView.center = CGPoint(x: 512, y: 384)
view.addSubview(imageView)
``
- add the following to `tapped()`
```swift
currentAnimation += 1

if currentAnimation > 7 {
    currentAnimation = 0
}
```
## animate(withDuration:)
- change the sender in `tapped()` from `Any` to `UIButton`
- add this to the start of tapped()
```
sender.isHidden = true

UIView.animate(withDuration: 1, delay: 0, options: [], animations: {
    switch self.currentAnimation {
        case 0:
            break

        default:
            break
        }
    }) { finished in
    sender.isHidden = false
}
```
- run the app. notice that even when you tap, the button doesnt disappear since UIKit hasnt detected animation and so goes straight to the completion closure
## CGAffineTransform
- double the image size for case 0 and remove the break
```swift
self.imageView.transform = CGAffineTransform(scaleX: 2, y: 2)
```
- add case 1, which effectively resets back to it's initial state
```swift
self.imageView.transform = .identity
```
- add a movement case
```swift
case 2:
    self.imageView.transform = CGAffineTransform(translationX: -256, y: -256)

case 3:
    self.imageView.transform = .identity
```
### rotation
1 You need to provide the value in radians specified as a CGFloat. This usually isn't a problem – if you type 1.0 in there, Swift is smart enough to make that a CGFloat automatically. If you want to use a value like pi, use CGFloat.pi.
2 Core Animation will always take the shortest route to make the rotation work. So, if your object is straight and you rotate to 90 degrees (radians: half of pi), it will rotate clockwise. If your object is straight and you rotate to 270 degrees (radians: pi + half of pi) it will rotate counter-clockwise because it's the smallest possible animation.
3 A consequence of the second catch is that if you try to rotate 360 degrees (radians: pi times 2), Core Animation will calculate the shortest rotation to be "just don't move, because we're already there." The same goes for values over 360, for example if you try to rotate 540 degrees (one and a half full rotations), you'll end up with just a 180-degree rotation.
- add a rotation case
```swift
case 4:
    self.imageView.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
case 5:
    self.imageView.transform = .identity
```
- animate some different properties
```swift
case 6:
    self.imageView.alpha = 0.1
    self.imageView.backgroundColor = UIColor.green

case 7:
    self.imageView.alpha = 1
    self.imageView.backgroundColor = UIColor.clear
```
- run the app and try it out
- now replace `UIView.animate(withDuration: 1, delay: 0, options: [],` with
```swift
UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, options: [],
```
## challenges (@todo)
- Go back to project 8 and make the letter group buttons fade out when they are tapped. We were using the isHidden property, but you'll need to switch to alpha because isHidden is either true or false, it has no animatable values between.
- Go back to project 13 and make the image view fade in when a new picture is chosen. To make this work, set the alpha to 0 first.
- Go back to project 2 and make the flags scale down with a little bounce when pressed.

