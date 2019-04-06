# project 7
- create another single view app
- change view controller to extend `UITableViewController`
- Go into interface builder, delete existing view controller
- drag table view controller into storyboard
- identity inspector, change class to ViewController
- attributes inspector, check is initial view controller
- select table view cell and give id Cell
- set Accessory to Disclosure Indicator
- change Style from Custom to Subtitle
- Editor > Embed In > Navigation Controller
- Editor > Embed In > Tab Bar Controller
- add property to view controller
```swift
var petitions = [String]()
```
- override the number of rows in section method
```swift
override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return petitions.count
}
```
- add cell for row at code
```swift
override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
    cell.textLabel?.text = "Title goes here"
    cell.detailTextLabel?.text = "Subtitle goes here"
    return cell
}
```
## parsing the json
- create Petition.swift, extend codable (json_decode/json_encode)
```swift
struct Petition: Codable {
    var title: String
    var body: String
    var signatureCount: Int
}
```
- create Petitions.swift
```swift
struct Petitions: Codable {
    var results: [Petition]
}
```
- refactor petitions property in viewController
```swift
var petitions = [Petition]()
```
- add to viewDidLoad()
```swift
let urlString = "https://api.whitehouse.gov/v1/petitions.json?limit=100"
if let url = URL(string: urlString) {
    if let data = try? Data(contentsOf: url) {
        // we're OK to parse!
    }
}
```
- create parse function
```swift
func parse(json: Data) {
    let decoder = JSONDecoder()

    if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
        petitions = jsonPetitions.results
        tableView.reloadData()
    }
}
```
- replace ok to parse comment with this
```swift
parse(json: data)
```
- edit table row method
```swift
let petition = petitions[indexPath.row]
cell.textLabel?.text = petition.title
cell.detailTextLabel?.text = petition.body
```
- now run and you'll see the petitions in the table view
## loadHTMLString()
- cmd-N, create new cocoa touch class
- name DetailViewController, extending UIViewController, next, create
```swift
import UIKit
import WebKit

class DetailViewController: UIViewController {

    var webView: WKWebView!
    var detailItem: Petition?
    
    override func loadView() {
        webView = WKWebView()
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
```
- add to viewDidLoad
```swift
guard let detailItem = detailItem else { return }

let html = """
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<style> body { font-size: 150%; } </style>
</head>
<body>
\(detailItem.body)
</body>
</html>
"""

webView.loadHTMLString(html, baseURL: nil)
```
- hook up detailviewcontroller, add to view controller
```swift
override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let vc = DetailViewController()
    vc.detailItem = petitions[indexPath.row]
    navigationController?.pushViewController(vc, animated: true)
}
```
Create another view controller, this time in code
- OPen AppDelegate.swift
- in didFinishLaunchingWithOptions function, add this before then return
```swift
if let tabBarController = window?.rootViewController as? UITabBarController {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let vc = storyboard.instantiateViewController(withIdentifier: "NavController")
    vc.tabBarItem = UITabBarItem(tabBarSystemItem: .topRated, tag: 1)
    tabBarController.viewControllers?.append(vc)
}
```
- replace the url string in viewDidLoad of the view controller 
```swift
let urlString: String

if navigationController?.tabBarItem.tag == 0 {
    // urlString = "https://api.whitehouse.gov/v1/petitions.json?limit=100"
    urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
} else {
    // urlString = "https://api.whitehouse.gov/v1/petitions.json?signatureCountFloor=10000&limit=100"
    urlString = "https://www.hackingwithswift.com/samples/petitions-2.json"
}
```
- add an error function 
```swift
func showError() {
    let ac = UIAlertController(title: "Loading error", message: "There was a problem loading the feed; please check your connection and try again.", preferredStyle: .alert)
    ac.addAction(UIAlertAction(title: "OK", style: .default))
    present(ac, animated: true)
}
```
- refactor the json parsing code to throw errors on failure
```swift
if let url = URL(string: urlString) {
    if let data = try? Data(contentsOf: url) {
        parse(json: data)
    } else {
        showError()
    }
} else {
    showError()
}
```
