//
//  LoginViewModel.swift
//  DRBS-HomeComing
//
//  Created by 준호 on 2023/09/01.
//

import UIKit
import Combine
import KakaoSDKAuth
import KakaoSDKUser

final class LoginViewModel {
    //MARK: - Model
    var subscriptions = Set<AnyCancellable>()
    
    //MARK: - Output
    
    //MARK: - Input
    
    //MARK: - Logics
    func handleKakaoLogin(){
        print("LoginViewModel - handleKakaoLogin() called")
        
        /// 카카오톡 어플이 존재할 경우
        if (UserApi.isKakaoTalkLoginAvailable()) {
            UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                if let error = error {
                    // 예외 처리 (로그인 취소 등)
                    print(error)
                }
                else {
                    print("loginWithKakaoTalk() success.")
                    // do something
                    _ = oauthToken
                    let accessToken = oauthToken?.accessToken
                }
            }
        } else { /// 카카오톡 어플이 존재하지 않을 경우
            UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
                    if let error = error {
                        print(error)
                    }
                    else {
                        print("loginWithKakaoAccount() success.")

                        //do something
                        _ = oauthToken
                    }
                }
        }
    }
}
