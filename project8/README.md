# project8
## setting up
- create new single view app, name project8
- select ipad only in the device dropdown for the deployment info
## building a UIKit user interface programmatically
- add properties to view controller
```swift
var cluesLabel: UILabel!
var answersLabel: UILabel!
var currentAnswer: UITextField!
var scoreLabel: UILabel!
var letterButtons = [UIButton]()
```
- create a custom loadView()
```swift
override func loadView() {
    view = UIView()
    view.backgroundColor = .white

    // more code to come!
}
```
### adding 3 labels
- replace // more code to come!
```swift
scoreLabel = UILabel()
scoreLabel.translatesAutoresizingMaskIntoConstraints = false
scoreLabel.textAlignment = .right
scoreLabel.text = "Score: 0"
view.addSubview(scoreLabel)
```
- add layout constraints
```swift
NSLayoutConstraint.activate([
    scoreLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
    scoreLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),

    // more constraints to be added here!
])
```
- add the other two labels above the contraints
```swift
cluesLabel = UILabel()
cluesLabel.translatesAutoresizingMaskIntoConstraints = false
cluesLabel.font = UIFont.systemFont(ofSize: 24)
cluesLabel.text = "CLUES"
cluesLabel.numberOfLines = 0
view.addSubview(cluesLabel)

answersLabel = UILabel()
answersLabel.translatesAutoresizingMaskIntoConstraints = false
answersLabel.font = UIFont.systemFont(ofSize: 24)
answersLabel.text = "ANSWERS"
answersLabel.numberOfLines = 0
answersLabel.textAlignment = .right
view.addSubview(answersLabel)
```
- add the following constraints
```swift
// pin the top of the clues label to the bottom of the score label
cluesLabel.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor),

// pin the leading edge of the clues label to the leading edge of our layout margins, adding 100 for some space
cluesLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 100),

// make the clues label 60% of the width of our layout margins, minus 100
cluesLabel.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, multiplier: 0.6, constant: -100),

// also pin the top of the answers label to the bottom of the score label
answersLabel.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor),

// make the answers label stick to the trailing edge of our layout margins, minus 100
answersLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -100),

// make the answers label take up 40% of the available space, minus 100
answersLabel.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, multiplier: 0.4, constant: -100),

// make the answers label match the height of the clues label
answersLabel.heightAnchor.constraint(equalTo: cluesLabel.heightAnchor),
```
- for debugging purposes add some colours so you can see the layout
```swift
cluesLabel.backgroundColor = .red
answersLabel.backgroundColor = .blue
```
- cmd-r and look at the layout so far
### entering answers
- add an answer fiels
```swift
currentAnswer = UITextField()
currentAnswer.translatesAutoresizingMaskIntoConstraints = false
currentAnswer.placeholder = "Tap letters to guess"
currentAnswer.textAlignment = .center
currentAnswer.font = UIFont.systemFont(ofSize: 44)
currentAnswer.isUserInteractionEnabled = false
view.addSubview(currentAnswer)
```
- add some constraints
```
currentAnswer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
currentAnswer.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
currentAnswer.topAnchor.constraint(equalTo: cluesLabel.bottomAnchor, constant: 20),
```
- cmd-r again and see results
- add submit and clear buttons
```swift
let submit = UIButton(type: .system)
submit.translatesAutoresizingMaskIntoConstraints = false
submit.setTitle("SUBMIT", for: .normal)
view.addSubview(submit)

let clear = UIButton(type: .system)
clear.translatesAutoresizingMaskIntoConstraints = false
clear.setTitle("CLEAR", for: .normal)
view.addSubview(clear)
```
- add their constraints
```swift
submit.topAnchor.constraint(equalTo: currentAnswer.bottomAnchor),
submit.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -100),
submit.heightAnchor.constraint(equalToConstant: 44),

clear.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 100),
clear.centerYAnchor.constraint(equalTo: submit.centerYAnchor),
clear.heightAnchor.constraint(equalToConstant: 44),
```
- cmd-r check it out
### adding loads of buttons
- add this below original view creation code
```swift
let buttonsView = UIView()
buttonsView.translatesAutoresizingMaskIntoConstraints = false
view.addSubview(buttonsView)
```
- add the constraints
```swift
buttonsView.widthAnchor.constraint(equalToConstant: 750),
buttonsView.heightAnchor.constraint(equalToConstant: 320),
buttonsView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
buttonsView.topAnchor.constraint(equalTo: submit.bottomAnchor, constant: 20),
buttonsView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -20)
```
- add a debug background colour then cmd-r to check it out
```swift
buttonsView.backgroundColor = .green
```
Auto layout has picked to stretch our first label, since we now have something fixed to the bottom
- change the stretching priorities of the other labels and load again (add after creation)
```swift
cluesLabel.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
answersLabel.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
```
- loop and create buttons in our button view (add after constraints)
```swift
// set some values for the width and height of each button
let width = 150
let height = 80

// create 20 buttons as a 4x5 grid
for row in 0..<4 {
    for col in 0..<5 {
        // create a new button and give it a big font size
        let letterButton = UIButton(type: .system)
        letterButton.titleLabel?.font = UIFont.systemFont(ofSize: 36)

        // give the button some temporary text so we can see it on-screen
        letterButton.setTitle("WWW", for: .normal)

        // calculate the frame of this button using its column and row
        let frame = CGRect(x: col * width, y: row * height, width: width, height: height)
        letterButton.frame = frame

        // add it to the buttons view
        buttonsView.addSubview(letterButton)

        // and also to our letterButtons array
        letterButtons.append(letterButton)
    }
}
```
## loading a level and adding button targets
- 
