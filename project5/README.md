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

