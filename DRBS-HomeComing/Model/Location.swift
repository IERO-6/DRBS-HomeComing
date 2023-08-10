import UIKit
import CoreLocation
import MapKit

struct Location {
    var latitude: CLLocationDegrees
    var longitude: CLLocationDegrees
    var city: String?
    var country: String?
    
}

class Marker: NSObject, MKAnnotation {
  let title: String?
  let coordinate: CLLocationCoordinate2D
  let subtitle: String?

  init(
    title: String?,
    subtitle: String?,
    coordinate: CLLocationCoordinate2D
  ) {
    self.title = title
    self.subtitle = subtitle
    self.coordinate = coordinate

    super.init()
  }

}
