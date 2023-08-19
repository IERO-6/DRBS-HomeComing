import UIKit
import FirebaseFirestore
import CoreLocation

class NetworkingManager {
    //MARK: - Singleton Pattern
    static let shared = NetworkingManager()
    let db = Firestore.firestore()
    private init() {}
    
    //MARK: - 체크리스트관련메서드

    
    
    
    //MARK: - 지도관련메서드

    func fetchAnnotations(completion: @escaping([Location]) -> Void) {
        //파이어 베이스에서 location 배열을 받아와서 completion을 통해 얻는다.
        db.collection("Homes").getDocuments { querySnapshot, error in
            if error == nil && querySnapshot != nil {
                guard let snapshot = querySnapshot else { return }
                var locations: [Location] = []
                for document in snapshot.documents {
                    let data = document.data()
                    let latitude = data["latitude"] as! Double
                    let longitude = data["longitude"] as! Double
                    let isBookMarked = data["isBookMarked"] as! Bool
                    /*
                     print(document.data())
                     ["latitude": 35.154212698793216,
                     "isBookMarked": 1,
                     "rate": 4.5,
                     "memo": "좀 비싼 듯",
                     "title": 교수님연구소,
                     "longitude": 128.09943680848707,
                     "uid": Shkd6VlrbffIb8v5dg3amIwUDV72]
                     */
                    let location = Location(coordinate: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), isBookMarked: isBookMarked)
                    locations.append(location)
                }
                completion(locations)
            } else {
                print("\(String(describing: error?.localizedDescription))")
            }
        }
        
    }
    func fetchAreaName(completion: @escaping([String]) -> Void) {
        //파이어 베이스에서 전국 지역명 배열을 받아와서 completion을 통해 얻는다.
        
        
    }
   
}
