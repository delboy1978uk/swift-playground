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
## getting nafes to faces app saving data
- copy project 10 into project 12 folder and open in xcode
- 


