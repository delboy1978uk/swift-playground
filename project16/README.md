# project16 MapKit
- create single view app
- go to interface builder
- embed view controller in a navigation controller
- drop a map view in the view and full size it
- use Resolve Auto Layout Issues > Add Missing Constraints
- run the app and you should have a nice map
## Annotations and coordinates
- open assistant editor and create an outlet for the map view called `mapView`
- create new iOS > Source > Cocoa Touch Class
- Call it Capital and subclass of NSObject
- implement MKAnnotation
```swift
import MapKit
import UIKit

class Capital: NSObject, MKAnnotation {
    var title: String?
    var coordinate: CLLocationCoordinate2D
    var info: String

    init(title: String, coordinate: CLLocationCoordinate2D, info: String) {
        self.title = title
        self.coordinate = coordinate
        self.info = info
    }
}
```
- in `viewDidLoad()`, add the following
```swift
let london = Capital(title: "London", coordinate: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), info: "Home to the 2012 Summer Olympics.")
let oslo = Capital(title: "Oslo", coordinate: CLLocationCoordinate2D(latitude: 59.95, longitude: 10.75), info: "Founded over a thousand years ago.")
let paris = Capital(title: "Paris", coordinate: CLLocationCoordinate2D(latitude: 48.8567, longitude: 2.3508), info: "Often called the City of Light.")
let rome = Capital(title: "Rome", coordinate: CLLocationCoordinate2D(latitude: 41.9, longitude: 12.5), info: "Has a whole country inside it.")
let washington = Capital(title: "Washington DC", coordinate: CLLocationCoordinate2D(latitude: 38.895111, longitude: -77.036667), info: "Named after George himself.")
```
- import `Mapkit` i8nto the view controller
- add to the end of `viewDidfLoad()`
```swift
mapView.addAnnotations([london, oslo, paris, rome, washington])
```
-run the app and you can see the pins and names, but not the info yet

