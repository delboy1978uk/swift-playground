# project 2
## setup
- new project
- iOS single view app
- Product name Project 2
- org identifier uk.co.mcleandigital
- uncheck boxes, next
## layout
- interface builder
- click in view controller
- Editor > Navigation Controller
- object library
- drag 3 buttons in
- size inspector ruler icon
- y coordinates 100, 230, 360
- click first button
- ctrl drag out view, highlights blue
- shift click (multiple) Top Space to Safe Area, Center Horizontally in Safe Area
- click away to deslect
- click assets folder
- drag flag images into assets folder
- interface builder, first button, attributes inspector
- delete label text 'button'
- select image from dropdown
- repeat other 2 buttons
- ctrl drag second button to first
- shift click Vertical Spacing, Center Horizontally
- repeat ctrl dragging third to second button
- select all 3 buttons
- Editor > Resolve Auto Layout Issues > Update Frames
- Alt+Cmd+Return or View > Assistant Editor > Show Assistant Editor
- ctrl drag buttons, flag1 2 & 3
## hooking it up
- view controller
```swift
var countries = [String]()
var score = 0
```
- view did load
```swift
countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
```
- add function
```swift
func askQuestion() {
    button1.setImage(UIImage(named: countries[0]), for: .normal)
    button2.setImage(UIImage(named: countries[1]), for: .normal)
    button3.setImage(UIImage(named: countries[2]), for: .normal)
}
```
- add call to `askQuestion()` at end of view did load
### fix image border
- back in view did load before ask
```swift
flag1.layer.borderWidth = 1
flag2.layer.borderWidth = 1
flag3.layer.borderWidth = 1

flag1.layer.borderColor = UIColor.lightGray.cgColor
flag2.layer.borderColor = UIColor.lightGray.cgColor
flag3.layer.borderColor = UIColor(red: 1.0, green: 0.6, blue: 0.2, alpha: 1.0).cgColor
```
## random numbers
- add to ask question at top
```swift
countries.shuffle()
```
- add view controller property
```swift
var correctAnswer = 0
```
- add to bottom of addQuestion()
```swift
correctAnswer = Int.random(in: 0...2)
title = countries[correctAnswer].uppercased()
```
## creating IBActions
- open interface builder and assistant editor
- top left of assistant change manual to Automatic > ViewController
- ctrl-drag first flag into controller
- choose Action, Type to UIButton, and buttonTapped for the name
- ctrl drag flags 2 and 3 onto the buttonTapped method
- click flags, attributes inspector, view section, tag each flag as 0, 1, and 2
- add to buttonTapped method
```swift
var title: String

if sender.tag == correctAnswer {
    title = "Correct"
    score += 1
} else {
    title = "Wrong"
    score -= 1
}

// display a scores alert
let ac = UIAlertController(title: title, message: "Your score is \(score).", preferredStyle: .alert)
ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
present(ac, animated: true)
```
- notice the crap error message, it means askQuestion now needs a UIAlertAction passed to it - default it to nil
```
func askQuestion(action: UIAlertAction! = nil) {
```
## challenge
- Try showing the player’s score in the navigation bar, alongside the flag to guess.
- Keep track of how many questions have been asked, and show one final alert controller after they have answered 10. This should show their final score.
- When someone chooses the wrong flag, tell them their mistake in your alert message – something like “Wrong! That’s the flag of France,” for example.
### first challenge
- edit ask question
```swift
title = "Which is " + countries[correctAnswer].uppercased() + "? Current score \(score)"
```
### second challenge
- refactor code like so:
```swift
    func resetGame(action: UIAlertAction! = nil) {
        score = 0
        currentQuestion = 0
        askQuestion()
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        var title: String
        var message: String
        var label: String
        var handler = askQuestion
        
        currentQuestion += 1
        
        if sender.tag == correctAnswer {
            title = "Correct"
            score += 1
        } else {
            title = "Wrong"
            score -= 1
        }
        
        if (currentQuestion < 10) {
            message = "Your score is \(score)."
            label = "Continue"
        } else {
            message = "Game over! Your final score is \(score)."
            handler = resetGame
            label = "Start Again"
        }
        
        // display a scores alert
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: label, style: .default, handler: handler))
        present(ac, animated: true)
    }
```
### third challenge
- refactor like so
```swift
        if sender.tag == correctAnswer {
            title = "Correct"
            message = ""
            score += 1
        } else {
            title = "Wrong"
            message = "The correct answer was flag " + (correctAnswer + 1)  + ".\n"
            score -= 1
        }
        
        if (currentQuestion < 10) {
            message += "Your score is \(score)."
            label = "Continue"
        } else {
            message += "Game over! Your final score is \(score)."
            handler = resetGame
            label = "Start Again"
        }
```
