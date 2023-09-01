import UIKit
import FirebaseFirestore
import KakaoSDKUser
import KakaoSDKAuth
import FirebaseAuth
import CoreLocation


// ⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️공식문서⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️
// https://firebase.google.com/docs/firestore/manage-data/add-data?hl=ko

class NetworkingManager {
    //MARK: - Singleton Pattern
    static let shared = NetworkingManager()
    let db = Firestore.firestore()
    var housesRef: CollectionReference!
    private init() {}
    
    //MARK: - Auth
    /// - note: kakao Auth Create - 소셜 로그인 계정 생성
    func kakaoAuthCreate(kuser: KakaoSDKUser.User?, completion: @escaping (Result<Bool, Error>) -> Void) {
        guard let email = kuser?.kakaoAccount?.email,
              let id = kuser?.id else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey : "Invalid user data"]))) /// 이메일 권한 누락 확인용.
            return
        }
        Auth.auth().createUser(withEmail: email, password: "\(id)") { _, error in
            if let error = error {
                print("FB : signup failed. \(error)")
                
                Auth.auth().signIn(withEmail: email, password: "\(id)") { _, error in
                    if let error = error {
                        print("FB : signin failed. \(error)")
                        completion(.failure(error))
                    } else {
                        print("FB : signin success")
                        completion(.success(true))
                        ///테스트
                        if let user = Auth.auth().currentUser {
                            print("FIRUser: \(user.uid)")
                        }
                    }
                }
            } else {
                print("FB : signup success")
                completion(.success(true))
                ///테스트
                if let user = Auth.auth().currentUser {
                    print("FIRUser: \(user.uid)")
                }
            }
        }
    }
    /// - note: Apple Auth Create
    /// - note: Auth Logout - Auth 로그아웃
    func authLogout() {
        let auth = Auth.auth()
        do {
            try auth.signOut()
        } catch let signOutError as NSError { /// 오류 잡기
            print("FB : Error signing out - %@", signOutError)
        }
    }
    
    /// - note: Auth Delete - Auth 회원탈퇴
    func authDelete() {
        if let auth = Auth.auth().currentUser {
            auth.delete { error in
                if let error = error {
                    print("FB : Error - ",error)
                } else {
                    print("FB : authDelete success")
                }
            }
        } else {
            print("FB : Error - 로그인 정보가 존재하지 않습니다")
        }
    }
    
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
                        let uid = data["uid"] as! String
                        let title = data["title"] as! String
                        let isBookMarked = data["isBookMarked"] as! Bool
                        let livingType = data["livingType"] as! String
                        let tradingType = data["tradingType"] as! String
                        let address = data["address"] as! String
                        let latitude = data["latitude"] as! Double
                        let longitude = data["longitude"] as! Double
                        let 보증금 = data["deposit"] as! String
                        let 월세 = data["rent_payment"] as! String
                        let 관리비 = data["maintenance_fee"] as! String
                        let 관리비미포함목록 = data["maintenance_non_list"] as! [String]
                        let 면적 = data["area"] as! String
//                        let 입주가능일 = data["movingDay"] as! Date
                        let 계약기간 = data["contractTerm"] as! String
//                        let 체크리스트 = data["checkList"] as! CheckList
                        let 사진 = data["photos"] as! [String]
                        let 기록 = data["memo"] as! String
                        let 별점 = data["rate"] as! Double
                        
                        let house = House(uid: uid, title: title, isBookMarked: isBookMarked, livingType: livingType, tradingType: tradingType, address: address, latitude: latitude, longitude: longitude, 보증금: 보증금, 월세: 월세, 관리비: 관리비, 관리비미포함목록: 관리비미포함목록, 면적: 면적, 입주가능일: Date(), 계약기간: 계약기간, 체크리스트: CheckList(), 기록: 기록, 사진: 사진, 별점: 별점)
                        houses.append(house)
                    }
                    completion(houses)
                } else {
                    print("\(String(describing: error?.localizedDescription))")
                }
            }
        }
        
        
        
        
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
