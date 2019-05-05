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
## MKPinAnnotationView
- make the view controller implement `MKMapViewDelegate`
```swift
class ViewController: UIViewController, MKMapViewDelegate {
```
- create a `mapView` method in the controll;er
1 If the annotation isn't from a capital city, it must return nil so iOS uses a default view.
2 Define a reuse identifier. This is a string that will be used to ensure we reuse annotation views as much as possible.
3 Try to dequeue an annotation view from the map view's pool of unused views.
4 If it isn't able to find a reusable view, create a new one using MKPinAnnotationView and sets its canShowCallout property to true. This triggers the popup with the city name.
5 Create a new UIButton using the built-in .detailDisclosure type. This is a small blue "i" symbol with a circle around it.
6 If it can reuse a view, update that view to use a different annotation.
```swift
func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
    // 1
    guard annotation is Capital else { return nil }

    // 2
    let identifier = "Capital"

    // 3
    var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)

    if annotationView == nil {
        //4
        annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
        annotationView?.canShowCallout = true

        // 5
        let btn = UIButton(type: .detailDisclosure)
        annotationView?.rightCalloutAccessoryView = btn
    } else {
        // 6
        annotationView?.annotation = annotation
    }

    return annotationView
}
```
- add another mapView call, with a different argument signature
```swift
func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
    guard let capital = view.annotation as? Capital else { return }
    let placeName = capital.title
    let placeInfo = capital.info

    let ac = UIAlertController(title: placeName, message: placeInfo, preferredStyle: .alert)
    ac.addAction(UIAlertAction(title: "OK", style: .default))
    present(ac, animated: true)
}
```
