import UIKit
import MapKit
import CoreLocation

class LocationViewModel {
    //MARK: - Model
    var locationModel: Location?
    var fetchedAnnotations: [Location] = [Location(latitude: "37.33511535552606", longitude: "127.11933035555937", isBookMarked: false),
                        Location(latitude: "37.32209627495218", longitude: " 127.12718477301696", isBookMarked: true),
                        Location(latitude: "37.33387447939296", longitude: "127.11677820767655", isBookMarked: true)]
    var visibleRegion: MKCoordinateRegion?
    
    
    //MARK: - Output
    
    func getAnnotations() -> [Location] {
        return self.fetchedAnnotations
    }
    
    func getFilteredAnnotations() -> [Location] {
        return getAnnotationsWhenRegionChanged()
    }
    
    
    
    
    //MARK: - Input
    
    
    
    
    //MARK: - Logics
    
    
    func fetchAnnotations() {
        //네트워킹 하는 로직 -> API 에서
        NetworkingManager.shared.fetchAnnotations { locations in
            self.fetchedAnnotations = locations
        }
    }
    
    
    
    func getAnnotationsWhenRegionChanged() -> [Location] {
        guard let visibleRegion = visibleRegion else { return [] }
        //        let visibleRect = MKMapRect(origin: MKMapPoint(visibleRegion.center), size: MKMapSize(width: visibleRegion.span.longitudeDelta, height: visibleRegion.span.latitudeDelta))
        //        let filteredLocations = fetchedAnnotations.filter {
        //            visibleRect.contains(CLLocation(latitude: Double($0.latitude) ?? 0.0, longitude: Double($0.longitude) ?? 0.0))
        //        }
        //
        //
        //        return self.fetchedAnnotations
        let locationsInVisibleRegion = fetchedAnnotations.filter { location in
            guard
                let latitude = CLLocationDegrees(location.latitude),
                let longitude = CLLocationDegrees(location.longitude)
            else {
                return false // Skip invalid locations
            }
            
            let locationCoordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            
            // Calculate the differences in latitude and longitude between the location coordinate and the visible region's center coordinate
            let deltaLatitude = abs(visibleRegion.center.latitude - locationCoordinate.latitude)
            let deltaLongitude = abs(visibleRegion.center.longitude - locationCoordinate.longitude)
            
            // Check if the deltas are within half of the visible region's span (latitudeDelta/2 and longitudeDelta/2)
            return deltaLatitude <= visibleRegion.span.latitudeDelta / 2 && deltaLongitude <= visibleRegion.span.longitudeDelta / 2
        }
        print(locationsInVisibleRegion)
        return locationsInVisibleRegion
    }
    
    
    
    
    
    
    
}

