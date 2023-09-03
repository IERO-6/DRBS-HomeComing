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
        let documentRef = db.collection("Homes").document()
        let houseId = documentRef.documentID
        guard let data = houseModel.asDictionary else { return }
            documentRef.setData(data)
        documentRef.updateData(["houseId":houseId])
        
    }
    
    //MARK: - Read
    func fetchHousesWithCurrentUser(currentUser: String? ,completion: @escaping([House]) -> Void) {
        guard let currentUserUID = currentUser else {
            // 현재 사용자 UID를 가져올 수 없으면 종료
            completion([])
            return
        }
        
        db.collection("Homes").whereField("uid", isEqualTo: currentUserUID).getDocuments { querySnapshot, error in
            //현재 유저와 같은 document만 가져옴
            if let error = error {
                print("Error fetching houses: \(error.localizedDescription)")
                completion([])
                return
            }
            guard let documents = querySnapshot?.documents else {
                completion([])
                return
            }
            let houses = documents.compactMap { document -> House? in
                let data = document.data()
                do {
                    let decoder = JSONDecoder()
                    let jsonData = try JSONSerialization.data(withJSONObject: data)
                    let house = try decoder.decode(House.self, from: jsonData)
                    return house
                } catch {
                    print("Error decoding house: \(error.localizedDescription)")
                    return nil
                }
            }
            completion(houses)
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
                        let id = data["houseId"] as! String
                        let location = Location(coordinate: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), isBookMarked: isBookMarked, id: id)
                        locations.append(location)
                    }
                    completion(locations)
                } else if let error = error {
                    print(error.localizedDescription)
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

