# project 10 
Names to faces
- create a new Single View App project in Xcode, call it Project10
- change class to extend a different parent class
```swift
class ViewController: UICollectionViewController {
```
- go into storyboard and delete the existing view controller
- drag in a collection view controller
- in identity inspector link the collection view controller in interface builder to view controller by chasnging the class dropdown
- embed in a navigation controller
- click on collection view in the tree
- go to the size inspector and set Cell Size to have the width 140 and height 180
- set the section insets for top, bottom, left and right to all be 10
- select that collection view cell in the tree
- attributers inspector, change identifier to Person
- change background white
- drag an image view into it
- give it X:10, Y:10, width 120 and height 120 in size inspector
- place a UILabel in there too, with X:10, Y:134, width 120 and height 40
- in attributres inspector set alignmen center
- custom font, marker felt for family and thin for style
- size 16, set number of lines to two
- File, New > File, then select iOS > Source > Cocoa Touch Class
- set subclass of UICollectionViewCell
- enter PersonCell for class
- add interface builder outlets
```swift
@IBOutlet var imageView: UIImageView!
@IBOutlet var name: UILabel!
```
- go to interface builder, select collection view cell
- click identity inspector (cmd opt 3)
- change default class from UICollectionViewCell to PersonCell
- got connections inspector (cmd opt 6)
- drag imageview var circle to image view on interface 
- drage name to label on interface
## UICollectionView data sources
The collection view works like a table view, only  we add the code for the cells instead of rows
```swift
override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 10
}

override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Person", for: indexPath) as? PersonCell else {
        // we failed to get a PersonCell – bail out!
        fatalError("Unable to dequeue PersonCell.")
    }

    // if we're still here it means we got a PersonCell, so we can return it
    return cell
}
```
- change background colour of collection view
- cmd r run
## importing photos with UIImagePickerController
- create a button that lets users add people to the app in view did load
```swift
navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewPerson))
```
- create the addNewPerson method the above call referred to
```swift
@objc func addNewPerson() {
    let picker = UIImagePickerController()
    picker.allowsEditing = true
    picker.delegate = self
    present(picker, animated: true)
}
```
- note the error. self must implement UIImagePickerControllerDelegate and UINavigationControllerDelegate
```swift
class ViewController: UICollectionViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
```
- add didFinishPickingMediaWithInfo code
```sw3ift
func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    guard let image = info[.editedImage] as? UIImage else { return }

    let imageName = UUID().uuidString
    let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)

    if let jpegData = image.jpegData(compressionQuality: 0.8) {
        try? jpegData.write(to: imagePath)
    }

    dismiss(animated: true)
}

func getDocumentsDirectory() -> URL {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return paths[0]
}
```
