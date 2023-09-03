/*
 ################################################################
 #                        #                                     #
 #  ⭐️뷰모델이 모델을 소유⭐️   # ⭐️사용자와 상호작용하는 로직도 뷰모델이 소유⭐️ #
 #                        #                                     #
 ################################################################
 */
import CoreLocation
import UIKit
import FirebaseAuth
import FirebaseFirestore
import MapKit

class HouseViewModel {
    //MARK: - Model
    var house: House?
    /* 뷰컨은 뷰모델이 소유한 데이터를 표기해야하기 때문에
     뷰모델은 뷰컨이 소유한 데이터와 관련있는 값도 가져야 함 */
    var locationModel: Location?
    var visibleHouses: [House] = []
    var fetchedLocations: [Location] = []
    var houses: [House] = []
    var visibleRegion: MKCoordinateRegion?
    
    
    var name: String?
    var tradingType: String?
    var livingType: String?
    var latitude: Double?
    var longitude: Double?
    var address: String?
    var 보증금: String?
    var 월세or전세금: String?
    var 관리비: String?
    var 관리비미포함목록: [String] = []
    var 면적: String?
    var 입주가능일: String?
    var 계약기간: String?
    var checkList: CheckList?
    var stringImages: [String] = []
    var memo: String?
    var rate: Double?
    var uiImages: [UIImage] = []
    
    //MARK: - Output
    
    func makeHouseModel() {
        if let user = Auth.auth().currentUser {
            
            self.house = House(uid: user.uid, houseId: "",title: self.name, isBookMarked: false, livingType: self.livingType, tradingType: self.tradingType, address: self.address, latitude: self.latitude, longitude: self.longitude, 보증금: self.보증금, 월세: self.월세or전세금, 관리비: self.관리비, 관리비미포함목록: self.관리비미포함목록, 면적: self.면적, 입주가능일: self.입주가능일, 계약기간: self.계약기간, 체크리스트: self.checkList, 기록: self.memo, 사진: stringImages, 별점: self.rate)
        }
    }
    
    
    //MARK: - Input
    
    
    
    
    
    //MARK: - Logics
    func switchAddressToCLCoordinate2D(address: String, completion: @escaping (CLLocationCoordinate2D?, Error?) -> Void) {
        // 도로명 주소를 위도와 경도로 변환하는 함수
        let geocoder = CLGeocoder()
        DispatchQueue.global().async {
            geocoder.geocodeAddressString(address) { (placemarks, error) in
                if let error = error {
                    completion(nil, error)
                    return
                }
                if let placemark = placemarks?.first,
                   let location = placemark.location {
                    completion(location.coordinate, nil)
                } else {
                    completion(nil, NSError(domain: "GeocodingErrorDomain", code: 1, userInfo: nil))
                }
            }
        } 
    }
    
    //uiSlider값에 따라 평점 구분하는 로직
    func calculateRates(value: Double) -> Double {
        switch value {
        case _ where value > 0.0 && value < 0.5:
            return 0
        case _ where value > 0.5 && value < 1.0:
            return 0.5
        case _ where value > 1.0 && value < 1.5:
            return 1.0
        case _ where value > 1.5 && value < 2.0:
            return 1.5
        case _ where value > 2.0 && value < 2.5:
            return 2.0
        case _ where value > 2.5 && value < 3.0:
            return 2.5
        case _ where value > 3.0 && value < 3.5:
            return 3.0
        case _ where value > 3.5 && value < 4.0:
            return 3.5
        case _ where value > 4.0 && value < 4.5:
            return 4.0
        case _ where value > 4.5 && value < 5.0:
            return 4.5
        case 5.0:
            return 5.0
        default:
            return 0.0
        }
    }
    
    func makeUIImageToString() {
        for image in uiImages {
            guard let convertedImage = image.toPngString() else {
                print("HouseViewModel 107Line Error: toPng실패")
                return
            }
            self.stringImages.append(convertedImage)
        }
        print(self.stringImages)


    }
    
    
    
    
    func getLocations() -> [Location] { return self.fetchedLocations }
    
    func getAnnotations() -> [House] { return self.visibleHouses }
    
    func currentVisible(region: MKCoordinateRegion) { self.visibleRegion = region }
    
    
    
    func makeLocationWithHouses() {
        for house in self.houses {
            guard let latitude = house.latitude,
                  let longitude = house.longitude,
                  let isBookmarked = house.isBookMarked,
                  let houseId = house.houseId else { return }
            self.fetchedLocations.append(Location(coordinate: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), isBookMarked: isBookmarked, id: houseId))
        }
    }
    
    func fetchAnnotations() {
        //네트워킹 하는 로직 -> API 에서
        NetworkingManager.shared.fetchAnnotations { self.fetchedLocations = $0 }
        
    }
    
    
    
    func locationsWhenRegionChanged() {
        guard let visibleRegion = visibleRegion else { return }
        let locationsInVisibleRegion = houses.filter { location in
            let latitude = location.coordinate.latitude
            let longitude = location.coordinate.longitude
            let locationCoordinate = location.coordinate
            let deltaLatitude = abs(visibleRegion.center.latitude - locationCoordinate.latitude)
            let deltaLongitude = abs(visibleRegion.center.longitude - locationCoordinate.longitude)
            return deltaLatitude <= visibleRegion.span.latitudeDelta / 2 && deltaLongitude <= visibleRegion.span.longitudeDelta / 2
        }
        makeAnnotationsWithFiltered(locations: locationsInVisibleRegion)
    }
    
    func makeAnnotationsWithFiltered(locations: [House]) {
        var annotations: [House] = []
        for location in locations {
//            let pin = House(coordinate: location.coordinate, isBookMarked: location.isBookMarked, id: "")
            annotations.append(location)
        }
        self.visibleHouses = annotations
    }
    
}
