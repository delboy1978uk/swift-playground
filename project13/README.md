# project 13 - instafilter
Using UIImagePickerController and UISlider and some Core Image
## building the interface
- create a new single view app
- embed the view controller inside a navigation controller
- drag a `UIView` into the controller
- give the new view a width of 375 and height of 470, with X:0 and Y:64
- give the view the background color "Dark Gray Color"
- create an image view, and place it inside the view you just created
- indent it by 10 points on every side – i.e., width 355, height 450, X:10, Y:10
- change the image's view mode from "Scale to fill" to "Aspect Fit"
- creating a label with width 72, height 21, X:16, Y:562
- give it the text "Intensity" and make it right-aligned
- drop a slider next to it, giving it width 262, X:96, Y:558
- add a button 120 wide and 44 high, with X:16, Y:605
- give it the title "Change Filter"
- add a button 60 wide by 44 high, with X:300, Y:605
- give it the title "Save"
- click on "View Controller" in the document outline
- Editor > Resolve Auto Layout Issues > Reset To Suggested Constraints
- add an outlet for the image view and the slider, called respectively imageView and intensity
- create actions from the two buttons, calling methods changeFilter() and save()
- create an action from the slider with "Value Changed" event
- call the action's method intensityChanged()
## importing a picture
- add a new property 
```swift
var currentImage: UIImage!
```
- add a button to the navbar
```swift
title = "Instafilter"
navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(importPicture))
```
- create import picture method
```swift
@objc func importPicture() {
    let picker = UIImagePickerController()
    picker.allowsEditing = true
    picker.delegate = self
    present(picker, animated: true)
}
```
- change the view controller class declaration
```swift
class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
```
- add imagePickerController method (same stuff as project 10)
```swift
func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    guard let image = info[.editedImage] as? UIImage else { return }

    dismiss(animated: true)

    currentImage = image
}
``` 
## applying filters with core image
- import the core image lib into the viewController
```swift
import CoreImage
```
- add 2 more properties
```swift
var context: CIContext!
var currentFilter: CIFilter!
```
- add to `viewDidLoad()`
```swift
context = CIContext()
currentFilter = CIFilter(name: "CISepiaTone")
```
- add to the image picker controller didFinishPickingMediaWithInfo
```swift
let beginImage = CIImage(image: currentImage)
currentFilter.setValue(beginImage, forKey: kCIInputImageKey)

applyProcessing()
```
- in `intensityChanged()`, add applyProcessing()
```swift
applyProcessing()
```
- create the `applyProcessing()` method
```swift
func applyProcessing() {
    guard let image = currentFilter.outputImage else { return }
    currentFilter.setValue(intensity.value, forKey: kCIInputIntensityKey)

    if let cgimg = context.createCGImage(image, from: image.extent) {
        let processedImage = UIImage(cgImage: cgimg)
        imageView.image = processedImage
    }
}
```
- add change filter code
```swift
let ac = UIAlertController(title: "Choose filter", message: nil, preferredStyle: .actionSheet)
ac.addAction(UIAlertAction(title: "CIBumpDistortion", style: .default, handler: setFilter))
ac.addAction(UIAlertAction(title: "CIGaussianBlur", style: .default, handler: setFilter))
ac.addAction(UIAlertAction(title: "CIPixellate", style: .default, handler: setFilter))
ac.addAction(UIAlertAction(title: "CISepiaTone", style: .default, handler: setFilter))
ac.addAction(UIAlertAction(title: "CITwirlDistortion", style: .default, handler: setFilter))
ac.addAction(UIAlertAction(title: "CIUnsharpMask", style: .default, handler: setFilter))
ac.addAction(UIAlertAction(title: "CIVignette", style: .default, handler: setFilter))
ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
present(ac, animated: true)
```
- create setFilter method
```swift
func setFilter(action: UIAlertAction) {  
    // make sure we have a valid image before continuing!
    guard currentImage != nil else { return }

    // safely read the alert action's title
    guard let actionTitle = action.title else { return }

    currentFilter = CIFilter(name: actionTitle)

    let beginImage = CIImage(image: currentImage)
    currentFilter.setValue(beginImage, forKey: kCIInputImageKey)

    applyProcessing()
}
```
- not all sliders have an intensity setting, so refactor the `applyProcessing()` method
```swift
func applyProcessing() {
    let inputKeys = currentFilter.inputKeys

    if inputKeys.contains(kCIInputIntensityKey) { currentFilter.setValue(intensity.value, forKey: kCIInputIntensityKey) }
    if inputKeys.contains(kCIInputRadiusKey) { currentFilter.setValue(intensity.value * 200, forKey: kCIInputRadiusKey) }
    if inputKeys.contains(kCIInputScaleKey) { currentFilter.setValue(intensity.value * 10, forKey: kCIInputScaleKey) }
    if inputKeys.contains(kCIInputCenterKey) { currentFilter.setValue(CIVector(x: currentImage.size.width / 2, y: currentImage.size.height / 2), forKey: kCIInputCenterKey) }

    if let cgimg = context.createCGImage(currentFilter.outputImage!, from: currentFilter.outputImage!.extent) {
        let processedImage = UIImage(cgImage: cgimg)
        self.imageView.image = processedImage
    }
}
```
## saving the image

