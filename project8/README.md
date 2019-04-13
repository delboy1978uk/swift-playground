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
- create level1.txt
```
HA|UNT|ED: Ghosts in residence
LE|PRO|SY: A Biblical skin disease
TW|ITT|ER: Short online chirping
OLI|VER: Has a Dickensian twist
ELI|ZAB|ETH: Head of state, British style
SA|FA|RI: The zoological web
POR|TL|AND: Hipster heartland
```
- add some properties
```swift
var activatedButtons = [UIButton]()
var solutions = [String]()

var score = 0
var level = 1
```
- add methods below view did load 
```swift
@objc func letterTapped(_ sender: UIButton) {
}

@objc func submitTapped(_ sender: UIButton) {
}

@objc func clearTapped(_ sender: UIButton) {
}
```
- tell submit to run submit tapped when tapped, add after submit creation
```swift
submit.addTarget(self, action: #selector(submitTapped), for: .touchUpInside)
```
- the same for clear
```swift
clear.addTarget(self, action: #selector(clearTapped), for: .touchUpInside)
```
- and letter button, add within loop
```swift
letterButton.addTarget(self, action: #selector(letterTapped), for: .touchUpInside)
```
### loading the text file
- create load level function
```swift
func loadLevel() {
    var clueString = ""
    var solutionString = ""
    var letterBits = [String]()

    if let levelFileURL = Bundle.main.url(forResource: "level\(level)", withExtension: "txt") {
        if let levelContents = try? String(contentsOf: levelFileURL) {
            var lines = levelContents.components(separatedBy: "\n")
            lines.shuffle()

            for (index, line) in lines.enumerated() {
                let parts = line.components(separatedBy: ": ")
                let answer = parts[0]
                let clue = parts[1]

                clueString += "\(index + 1). \(clue)\n"

                let solutionWord = answer.replacingOccurrences(of: "|", with: "")
                solutionString += "\(solutionWord.count) letters\n"
                solutions.append(solutionWord)

                let bits = answer.components(separatedBy: "|")
                letterBits += bits
            }
        }
    }

    // Now configure the buttons and labels
    cluesLabel.text = clueString.trimmingCharacters(in: .whitespacesAndNewlines)
    answersLabel.text = solutionString.trimmingCharacters(in: .whitespacesAndNewlines)

    letterBits.shuffle()

    if letterBits.count == letterButtons.count {
        for i in 0 ..< letterButtons.count {
            letterButtons[i].setTitle(letterBits[i], for: .normal)
        }
    }
}
```
- add to view did load 
```swift
loadLevel()
```
## game logic - firstIndex(of:) and joined()
- fill in letter tapped function
```swift
@objc func letterTapped(_ sender: UIButton) {
    guard let buttonTitle = sender.titleLabel?.text else { return }
    currentAnswer.text = currentAnswer.text?.appending(buttonTitle)
    activatedButtons.append(sender)
    sender.isHidden = true
}
```
- fill in clear tapped
```swift
@objc func clearTapped(_ sender: UIButton) {
    currentAnswer.text = ""

    for btn in activatedButtons {
        btn.isHidden = false
    }

    activatedButtons.removeAll()
}
```
- fill in submit tapped
```swift
@objc func submitTapped(_ sender: UIButton) {
    guard let answerText = currentAnswer.text else { return }

    if let solutionPosition = solutions.firstIndex(of: answerText) {
        activatedButtons.removeAll()

        var splitAnswers = answersLabel.text?.components(separatedBy: "\n")
        splitAnswers?[solutionPosition] = answerText
        answersLabel.text = splitAnswers?.joined(separator: "\n")

        currentAnswer.text = ""
        score += 1

        if score % 7 == 0 {
            let ac = UIAlertController(title: "Well done!", message: "Are you ready for the next level?", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Let's go!", style: .default, handler: levelUp))
            present(ac, animated: true)
        }
    }
}
```
- create a levelUp() function
```swift
func levelUp(action: UIAlertAction) {
    level += 1
    solutions.removeAll(keepingCapacity: true)

    loadLevel()

    for btn in letterButtons {
        btn.isHidden = false
    }
}
```
## Property Observers
- refactor the scxore property, this is how you add an observer
```swift
var score = 0 {
    didSet {
        scoreLabel.text = "Score: \(score)"
    }
}
```
## challenges
- Use the techniques you learned in project 2 to draw a thin gray line around the buttons view, to make it stand out from the rest of the UI.
- If the user enters an incorrect guess, show an alert telling them they are wrong. You’ll need to extend the submitTapped() method so that if firstIndex(of:) failed to find the guess you show the alert.
- Try making the game also deduct points if the player makes an incorrect guess. Think about how you can move to the next level – we can’t use a simple division remainder on the player’s score any more, because they might have lost some points.
### challenge 1
- add this in viewDidLoade(), remove background color
```swift
buttonsView.layer.borderWidth = 1
buttonsView.layer.borderColor = UIColor.black.cgColor 
```
### challenge 2
- add else statement in submitTapped
```swift
} else {
    displayYoureWrongAlert(wronAgnswer: answerText)
}
```
- add the displayYoureWrongAlert
```swift
func displayYoureWrongAlert(wronAgnswer: String) {
    let ac = UIAlertController(title: "Wrong!", message: "You thought \(wronAgnswer) was the anser?\nTry again!!!", preferredStyle: .alert)
    ac.addAction(UIAlertAction(title: "Fine", style: .default))
    present(ac, animated: true)
}
```
## challenge 3 
- @todo