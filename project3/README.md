# project 3
- copy project 1 folder, rename and open in xcode
- open detailview controller, add to viewDidLoad
```swift
navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
```
- add new method
```
@objc func shareTapped() {
    guard let image = imageView.image?.jpegData(compressionQuality: 0.8) else {
        print("No image found")
        return
    }

    let vc = UIActivityViewController(activityItems: [image], applicationActivities: [])
    vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
    present(vc, animated: true)
}
```
- open info.plist
- right click add new row
- select Privacy - Photo Library Additions Usage Description
- add in a message like 'we need to be able to save the images 
## challenge
- Try adding the image name to the list of items that are shared. The activityItems parameter is an array, so you can add strings and other things freely. Note: Facebook won’t let you share text, but most other share options will.
- Go back to project 1 and add a bar button item to the main view controller that recommends the app to other people.
- Go back to project 2 and add a bar button item that shows their score when tapped.
### challenge 1
alter the array being passed in, cast the string as Any
```swift
let vc = UIActivityViewController(activityItems: [selectedImage as Any, image], applicationActivities: [])
```
### challenge 2
copy paste share button code, change message to some testimonial crap.
### challenge 3
add to view did load
```swift
navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(getScoreAlert))
```
add function 
```
    @objc func getScoreAlert() {
        let ac = UIAlertController(title: "Score", message: "Your score is \(score)", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
```
