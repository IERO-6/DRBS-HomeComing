//
//  AuthViewModel.swift
//  DRBS-HomeComing
//
//  Created by 준호 on 2023/08/30.
//

import UIKit
import KakaoSDKAuth
import KakaoSDKUser
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage

final class AuthViewModel {
    //MARK: - Model
    
    //MARK: - Output
    
    //MARK: - Input
    
    //MARK: - Logics
    /// - note: kakaoLogin - 카카오 로그인
    func kakaoLogin(){
        
        /// 카카오톡 어플이 존재할 경우
        if UserApi.isKakaoTalkLoginAvailable() {
            UserApi.shared.loginWithKakaoTalk {(_, error) in
                if let error = error {
                    print(error)
                } else {
                    //_ = oauthToken
                    //let accessToken = oauthToken?.accessToken
                    
                    self.kakaoInfo()
                }
            }
        } else { /// 카카오톡 어플이 존재하지 않을 경우
            UserApi.shared.loginWithKakaoAccount {(_, error) in
                if let error = error {
                    print(error)
                } else {
                    //                    _ = oauthToken
                    
                    self.kakaoInfo()
                }
            }
        }
    }
    
    /// - note: kakaoInfo - 카카오 로그인 성공 후 Firebase Auth 등록 중계
    func kakaoInfo() {
        UserApi.shared.me { kuser, error in
            if let error = error {
                print("------KAKAO : user loading failed------")
                print(error)
            } else {
                NetworkingManager.shared.kakaoAuthCreate(kuser: kuser) { result in
                    switch result{
                    /// 성공 시
                    case .success(let isSignedIn):
                        if isSignedIn { /// - 로그인 성공 시 처리
                        } else { /// - 이미 계정이 있는 경우 처리
                        }
                        UserDefaults.standard.set("KAKAO", forKey: "social") /// userDefault에 기록
                        
                        /// 화면전환
                        let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
                        sceneDelegate?.changeRootViewController(Tabbar(), animated: true)
                    
                    /// 실패 시
                    case .failure(let err):
                        print(err.localizedDescription)
                    }
                }
            }
        }
    }
    
    /// - note: authLogout - 로그아웃
    func authLogout() {
        /// kakao, apple 구분 후 로그아웃
        if let social = UserDefaults.standard.string(forKey: "social") {
            switch social {
            case "KAKAO":
                UserApi.shared.logout {(error) in
                    if let error = error {
                        print(error)
                    }
                }
            case "APPLE":
                UserApi.shared.logout {(error) in
                    if let error = error {
                        print(error)
                    }
                }
            default:
                break
            }
        }
        
        /// 관련 UserDefault 제거
        UserDefaults.standard.removeObject(forKey: "social")
        
        /// Firebase Auth 로그아웃
        NetworkingManager.shared.authLogout()
        
        /// 테스트
        for (key, value) in UserDefaults.standard.dictionaryRepresentation() {
           print("\(key): \(value)")
        }
        
        /// 화면전환(임시)
        let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
        sceneDelegate?.changeRootViewController(LoginVC(), animated: true)
    }
    
    /// - note: authDelete - 회원탈퇴
    func authDelete() {
        /// kakao, apple 구분 후 회원탈퇴
        if let social = UserDefaults.standard.string(forKey: "social") {
            switch social {
            case "KAKAO":
                UserApi.shared.unlink {(error) in
                    if let error = error {
                        print(error)
                    }
                   
                }
            case "APPLE":
                UserApi.shared.unlink {(error) in
                    if let error = error {
                        print(error)
                    }
                    
                }
            default:
                break
            }
        }
        
        /// 관련 UserDefault 제거
        UserDefaults.standard.removeObject(forKey: "social")
        
        /// 관련 데이터 제거
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let pathToDelete = "\(uid)"
        let storage = Storage.storage().reference()
        let listRef = storage.child("\(uid)")
        listRef.listAll { (result, error) in
            if let error = error {
                print("Error listing files: \(error.localizedDescription)")
                return
            }
            guard let result = result else { return }
            for item in result.items {
                item.delete { error in
                    if let error = error { print("Error deleting file: \(error.localizedDescription)")
                    }
                }
            }
            listRef.delete { error in
                if let error = error {
                    print("Error deleting path: \(error.localizedDescription)")
                }
            }
        }
        
        let db = Firestore.firestore()
        let collectionRef = db.collection("Homes")
        collectionRef.whereField("uid", isEqualTo: uid).getDocuments { snapshot, error in
            if let error = error {
                    print("Error getting documents: \(error.localizedDescription)")
                } else {
                    for document in snapshot!.documents {
                        document.reference.delete { error in
                            if let error = error {
                                print("Error deleting document: \(error.localizedDescription)")
                            } 
                        }
                    }
                }
        }
        
        /// Firebase Auth 회원탈퇴
        NetworkingManager.shared.authDelete()
        
        /// 테스트
        for (key, value) in UserDefaults.standard.dictionaryRepresentation() {
           print("\(key): \(value)")
        }
        
        /// 화면전환(임시)
        let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
        sceneDelegate?.changeRootViewController(LoginVC(), animated: true)
    }
}
