# project 4
- create new project, single page iOS app
- goto interface builder
- select view controlle
- Editor > Embed In > NavigationController
- in View controller
```swift
import WebKit
```
- add a var and method
```swift
var webView: WKWebView!
    
override func loadView() {
    webView = WKWebView()
    webView.navigationDelegate = self
    view = webView
}
```
- implement the delgate interface
```swift
class ViewController: UIViewController, WKNavigationDelegate {
```
- and add to view did load
```swift
let url = URL(string: "https://coinmarketcap.com")!
webView.load(URLRequest(url: url))
webView.allowsBackForwardNavigationGestures = true
```
## add navigation
- under super.viewDidLoad()
```swift
navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Open", style: .plain, target: self, action: #selector(openTapped))
```
- create openTapped() function
```swift
@objc func openTapped() {
let ac = UIAlertController(title: "Open page…", message: nil, preferredStyle: .actionSheet)
ac.addAction(UIAlertAction(title: "indylive.radio", style: .default, handler: openPage))
ac.addAction(UIAlertAction(title: "delboy1978uk.wordpress.com", style: .default, handler: openPage))
ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
ac.popoverPresentationController?.barButtonItem = self.navigationItem.rightBarButtonItem
present(ac, animated: true)
}
```

