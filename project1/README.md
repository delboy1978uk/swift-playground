# project 1
Listing Files, making an image viewing app
## setting up
- Create ne Xcode project
- single view app, next
- project 1 for product name, swift for language, universal for devices
- org identifier (reversed wesite domain)
- leave use core data, unit tests, and ui tests unchecked for now
- project > destinatin (or icon top left) select device to test on (my phone!)
- cmd-r to run, cmd-. to stop (or use the icons)
- create Content folder with images, drag into project
- check 'copy items if needed' choose create groups
- click finish!
## listing images
- open viewcontroller.swift
- add code to viewDidLoad func
```swift
var pictures = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        for item in items {
            if item.hasPrefix("nssl") {
                pictures.append(item)
            }
        }
        print(pictures)
    }
```
## designing the interface
- change ViewController, get it to extend UITableViewController
- go into main storyboard
- make sure document outline is on - editor menu
- select view controller scene and delete it!
- open objecrt library (cmd-shift-L, or View > Libraries > Show Library)
- type table to search
- drag TableViewController onto storyboard
- open identity inspector (cmd-alt-3 or View > Utilities > Show Identity Inspector)
- where it says class, select ViewController
- open attributes inspector (cmd-alt-4 or View > Utilities > Show Attributes Inspector)
- check Is Initial View Controller
- in document outline drill down tree to table view with cell inside
- select cell, attributes inspector, enter "Picture" into identifier
- change style from custom to basic
- Editor > Embed In > Navigation Controller 
### showing rows
```swift
override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return pictures.count
}
```
### dequeing cells
```swift
override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
    cell.textLabel?.text = pictures[indexPath.row]
    return cell
}
```
## detail screen
- File > New > File > iOS > CocoaTouch class
- name DetailViewController
- Subclass Of UIViewController
- unselected Also create XIB file
- next, then goto storyboard
- open the object library
- drag View Controller into storyboard
- id inspector cmd-alt-3
- set Storyboard ID as Detail
- set class to DetailViewController
- drag Image View from lib onto detail view controller
- drag edges to fill space
- Editor > Resolve Auto Layout Issues > Reset To Suggested Constraints. 
- View > Assistant Editor > Show Assistant Editor
- ctrl drag image view to detail controller
- use defaults, enter imageView for name
- View > Standard Editor > Show Standard Editor
## loading images with UIImage
- add to detail controller 
```swift
var selectedImage: String?
```
- add to view controller
```swift
override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    // 1: try loading the "Detail" view controller and typecasting it to be DetailViewController
    if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
        // 2: success! Set its selectedImage property
        vc.selectedImage = pictures[indexPath.row]

        // 3: now push it onto the navigation controller
        navigationController?.pushViewController(vc, animated: true)
    }
}
```
- detail again
```swift
if let imageToLoad = selectedImage {
    imageView.image  = UIImage(named: imageToLoad)
}
```
