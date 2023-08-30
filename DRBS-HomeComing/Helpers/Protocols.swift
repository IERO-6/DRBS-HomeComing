import UIKit
import CoreLocation

protocol CalendarDelegate: AnyObject {
    func dateSelected(date: Date)
}
protocol searchViewDelegate: AnyObject {
    func setRegion(cood: CLLocationCoordinate2D)
}
protocol CellSelectedDelegate: AnyObject {
    func cellselected(indexPath: IndexPath)
}
