# swift-playground
## data types
```swift
import UIKit


let someConstant = 5 // let for a constant

var name: String = "Derek Stephen McLean" // var for a variable

var age: Int = 41

var latitude: Double = 36.166667 // doubles are twice as accuracte as a float

var longitude: Float = -86.783333

var missABeat: Bool  = false
```
## operators
```swift
var a = 10
a = a + 1
a = a - 1
a = a * a

var b = 10
b += 10
b -= 10

var c = 1.1
var d = 2.2
var e = c + d

var name1 = "Juliet"
var name2 = "Romeo"
var both = name1 + " and " + name2

var mod = 9 % 3
mod = 10 % 3

e > 3
e >= 3
e > 4
e < 4

name == "Derek Stephen McLean"

missABeat
!missABeat
```
## string interpolation
```swift
import UIKit

var name = "Delboy"
var age = 41
var latitude = 50.166667

"Your name is \(name)"
"Your name is " + name // this is less efficient

"Your name is \(name), your age is \(age), and your latitude is \(latitude)"
"You are \(age) years old. In another \(age) years you will be \(age * 2)."
```
## arrays 
```swift
import UIKit

var evenNumbers = [2, 4, 6, 8]
var songs: [String]  = ["Shake it Off", "You Belong with Me", "Back to December"]
//var songs: [Any] = ["string", 5, 7.2]
songs[0]
songs[1]
songs[2]
type(of: songs)
```
#### creating arrays
```swift
// var songs: [String] = [] // is ok
var songs = [String]() // does the same
```
#### array operators
```swift
var songs = ["Shake it Off", "You Belong with Me", "Love Story"]
var songs2 = ["Today was a Fairytale", "Welcome to New York", "Fifteen"]
var both = songs + songs2
both += ["Everything has Changed"]
```
## dictionaries
```swift
var person = [
    "first": "Taylor",
    "middle": "Alison",
    "last": "Swift",
    "month": "December",
    "website": "taylorswift.com"
]

person["middle"]
person["month"]
```
## conditionals
```swift
import UIKit

var action: String = ""
var person: String = "hater"

if person == "hater" {
    action = "hate"
} else if person == "player" {
    action = "play"
} else {
    action = "cruise"
}

var stayOutTooLate = true
var nothingInBrain = true

if stayOutTooLate && nothingInBrain {
    action = "cruise"
}

if !stayOutTooLate && !nothingInBrain {
    action = "do something else"
}
```
## loops
```swift
import UIKit

print("1 x 10 is \(1 * 10)")
print("2 x 10 is \(2 * 10)")
print("3 x 10 is \(3 * 10)")
print("4 x 10 is \(4 * 10)")
print("5 x 10 is \(5 * 10)")
print("6 x 10 is \(6 * 10)")
print("7 x 10 is \(7 * 10)")
print("8 x 10 is \(8 * 10)")
print("9 x 10 is \(9 * 10)")
print("10 x 10 is \(10 * 10)")

// 1 ..< 5 will count 1, 2, 3, 4
for i in 1...10 {
    print("\(i) x 10 is \(i * 10)")
}

var str = "Fakers gonna"

// _ when you don't need index
for _ in 1 ... 5 {
    str += " fake"
}

print(str)
```
#### looping over arrays
```swift
var songs = ["Shake it Off", "You Belong with Me", "Look What You Made Me Do"]

for song in songs {
    print("My favorite song is \(song)")
}
```
### while loops
```swift
import UIKit

var counter = 0

while true {
    print("Counter is now \(counter)")
    counter += 1
    
    if counter == 78 {
        break
    }
}

var songs = ["Shake it Off", "You Belong with Me", "Look What You Made Me Do"]

for song in songs {
    if song == "You Belong with Me" {
        continue
    }
    
    print("\(song) is a great song")
}
```
## switch statements
```swift
import UIKit

let liveAlbums = 2
let studioAlbums = 5

// no need to break, it breaks by default
// use fallthrough to not break

switch liveAlbums {
    case 0:
        print("You're just starting out")
    
    case 1:
        print("You just released iTunes Live From SoHo")
    
    case 2:
        print("You just released Speak Now World Tour")
    
    default:
        print("Have you done something new?")
}

// with range operator
switch studioAlbums {
    case 0...1:
        print("You're just starting out")
    
    case 2...3:
        print("You're a rising star")
    
    case 4...5:
        print("You're world famous!")
    
    default:
        print("Have you done something new?")
}
```
## functions
```swift
import UIKit

func favoriteAlbum() {
    print("My favorite is Fearless")
}

favoriteAlbum()
```
#### external and internal parameter names
Normal version, one param
```swift
func countLettersInString(string: String) {
    print("The string \(string) has \(string.count) letters.")
}

countLettersInString(string: "Hello")
```
aliased param way:
```swift
func countLettersInString(myString str: String) {
    print("The string \(str) has \(str.count) letters.")
}

countLettersInString(myString: "Hello")
```
if you dont need keys for args:
```swift
// use _ if key is not needed
func countLettersInString2(_ str: String) {
    print("The string \(str) has \(str.count) letters.")
}

countLettersInString2("Hello")
```
Many coders prefer using `in`, `for`, and `with` instead of `_` (i disagree with keyword `for` though!
```swift
func countLetters(in string: String) {
    print("The string \(string) has \(string.count) letters.")
}

countLetters(in: "Hello")
```
#### return values
```swift
import UIKit

func albumIsTaylor(name: String) -> Bool {
    if name == "Taylor Swift" { return true }
    if name == "Fearless" { return true }
    if name == "Speak Now" { return true }
    if name == "Red" { return true }
    if name == "1989" { return true }
    
    return false
}

if albumIsTaylor(name: "Red") {
    print("That's one of hers!")
} else {
    print("Who made that?!")
}

if albumIsTaylor(name: "Blue") {
    print("That's one of hers!")
} else {
    print("Who made that?!")
}
```
### optionals
Note the return type has a ? 
```swift
func getHaterStatus(weather: String) -> String? {
    if weather == "sunny" {
        return nil
    } else {
        return "Hate"
    }
}


var status: String?
status = getHaterStatus(weather: "rainy")

func takeHaterAction(status: String) {
    if status == "Hate" {
        print("Hating")
    }
}

// if let casts the var to type
if let haterStatus = getHaterStatus(weather: "rainy") {
    takeHaterAction(status: haterStatus)
} else {
    //optional did not contain a value
}
```
#### force unwrapping
```swift
func yearAlbumReleased(name: String) -> Int? {
    if name == "Taylor Swift" { return 2006 }
    if name == "Fearless" { return 2008 }
    if name == "Speak Now" { return 2010 }
    if name == "Red" { return 2012 }
    if name == "1989" { return 2014 }

    return nil
}

var year = yearAlbumReleased(name: "Red")

// note the ! without it it displays Optional(valuehere)
if year == nil {
    print("There was an error")
} else {
    print("It was released in \(year!)")
}

var blah :String! // implicitly unwraped optional. be careful!
```
### optional chaining
```swift

func albumReleased(year: Int) -> String? {
    switch year {
    case 2006: return "Taylor Swift"
    case 2008: return "Fearless"
    case 2010: return "Speak Now"
    case 2012: return "Red"
    case 2014: return "1989"
    default: return nil
    }
}

// only if optional is set will anything after ? run
let album = albumReleased(year: 2006)?.uppercased()
print("The album is \(album)")

// you can have as many as you like
// let album = albumReleased(year: 2006)?.someOptionalValue?.someOtherOptionalValue?.whatever
```
#### nil coalescing operator
```swift
let otherAlbum = albumReleased(year: 2008) ?? "unknown"
print("The album is \(otherAlbum)")
```
### enumerations
```swift
enum WeatherType {
    case sun
    case cloud
    case rain
    case wind
    case snow
}

func getHaterStatus(weather: WeatherType) -> String? {
    switch weather {
    case .sun:
        return nil
    case .cloud, .wind:
        return "dislike"
    case .rain, .snow:
        return "hate"
    }
}

getHaterStatus(weather: .cloud)
```
### structs
```swift
import UIKit

struct Person {
    var clothes: String
    var shoes: String
    
    func describe() {
        print("I like wearing \(clothes) with \(shoes)")
    }
}

let taylor = Person(clothes: "T-shirts", shoes: "sneakers")
let del = Person(clothes: "kilt", shoes: "army boots")

print(taylor.clothes)
print(del.shoes)

var taylorCopy = taylor
taylorCopy.shoes = "flip flops"

print(taylor)
print(taylorCopy)

del.describe()
```
### classes
```swift
import UIKit

class Person {
    var clothes: String
    var shoes: String
    
    init(clothes: String, shoes: String) {
        self.clothes = clothes
        self.shoes = shoes
    }
}

let del = Person(clothes: "kilt", shoes: "boots");
```
#### inheritance
```swift
class CountrySinger: Singer {
    override func sing() {
        print("Trucks, guitars, and liquor")
    }
}

class HeavyMetalSinger: Singer {
    var noiseLevel: Int

    init(name: String, age: Int, noiseLevel: Int) {
        self.noiseLevel = noiseLevel
        super.init(name: name, age: age)
    }

    override func sing() {
        print("Grrrrr rargh rargh rarrrrgh!")
    }
}
```
### properties
#### observers
```swift

```
#### computed
```swift
struct Person {
    var age: Int
    
    var ageInDogYears: Int {
        get {
            return age * 7
        }
    }
}

var fan = Person(age: 41)
print(fan.ageInDogYears)
```
If only using for reading we can omit the get{}
```swift
var ageInDogYears: Int {
    return age * 7
}
```
#### static properties
```swift
struct TaylorFan {
    static var favoriteSong = "Look What You Made Me Do"

    var name: String
    var age: Int
}

let fan = TaylorFan(name: "James", age: 25)
print(TaylorFan.favoriteSong)
```
### access control
- public
- internal
- fileprivate
- private
```swift
class TaylorFan {
    private var name: String!
}
```
### polymorphism
```swift
class Album {
    var name: String
    
    init(name: String) {
        self.name = name
    }
    
    func getPerformance() -> String {
        return "The album \(name) sold lots"
    }
}

class StudioAlbum: Album {
    var studio: String
    
    init(name: String, studio: String) {
        self.studio = studio
        super.init(name: name)
    }
    
    override func getPerformance() -> String {
        return "The studio album \(name) sold lots"
    }
}

class LiveAlbum: Album {
    var location: String
    
    init(name: String, location: String) {
        self.location = location
        super.init(name: name)
    }
    
    override func getPerformance() -> String {
        return "The live album \(name) sold lots"
    }
}

var taylorSwift = StudioAlbum(name: "Taylor Swift", studio: "The Castles Studios")
var fearless = StudioAlbum(name: "Speak Now", studio: "Aimeeland Studio")
var iTunesLive = LiveAlbum(name: "iTunes Live from SoHo", location: "New York")

var allAlbums: [Album] = [taylorSwift, fearless, iTunesLive]

for album in allAlbums {
    print(album.getPerformance())
}
```
### typecasting
```swift
for album in allAlbums {
    print(album.getPerformance())

    if let studioAlbum = album as? StudioAlbum {
        print(studioAlbum.studio)
    } else if let liveAlbum = album as? LiveAlbum {
        print(liveAlbum.location)
    }
}
```
You can force it at your own risk using `!`
```swift
var taylorSwift = StudioAlbum(name: "Taylor Swift", studio: "The Castles Studios")
var fearless = StudioAlbum(name: "Speak Now", studio: "Aimeeland Studio")

var allAlbums: [Album] = [taylorSwift, fearless]

for album in allAlbums {
    let studioAlbum = album as! StudioAlbum
    print(studioAlbum.studio)
}
```
or more efficiently:
```swift
for album in allAlbums as! [StudioAlbum] {
    print(album.studio)
}
```
or at array level with nil coalescing
```swift
for album in allAlbums as? [LiveAlbum] ?? [LiveAlbum]() {
    print(album.location)
}
```
#### converting types
```swift
let number = 5
let text = String(number)
print(text)
```
### closures
```swift
import UIKit

let vw = UIView()

UIView.animate(withDuration: 0.5, animations: {
    vw.alpha = 0
})

// or trailing style, if it's the last arg

UIView.animate(withDuration: 0.5) {
    vw.alpha = 0
}
```
