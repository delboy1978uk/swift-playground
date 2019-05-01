# project 12 UserDefaults
- create a single view app for testing purposes (we will use the names to faces app later)
- add defaults to viewDidLoad()
```swift
let defaults = UserDefaults.standard
```
- add some settings
```swift
defaults.set(25, forKey: "Age")
defaults.set(true, forKey: "UseTouchID")
defaults.set(CGFloat.pi, forKey: "Pi")
defaults.set("Paul Hudson", forKey: "Name")
defaults.set(Date(), forKey: "LastRun")

let array = ["Hello", "World"]
defaults.set(array, forKey: "SavedArray")

let dict = ["Name": "Paul", "Country": "UK"]
defaults.set(dict, forKey: "SavedDict")
```
Here are the types
- integer(forKey:) returns an integer if the key existed, or 0 if not.
- bool(forKey:) returns a boolean if the key existed, or false if not.
- float(forKey:) returns a float if the key existed, or 0.0 if not.
- double(forKey:) returns a double if the key existed, or 0.0 if not.
- object(forKey:) returns Any? so you need to conditionally typecast it to your data type.
When using  object(forKey:) you might need to:
- Use as! to force typecast your object to the data type it should be.
- Use as? to optionally typecast your object to the type it should be.
You can use a nil coalescing operator when reading back
```swift
let array = defaults.object(forKey:"SavedArray") as? [String] ?? [String]()
let dict = defaults.object(forKey: "SavedDict") as? [String: String] ?? [String: String]()
```
## getting names to faces app saving data
- copy project 10 into project 12 folder and open in xcode
Rules for storing user data are as follows
1 All your data types must be one of the following: boolean, integer, float, double, string, array, dictionary, Date, or a class that fits rule 2.
2 If your data type is a class, it must conform to the NSCoding protocol, which is used for archiving object graphs.
3 If your data type is an array or dictionary, all the keys and values must match rule 1 or rule 2.
- make the person class conform to `NSCoding`
```swift
class Person: NSObject, NSCoding {
```
 - implement the required methods
```swift
required init(coder aDecoder: NSCoder) {
    name = aDecoder.decodeObject(forKey: "name") as? String ?? ""
    image = aDecoder.decodeObject(forKey: "image") as? String ?? ""
}

func encode(with aCoder: NSCoder) {
    aCoder.encode(name, forKey: "name")
    aCoder.encode(image, forKey: "image")
}
```
- add a save method to the viewcontroller
```swift
func save() {
    if let savedData = try? NSKeyedArchiver.archivedData(withRootObject: people, requiringSecureCoding: false) {
        let defaults = UserDefaults.standard
        defaults.set(savedData, forKey: "people")
    }
}
```
- add the code that loads back the settings into `viewDidLoad()`
```swift
let defaults = UserDefaults.standard

if let savedPeople = defaults.object(forKey: "people") as? Data {
    if let decodedPeople = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(savedPeople) as? [Person] {
        people = decodedPeople
    }
}
```
## using Codable

