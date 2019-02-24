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
### dictionaries
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
### conditionals
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
### loops
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
### switch statements
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
