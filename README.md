# swift-playground
### data types
```swift
import UIKit


let someConstant = 5 // let for a constant

var name: String = "Derek Stephen McLean" // var for a variable

var age: Int = 41

var latitude: Double = 36.166667 // doubles are twice as accuracte as a float

var longitude: Float = -86.783333

var missABeat: Bool  = false
```
### operators
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
### string interpolation
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
### arrays 
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

