import UIKit
import FirebaseFirestore
import CoreLocation


// ⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️공식문서⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️
// https://firebase.google.com/docs/firestore/manage-data/add-data?hl=ko



class NetworkingManager {
    //MARK: - Singleton Pattern
    static let shared = NetworkingManager()
    let db = Firestore.firestore()
    var housesRef: CollectionReference!
    private init() {}
    
    //MARK: - 체크리스트관련메서드
    //MARK: - Create
    func addHouses(houseModel: House) {
//        let encoder = JSONEncoder()
//        do {
//            let checkData = try encoder.encode(houseModel.체크리스트)
//            let data = try encoder.encode(houseModel)
            guard let data = houseModel.asDictionary else { return }
            db.collection("Homes").document().setData(data)
//        } catch let error {
//            print("\(error.localizedDescription)")
//        }
        
    }
    
    //MARK: - Read
    func fetchHouses(completion: @escaping([House]) -> Void) {
        DispatchQueue.global().async {
            self.db.collection("Homes").getDocuments { querySnapshot, error in
                if error == nil && querySnapshot != nil {
                    guard let snapshot = querySnapshot else { return }
                    var houses: [House] = []
                    for document in snapshot.documents {
                        let data = document.data()
//                        let latitude = data["latitude"] as! Double
//                        let longitude = data["longitude"] as! Double
//                        let isBookMarked = data["isBookMarked"] as! Bool
                        
//                        locations.append(location)
                    }
                    completion(houses)
                } else {
                    print("\(String(describing: error?.localizedDescription))")
                }
            }        }
        
        
        
        
    }
    //MARK: - Update
    //MARK: - Delete



    
    
    
    
    //MARK: - 지도관련메서드
    //MARK: - Create
    
    //MARK: - Read
    func fetchAnnotations(completion: @escaping([Location]) -> Void) {
        //파이어 베이스에서 location 배열을 받아와서 completion을 통해 얻는다.
        DispatchQueue.global().async {
            self.db.collection("Homes").getDocuments { querySnapshot, error in
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
        
    }
    //MARK: - Update
    
    //MARK: - Delete




    
    func fetchAreaName(completion: @escaping([String]) -> Void) {
        //파이어 베이스에서 전국 지역명 배열을 받아와서 completion을 통해 얻는다.
        
        
    }
   
}
