# project 21 - local notifications
## setting up
- create a new single view app, call it project 21
## scheduling notifications
We will be using `UNUserNotificationCenter` and `UNNotificationRequest`
- open Main.storyboard in Interface Builder
- embed the view controller inside a navigation controller
- add the following two method stubs
```swift
@objc func registerLocal() {

}

@objc func scheduleLocal() {

}
```
- add this code to `viewDidLoad()`
```swift
navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Register", style: .plain, target: self, action: #selector(registerLocal))
navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Schedule", style: .plain, target: self, action: #selector(scheduleLocal))
```
- add an import at the top
```swift
import UserNotifications
```
- put the following code in `registerLocal()`
```swift
let center = UNUserNotificationCenter.current()

    center.requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
        if granted {
            print("Yay!")
        } else {
            print("D'oh")
        }
    }

```
- add the following code to `scheduleLocale()`
```swift
    let center = UNUserNotificationCenter.current()
    center.removeAllPendingNotificationRequests()

    let content = UNMutableNotificationContent()
    content.title = "Late wake up call"
    content.body = "The early bird catches the worm, but the second mouse gets the cheese."
    content.categoryIdentifier = "alarm"
    content.userInfo = ["customData": "fizzbuzz"]
    content.sound = UNNotificationSound.default

    var dateComponents = DateComponents()
    dateComponents.hour = 10
    dateComponents.minute = 30
    // the commented one is how to schedule a specific time
    // let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
    // this one is after an elapsed time period
    let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
    center.add(request)
```
## acting on responses
- add this to the controller
```swift
func registerCategories() {
    let center = UNUserNotificationCenter.current()
    center.delegate = self

    let show = UNNotificationAction(identifier: "show", title: "Tell me more…", options: .foreground)
    let category = UNNotificationCategory(identifier: "alarm", actions: [show], intentIdentifiers: [])

    center.setNotificationCategories([category])
}
```
- implement the delegate
```swift
class ViewController: UIViewController, UNUserNotificationCenterDelegate {
```
- call `registerCategories()` at the start of `scheduleLocal()` method
- add this to the controller
```swift
func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
    // pull out the buried userInfo dictionary
    let userInfo = response.notification.request.content.userInfo

    if let customData = userInfo["customData"] as? String {
        print("Custom data received: \(customData)")

        switch response.actionIdentifier {
        case UNNotificationDefaultActionIdentifier:
            // the user swiped to unlock
            print("Default identifier")

        case "show":
            // the user tapped our "show more info…" button
            print("Show more information…")

        default:
            break
        }
    }

    // you must call the completion handler when you're done
    completionHandler()
}
```
## challenges
- Update the code in didReceive so that it shows different instances of UIAlertController depending on which action identifier was passed in.
- For a harder challenge, add a second UNNotificationAction to the alarm category of project 21. Give it the title “Remind me later”, and make it call scheduleLocal() so that the same alert is shown in 24 hours. (For the purpose of these challenges, a time interval notification with 86400 seconds is good enough – that’s roughly how many seconds there are in a day, excluding summer time changes and leap seconds.)
- And for an even harder challenge, update project 2 so that it reminds players to come back and play every day. This means scheduling a week of notifications ahead of time, each of which launch the app. When the app is finally launched, make sure you call removeAllPendingNotificationRequests() to clear any un-shown alerts, then make new alerts for future days.