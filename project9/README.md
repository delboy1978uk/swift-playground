# project 9
- copy project 7 folder and call it project 9
To run async code we can wrap code with this line and a closing brance
```swift
DispatchQueue.global().async { [weak self] in
```
And to get the user-initiated quality of service rather than use the default queue
```swift
DispatchQueue.global(qos: .userInitiated).async { [weak self] in
```
- refactor viewDidLoad()
```
DispatchQueue.global(qos: .userInitiated).async { [weak self] in
    if let url = URL(string: urlString) {
        if let data = try? Data(contentsOf: url) {
            self?.parse(json: data)
            return
        }
    }
}

showError()
```
## DispatchQueue.main
- run the code now and notice the error happens because code was ran asynchronously
- remember now that it's never OK to do user interface work on the background thread.
- find `tableView.reloadData()` in the `parse()` method and change to 
```swift
DispatchQueue.main.async { [weak self] in
    self?.tableView.reloadData()
}
```
- go back and remove `showError()` and instead put it in the dispatch closure with `self?.` in front:
```swift
self?.showError()
```
Now show Error is in a background thread - doing UI stuff. 
- refactor 
```swift
func showError() {
        DispatchQueue.main.async { [weak self] in
        let ac = UIAlertController(title: "Loading error", message: "There was a problem loading the feed; please check your connection and try again.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        self?.present(ac, animated: true)
    }
}
```
## performSelector(inBackground:)
- use `performSelector(inBackground:)` and `performSelector(onMainThread:)` to refactor
```swift
override func viewDidLoad() {
    super.viewDidLoad()

    performSelector(inBackground: #selector(fetchJSON), with: nil)
}

@objc func fetchJSON() {
    let urlString: String

    if navigationController?.tabBarItem.tag == 0 {
        urlString = "https://api.whitehouse.gov/v1/petitions.json?limit=100"
    } else {
        urlString = "https://api.whitehouse.gov/v1/petitions.json?signatureCountFloor=10000&limit=100"
    }

    if let url = URL(string: urlString) {
        if let data = try? Data(contentsOf: url) {
            parse(json: data)
            return
        }
    }

    performSelector(onMainThread: #selector(showError), with: nil, waitUntilDone: false)
}

func parse(json: Data) {
    let decoder = JSONDecoder()

    if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
        petitions = jsonPetitions.results
        tableView.performSelector(onMainThread: #selector(UITableView.reloadData), with: nil, waitUntilDone: false)
    }
}

@objc func showError() {
    let ac = UIAlertController(title: "Loading error", message: "There was a problem loading the feed; please check your connection and try again.", preferredStyle: .alert)
    ac.addAction(UIAlertAction(title: "OK", style: .default))
    present(ac, animated: true)
}
```
- and add an else to the parse() mnethod
```swift
if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
    petitions = jsonPetitions.results
    tableView.performSelector(onMainThread: #selector(UITableView.reloadData), with: nil, waitUntilDone: false)
} else {
    performSelector(onMainThread: #selector(showError), with: nil, waitUntilDone: false)
}
```
## challenges
@todo
- Modify project 1 so that loading the list of NSSL images from our bundle happens in the background. Make sure you call reloadData() on the table view once loading has finished!
- Modify project 8 so that loading and parsing a level takes place in the background. Once you’re done, make sure you update the UI on the main thread!
- Modify project 9 so that your filtering code takes place in the background. This filtering code was added in one of the challenges for project 9, so hopefully you didn’t skip it!

