//
//  LoginVC.swift
//  DRBS-HomeComing
//
//  Created by 준호 on 2023/08/16.
//

import UIKit
import SnapKit
import Then
import FirebaseAuth

class LoginVC: UIViewController {
    
    // MARK: - Properties
    let logoLabel = UILabel().then {
        $0.font = UIFont(name: "Pretendard-Bold", size: 64)
        $0.text = "DRBS:"
        $0.textAlignment = .center
        $0.textColor = .white
    }
    
    let subtitleLabel = UILabel().then {
        $0.font = UIFont(name: "Pretendard-Bold", size: 18)
        $0.text = "HomeComing"
        $0.textAlignment = .center
        $0.textColor = .white
    }
    
    private lazy var appleLoginButton = UIButton(type: .custom).then {
        $0.setImage(UIImage(named: "login-apple-button"), for: .normal)
        $0.imageView?.contentMode = .scaleAspectFit
        $0.addTarget(self, action: #selector(appleLoginButtonTapped), for: .touchUpInside)
    }
    
    private lazy var kakaoLoginButton = UIButton(type: .custom).then {
        $0.setImage(UIImage(named: "login-kakao-button"), for: .normal)
        $0.imageView?.contentMode = .scaleAspectFit
        $0.addTarget(self, action: #selector(kakaoLoginButtonTapped), for: .touchUpInside)
    }
    
    let versionLabel = UILabel().then {
        $0.font = UIFont(name: "Pretendard", size: 10)
        $0.text = "App ver. 1.0.0"
        $0.textAlignment = .center
        $0.textColor = UIColor(red: 0.64, green: 0.62, blue: 0.62, alpha: 1.0)
    }
    
    let labelsStack = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 0
    }
    
    let buttonsStack = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 10
    }
    
    private lazy var authVM: AuthViewModel = AuthViewModel()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - Helpers
    func configureUI() {
        let topColor = Constant.appColor.cgColor
        let bottomColor = UIColor(red: 0.56, green: 0.12, blue: 0.12, alpha: 1).cgColor
        
        let gradientLayer = createGradientLayer(colors: [topColor, bottomColor], frame: view.bounds)
        view.layer.insertSublayer(gradientLayer, at: 0)
        
        labelsStack.addArrangedSubviews(logoLabel, subtitleLabel)
        buttonsStack.addArrangedSubviews(appleLoginButton, kakaoLoginButton)
        view.addSubviews(labelsStack, buttonsStack, versionLabel)
        
        appleLoginButton.snp.makeConstraints {
            $0.width.equalTo(345)
            $0.height.equalTo(54)
        }
        kakaoLoginButton.snp.makeConstraints {
            $0.width.equalTo(345)
            $0.height.equalTo(54)
        }
        labelsStack.snp.makeConstraints {
            $0.top.equalToSuperview().offset(200)
            $0.centerX.equalToSuperview()
        }
        buttonsStack.snp.makeConstraints {
            $0.bottom.equalTo(versionLabel.snp.top).offset(-120)
            $0.centerX.equalToSuperview()
        }
        versionLabel.snp.makeConstraints {
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(-47)
            $0.centerX.equalToSuperview()
        }
    }
    
    /// - note : - 그라데이션
    func createGradientLayer(colors: [CGColor], frame: CGRect) -> CAGradientLayer {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = frame
        
        return gradientLayer
    }
    
    // MARK: - Action
    @objc func appleLoginButtonTapped() {
        print("appleLoginButtonTapped()")
        /// 애플 로그인 로직
    }
    
    @objc func kakaoLoginButtonTapped() {
        print("kakaoLoginButtonTapped()")
        authVM.kakaoLogin()
        
        /// 비동기라 여기 작성하기가 힘들듯. Combine Publisher 사용..?
    }
}
