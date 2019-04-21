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
```swift
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
## Custom subclasses of NSObject
- create new cocoa touch class
- call it Person, extend NSObject
- add properties
```swift
var name: String
var image: String
```
- add init function
```swift
init(name: String, image: String) {
    self.name = name
    self.image = image
}
```
- add people to viewcontroller
```swift
var people = [Person]()
```
- add this before the call to dismiss
```swift
let person = Person(name: "Unknown", image: imageName)
people.append(person)
collectionView.reloadData()
```
## connecting up the people
- refactor numberOfItemsInSection
```swift
override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return people.count
}
```
- refactor cellForItemAt
```swift
override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Person", for: indexPath) as? PersonCell else {
            fatalError("Unable to dequeue PersonCell.")
        }
        
        let person = people[indexPath.item]
        
        cell.name.text = person.name
        
        let path = getDocumentsDirectory().appendingPathComponent(person.image)
        cell.imageView.image = UIImage(contentsOfFile: path.path)
        
        cell.imageView.layer.borderColor = UIColor(white: 0, alpha: 0.3).cgColor
        cell.imageView.layer.borderWidth = 2
        cell.imageView.layer.cornerRadius = 3
        cell.layer.cornerRadius = 7
        
        return cell
    }
```
- add didSelectItemAt
```swift
override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let person = people[indexPath.item]

    let ac = UIAlertController(title: "Rename person", message: nil, preferredStyle: .alert)
    ac.addTextField()

    ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))

    ac.addAction(UIAlertAction(title: "OK", style: .default) { [weak self, weak ac] _ in
        guard let newName = ac?.textFields?[0].text else { return }
        person.name = newName

        self?.collectionView.reloadData()
    })

    present(ac, animated: true)
}
```
## challenge @todo
- Add a second UIAlertController that gets shown when the user taps a picture, asking them whether they want to rename the person or delete them.
- Try using picker.sourceType = .camera when creating your image picker, which will tell it to create a new image by taking a photo. This is only available on devices (not on the simulator) so you might want to check the return value of UIImagePickerController.isSourceTypeAvailable() before trying to use it!
- Modify project 1 so that it uses a collection view controller rather than a table view controller. I recommend you keep a copy of your original table view controller code so you can refer back to it later on.

