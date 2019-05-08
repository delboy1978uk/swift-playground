# project 19 - javascript injection
- set up a single view app called project19
## making a shell app
- drop a hello world label into the storyboard
- ctrl drag to the view centre horizontally
- ctrl drag to the view centre vertically
- Editor > Resolve Auto Layout Issues > Update Frames
## NSExtensionItem
- File > New > Target
- iOS > Application Extension > Action Extension
- call it Extension
- action type Presents User Interface
- click do not show again and activate
- expand the new Extension folder
- open actionviewcontroller
- replace `viewDidLoad()`
```swift
override func viewDidLoad() {
    super.viewDidLoad()

    if let inputItem = extensionContext?.inputItems.first as? NSExtensionItem {
        if let itemProvider = inputItem.attachments?.first {
            itemProvider.loadItem(forTypeIdentifier: kUTTypePropertyList as String) { [weak self] (dict, error) in
                // do stuff!
            }
        }
    }
}
```
## what do you want to get?
- open the extensions plist
- expand nsextension key
- change NSExtensionActivationRule to a dictionary
- expand and click plus to add a new key
- NSExtensionActivationSupportsWebPageWithMaxCount value 1
- select NSExtensionAttributes and click plus
- NSExtensionJavaScriptPreprocessingFile value Action
- right click plist, new file
- iOS > Other > Empty, call it Action.js
```javascript
var Action = function() {};

Action.prototype = {

run: function(parameters) {

},

finalize: function(parameters) {

}

};

var ExtensionPreprocessingJS = new Action
```
- choose project in navigator, go to build phases
- click extension, check js is in copy and not compile section
## establishing communication
- add to run function in js
```javascript
parameters.completionFunction({"URL": document.URL, "title": document.title });
```
- in actionviewcontroller // do stuff, replace with this
```swift
guard let itemDictionary = dict as? NSDictionary else { return }
guard let javaScriptValues = itemDictionary[NSExtensionJavaScriptPreprocessingResultsKey] as? NSDictionary else { return }
print(javaScriptValues)
```
- ctrl-r run, choose safari as the app to run
- open a webpage then click the action menu button, you should see extension in there
- click it, and you will see the javascript values in the log
## editing multiline text with UITextView
- open extensions main interface storyboard and delete the UIImageView and nav bar
- right click image in navigator check imageView has no connection
- embed in navigation controller
- add a UITextView, stretch to fill space
- Editor > Resolve Layout Issues > Reset To Suggested Constraints
- attributes, delete lorem ipsum, turn off all spellchecking capitalisation etc
- add an outlet called script by ctrl dragging
- add properties to action view controller
```swift
var pageTitle = ""
var pageURL = ""
```
- delete the image outlet property
- replace `print()` with the following
```swift
self?.pageTitle = javaScriptValues["title"] as? String ?? ""
self?.pageURL = javaScriptValues["URL"] as? String ?? ""

DispatchQueue.main.async {
    self?.title = self?.pageTitle
}
```
- add after super viewDidLoad
```swift
navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
```
- replace `done()`
```swift
@IBAction func done() {
    let item = NSExtensionItem()
    let argument: NSDictionary = ["customJavaScript": script.text]
    let webDictionary: NSDictionary = [NSExtensionJavaScriptFinalizeArgumentKey: argument]
    let customJavaScript = NSItemProvider(item: webDictionary, typeIdentifier: kUTTypePropertyList as String)
    item.attachments = [customJavaScript]

    extensionContext?.completeRequest(returningItems: [item])
}
```
- add to finalise js
```javascript
var customJavaScript = parameters["customJavaScript"];
eval(customJavaScript);
```
## fixing the keyboard using NotificatiuonCenter
There is an issue with the keyboard blocking the text we are typing into
- add to viewdidload
```swift
let notificationCenter = NotificationCenter.default
notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification object: nil)
```
- add the adjust for keyboard method
```
@objc func adjustForKeyboard(notification: Notification) {
    guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }

    let keyboardScreenEndFrame = keyboardValue.cgRectValue
    let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)

    if notification.name == UIResponder.keyboardWillHideNotification {
        script.contentInset = .zero
    } else {
        script.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height - view.safeAreaInsets.bottom, right: 0)
    }

    script.scrollIndicatorInsets = script.contentInset

    let selectedRange = script.selectedRange
    script.scrollRangeToVisible(selectedRange)
}
```
## challenges @todo
- Add a bar button item that lets users select from a handful of prewritten example scripts, shown using a UIAlertController – at the very least your list should include the example we used in this project.
- You're already receiving the URL of the site the user is on, so use UserDefaults to save the user's JavaScript for each site. You should convert the URL to a URL object in order to use its host property.
- For something bigger, let users name their scripts, then select one to load using a UITableView.

