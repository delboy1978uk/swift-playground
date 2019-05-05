# project 18 - debugging
- create a single view app
## print
```swift
print("I'm inside the viewDidLoad() method!")
print(1, 2, 3, 4, 5)
print(1, 2, 3, 4, 5, separator: "-")
print("Some message", terminator: "")
```
## assert
Asserts only work in the dev environment
```swift
assert(1 == 1, "Maths failure!")
assert(1 == 2, "Maths failure!")
assert(myReallySlowMethod() == true, "The slow method returned false, which is a bad thing!")
```
## debugging
- add to `viewDidLoad()`
```swift
for i in 1 ... 100 {
    print("Got number \(i)")
}
```
- click the line number where `print()` is called and it will light up blue, setting a breakpoint
- run the app and it will pause
- step over icon or F6
- continue icon runs till next breakpoint or cmd ctrl y
- View > Debug Area > Activate Console
- type `p i` to print i in the console
- right click brerakpoint, add condition 
```swift
i % 10 == 0
```
- bring up breakpoint navigator, cmd 8, or View > Navigators > Show Breakpoint Navigator
- click the + at the bottom left add exception brewakpoint
## view debugging 
- close the project and open up a more interesting one like projectf 13
- run the app and then in xcode choose Debug > View Debugging > Capture View Hierarchy
