import UIKit
import MapKit

class Annotation: NSObject, MKAnnotation {
    
  var isBookMarked: Bool
  var coordinate: CLLocationCoordinate2D


    init(isBookMarked: Bool, coordinate: CLLocationCoordinate2D) {
        self.isBookMarked = isBookMarked
        self.coordinate = coordinate
        super.init()
    }

}
