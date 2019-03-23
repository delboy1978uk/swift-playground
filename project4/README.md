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
## progress bar and refresh icon
### create toolbar with refresh icon
- create flexible spacer and refresh icon in view did load
```swift
let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))

toolbarItems = [spacer, refresh]
navigationController?.isToolbarHidden = false
```
### progress bar
- add property
```swift
var progressView: UIProgressView!
```
- add under spacer and refresh code
```swift
progressView = UIProgressView(progressViewStyle: .default)
progressView.sizeToFit()
let progressButton = UIBarButtonItem(customView: progressView)
```
- add button to array
```swift
toolbarItems = [progressButton, spacer, refresh]
```
- add an observer in viewDidLoad
```swift
webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
```
- add observeValue() methoid
```swift
override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
    if keyPath == "estimatedProgress" {
        progressView.progress = Float(webView.estimatedProgress)
    }
}
```
## refactoring
- create an array of sites as a property
```swift
    var websites = [
        "barrheadboy.com",
        "independencelive.net",
        "indylive.radio",
        "randompublicjournal.com",
        "thoughtcontrolscotland.com",
        "wingsoverscotland.com"
    ]
```
- edit the intial load url
```swift
let url = URL(string: "https://" + websites[5])!
```
- refactor to a for loop
```swift
for website in websites {
    ac.addAction(UIAlertAction(title: website, style: .default, handler: openPage))
}
```
- add a check so it only loads from our domains
```swift
func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
    let url = navigationAction.request.url

    if let host = url?.host {
        for website in websites {
            if host.contains(website) {
                decisionHandler(.allow)
                return
            }
        }
    }

    decisionHandler(.cancel)
}
``` 
## challenge
- If users try to visit a URL that isn’t allowed, show an alert saying it’s blocked.
- Try making two new toolbar items with the titles Back and Forward. You should make them use webView.goBack and webView.goForward.
- For more of a challenge, try changing the initial view controller to a table view like in project 1, where users can choose their website from a list rather than just having the first in the array loaded up front.
### challenge 1
add alert to webView method
```swift
let ac = UIAlertController(title: title, message: (url?.absoluteString)! + " blocked.", preferredStyle: .alert)
ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: nil))
present(ac, animated: true)
```
- add safe links for blocked stuff on other domains
```swift
    var safeLinks = [
        "youtube.com",
        "livestream.com",
        "twitter.com",
        "facebook.com",
        "google",
        "player.shoutca.st",
    ]
```
- check in the webview section
```swift
for website in safeLinks {
    if host.contains(website) {
        decisionHandler(.allow)
        return
    }
}
```
### challenge 2
- add new buttons in viewDidLoad
```swift
let previous = UIBarButtonItem(barButtonSystemItem: .rewind, target: webView, action: #selector(webView.goBack))
let next = UIBarButtonItem(barButtonSystemItem: .play, target: webView, action: #selector(webView.goForward))
```
- add to array
```swift
toolbarItems = [progressButton, spacer, previous, spacer, next, spacer, refresh]
```
### challenge 3

