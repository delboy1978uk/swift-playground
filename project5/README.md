# project 5
- make view controller extend uitableviewcontroller
- go to interface builder, delete existing view controller
- drag in table view controller
- use identity inspector, change class to ViewController
- choose cell and give identifier Word
- attributes inspector, click controller, choose is Initial Controller
- Editor > Embed In > Navigation Controller
- drag start.txt word list file into project (check copy if needed)
- add arrays to view controller
```swift
var allWords = [String]()
var usedWords = [String]()
```
- add to viewDidLoad
```swift
if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
    if let startWords = try? String(contentsOf: startWordsURL) {
        allWords = startWords.components(separatedBy: "\n")
    }
}

if allWords.isEmpty {
    allWords = ["silkworm"]
}
```
- add startGame() functiuon
```swift
func startGame() {
    title = allWords.randomElement()
    usedWords.removeAll(keepingCapacity: true)
    tableView.reloadData()
}
```
- add `startGame() to end of viewDidLoad()
- add table row code
```swift
override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return usedWords.count
}

override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Word", for: indexPath)
    cell.textLabel?.text = usedWords[indexPath.row]
    return cell
}
```
- add a bar button under super.viewDidLoad()
```swift
navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promptForAnswer))
```
- add prompt for answer method
```swift
@objc func promptForAnswer() {
    let ac = UIAlertController(title: "Enter answer", message: nil, preferredStyle: .alert)
    ac.addTextField()

    let submitAction = UIAlertAction(title: "Submit", style: .default) { [weak self, weak ac] action in
        guard let answer = ac?.textFields?[0].text else { return }
        self?.submit(answer)
    }

    ac.addAction(submitAction)
    present(ac, animated: true)
}
```
add placeholder check methods
```swift
func isPossible(word: String) -> Bool {
    guard var tempWord = title?.lowercased() else { return false }

    for letter in word {
        if let position = tempWord.firstIndex(of: letter) {
            tempWord.remove(at: position)
        } else {
            return false
        }
    }

    return true
}

func isOriginal(word: String) -> Bool {
    return !usedWords.contains(word)
}

func isReal(word: String) -> Bool {
    let checker = UITextChecker()
    let range = NSRange(location: 0, length: word.utf16.count)
    let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")

    return misspelledRange.location == NSNotFound
}
```
- define vars in submit() function
```swift
    let errorTitle: String!
    let errorMessage: String!
```
- refactor if statements and add 3 else to handle errors
```swift
    } else {
                errorTitle = "Word not recognised"
                errorMessage = "You can't just make them up, you know!"
            }
        } else {
            errorTitle = "Word used already"
            errorMessage = "Be more original!"
        }
    } else {
        guard let title = title?.lowercased() else { return }
        errorTitle = "Word not possible"
        errorMessage = "You can't spell that word from \(title)"
    }

    let ac = UIAlertController(title: errorTitle, message: errorMessage, preferredStyle: .alert)
    ac.addAction(UIAlertAction(title: "OK", style: .default))
    present(ac, animated: true)
```
## challenges
- Disallow answers that are shorter than three letters or are just our start word. For the three-letter check, the easiest thing to do is put a check into isReal() that returns false if the word length is under three letters. For the second part, just compare the start word against their input word and return false if they are the same.
- Refactor all the else statements we just added so that they call a new method called showErrorMessage(). This should accept an error message and a title, and do all the UIAlertController work from there.
- Add a left bar button item that calls startGame(), so users can restart with a new word whenever they want to.
- To trigger the bug, look for a three-letter word in your starting word, and enter it with an uppercase letter. Once it appears in the table, try entering it again all lowercase – you’ll see it gets entered. Can you figure out what causes this and how to fix it?
### challenge 1
- add into isPossible()
```swift
if word == tempWord || word.count < 3 { return false }
```
### challenge 2
- create function, remove call at bottom of submit
```swift
    func showErrorMessage(errorTitle: String, errorMessage: String) {
        let ac = UIAlertController(title: errorTitle, message: errorMessage, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
```
- delete two vars errorTitle and errorMessage
- refactor else statements
```swift
        } else {
                    showErrorMessage(errorTitle: "Word not recognised", errorMessage: "You can't just make them up, you know!")
                }
            } else {
                showErrorMessage(errorTitle: "Word used already", errorMessage: "Be more original!")
            }
        } else {
            guard let title = title?.lowercased() else { return }
            showErrorMessage(errorTitle: "Word not possible", errorMessage: "You can't spell that word from \(title)")
        }
        
```
### challenge 3
- add to viewDidLoad()
```swift
navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh , target: self, action: #selector(startGame))
```
- add `@objc` to start of function startGame()
### bonus challenge
- fix add answer to use lowerAnswer
```swift
usedWords.insert(lowerAnswer, at: 0)
```

