import UIKit
import MapKit
import CoreLocation

class LocationViewModel {
    //MARK: - Model
    var locationModel: Location?
    var annotations: [Annotation] = []
    var fetchedLocations: [Location] = [
                        Location(latitude: "37.33511535552606", longitude: "127.11933035555937", isBookMarked: false),
                        Location(latitude: "37.32209627495218", longitude: " 127.12718477301696", isBookMarked: false),
                        Location(latitude: "37.33387447939296", longitude: "127.11677820767655", isBookMarked: true)]
    var visibleRegion: MKCoordinateRegion?
    
    
    //MARK: - Output
    
    func getLocations() -> [Location] { return self.fetchedLocations }
    
    func getAnnotations() -> [Annotation] { return self.annotations }
        
    //MARK: - Input
    func currentVisible(region: MKCoordinateRegion) { self.visibleRegion = region }
    
    
    
    //MARK: - Logics
    
    
    func fetchAnnotations() {
        //네트워킹 하는 로직 -> API 에서
        NetworkingManager.shared.fetchAnnotations { locations in
            self.fetchedLocations = locations
        }
    }
    
    
    
    func locationsWhenRegionChanged() {
        guard let visibleRegion = visibleRegion else { return }
        let locationsInVisibleRegion = fetchedLocations.filter { location in
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
        makeAnnotationsWithFiltered(locations: locationsInVisibleRegion)
    }
    
    func makeAnnotationsWithFiltered(locations: [Location]) {
        var annotations: [Annotation] = []
        for location in locations {
            let pin = Annotation(isBookMarked: location.isBookMarked, coordinate: CLLocationCoordinate2D(latitude: Double(location.latitude) ?? 0.0, longitude: Double(location.longitude) ?? 0.0))
            annotations.append(pin)
        }
        self.annotations = annotations
    }
    
    
    
    
    
}

