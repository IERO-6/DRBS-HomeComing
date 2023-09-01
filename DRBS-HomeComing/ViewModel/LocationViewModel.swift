import UIKit
import MapKit
import CoreLocation

final class LocationViewModel {
    //MARK: - Model
    var locationModel: Location?
    var locations: [Location] = []
    var fetchedLocations: [Location] = []
    var houses: [House] = []
    var visibleRegion: MKCoordinateRegion? {
        didSet {
            locationsWhenRegionChanged()
        }
    }
    
    //MARK: - Output
    
    func getLocations() -> [Location] { return self.fetchedLocations }
    
    func getAnnotations() -> [Location] { return self.locations }
    
    //MARK: - Input
    func currentVisible(region: MKCoordinateRegion) { self.visibleRegion = region }
    
    
    
    //MARK: - Logics
    
    
    func fetchAnnotations() {
        //네트워킹 하는 로직 -> API 에서
        NetworkingManager.shared.fetchAnnotations { self.fetchedLocations = $0 }
    }
    
    
    
    func locationsWhenRegionChanged() {
        guard let visibleRegion = visibleRegion else { return }
        let locationsInVisibleRegion = fetchedLocations.filter { location in
            let latitude = location.coordinate.latitude
            let longitude = location.coordinate.longitude
            let locationCoordinate = location.coordinate
            let deltaLatitude = abs(visibleRegion.center.latitude - locationCoordinate.latitude)
            let deltaLongitude = abs(visibleRegion.center.longitude - locationCoordinate.longitude)
            return deltaLatitude <= visibleRegion.span.latitudeDelta / 2 && deltaLongitude <= visibleRegion.span.longitudeDelta / 2
        }
        makeAnnotationsWithFiltered(locations: locationsInVisibleRegion)
    }
    
    func makeAnnotationsWithFiltered(locations: [Location]) {
        var annotations: [Location] = []
        for location in locations {
            let pin = Location(coordinate: location.coordinate, isBookMarked: location.isBookMarked)
            annotations.append(pin)
        }
        self.locations = annotations
    }
    
    
    
    
    
}

