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
