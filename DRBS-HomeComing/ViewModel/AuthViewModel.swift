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

final class AuthViewModel {
    //MARK: - Model
    
    //MARK: - Output
    
    //MARK: - Input
    
    //MARK: - Logics
    /// - note: kakaoLogin - 카카오 로그인
    func kakaoLogin(){
        print("LoginViewModel - handleKakaoLogin() called")
        
        /// 카카오톡 어플이 존재할 경우
        if UserApi.isKakaoTalkLoginAvailable() {
            UserApi.shared.loginWithKakaoTalk {(_, error) in
                if let error = error {
                    print(error)
                } else {
                    print("loginWithKakaoTalk() success.")
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
                    print("loginWithKakaoAccount() success.")
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
                            print("notice: 계정 생성에 성공하였습니다.")
                        } else { /// - 이미 계정이 있는 경우 처리
                            print("notice: 이미 계정이 존재합니다.")
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
                    } else {
                        print("kakao logout() success.")
                    }
                }
//            case "APPLE":
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
                    else {
                        print("kakao unlink() success.")
                    }
                }
//            case "APPLE":
            default:
                break
            }
        }
        
        /// 관련 UserDefault 제거
        UserDefaults.standard.removeObject(forKey: "social")
        
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
