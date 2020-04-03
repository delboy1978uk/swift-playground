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