# project 22 - detect a beacon
## setting up
- create a new single page ios app called project 22
## requesting location
- open info plist and add the two keys. you can have any text description
```swift
Privacy - Location Always and When In Use Usage Description
Privacy - Location Always Usage Description
```
- open storyboard
- add label, change font to thin style size 40
- ctrl drag label onto view, center horizontally and vertically
- click refresh frames button to update view
- make label `UNKOWN`
- open assistant editor
- ctrl drag label into controller
- create outlet called `distanceReading`
- open view controller
- add import
```swift
import CoreLocation
```
- add this property
```swift
var locationManager: CLLocationManager?
```
- change class definition
```swift
class ViewController: UIViewController, CLLocationManagerDelegate {
```
- view did load
```swift
override func viewDidLoad() {
    super.viewDidLoad()

    locationManager = CLLocationManager()
    locationManager?.delegate = self
    locationManager?.requestAlwaysAuthorization()

    view.backgroundColor = .gray
}
```
- add did change authorisation method
```swift
func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
    if status == .authorizedAlways {
        if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self) {
            if CLLocationManager.isRangingAvailable() {
                // do stuff
            }
        }
    }
}
```
## hunting the beacon - CLBeaconRegion
- add the start scanning code
```swift
func startScanning() {
    let uuid = UUID(uuidString: "5A4BCFCE-174E-4BAC-A814-092E77F6B7E5")!
    let beaconRegion = CLBeaconRegion(proximityUUID: uuid, major: 123, minor: 456, identifier: "MyBeacon")

    locationManager?.startMonitoring(for: beaconRegion)
    locationManager?.startRangingBeacons(in: beaconRegion)
}
```
Note that the UUID is a test beacon ID, you can download an app to emulate an actual beacon if you do not have a device
- call `startScanning()` where the `//do stuff` comment is
- add the `update()` method
```swift
func update(distance: CLProximity) {
    UIView.animate(withDuration: 0.8) {
        switch distance {
        case .far:
            self.view.backgroundColor = UIColor.blue
            self.distanceReading.text = "FAR"

        case .near:
            self.view.backgroundColor = UIColor.orange
            self.distanceReading.text = "NEAR"

        case .immediate:
            self.view.backgroundColor = UIColor.red
            self.distanceReading.text = "RIGHT HERE"

        default:
            self.view.backgroundColor = UIColor.gray
            self.distanceReading.text = "UNKNOWN"
        }
    }
}
```
- add the did range beacons method
```swift
func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
    if let beacon = beacons.first {
        update(distance: beacon.proximity)
    } else {
        update(distance: .unknown)
    }
}
```