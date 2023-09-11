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
import AuthenticationServices
import CryptoKit             /// 해시 값 추가

class LoginVC: UIViewController, ASAuthorizationControllerPresentationContextProviding {
    
    // MARK: - Properties
    let logoLabel = UILabel().then {
        $0.font = UIFont(name: "Pretendard-SemiBold", size: 32)
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.1
        $0.attributedText = NSMutableAttributedString(string: "작은 것도\n하나하나 꼼꼼한\n부동산 체크리스트", attributes: [NSAttributedString.Key.kern: -0.3, NSAttributedString.Key.paragraphStyle: paragraphStyle])
        $0.textAlignment = .left
        $0.textColor = .white
        $0.numberOfLines = 0
        $0.lineBreakMode = .byWordWrapping
    }
    
    let subtitleLabel = UILabel().then {
        $0.font = UIFont(name: "Pretendard-Medium", size: 16)
        $0.text = "도라방스와 함께 해보세요."
        $0.textAlignment = .left
        $0.textColor = .white
    }
    
    private lazy var kakaoLoginButton = UIButton(type: .custom).then {
        $0.setImage(UIImage(named: "login-kakao-button"), for: .normal)
        $0.imageView?.contentMode = .scaleAspectFit
        $0.addTarget(self, action: #selector(kakaoLoginButtonTapped), for: .touchUpInside)
    }
    
    private lazy var authorizationAppleIDButton = ASAuthorizationAppleIDButton().then {
        $0.addTarget(self, action: #selector(appleLoginButtonTapped), for: .touchUpInside)
    }
    
    let versionLabel = UILabel().then {
        $0.font = UIFont(name: "Pretendard", size: 10)
        $0.text = "App ver. 1.0.0"
        $0.textAlignment = .center
        $0.textColor = UIColor(red: 0.64, green: 0.62, blue: 0.62, alpha: 1.0)
    }
    
    let labelsStack = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 8
    }
    
    let buttonsStack = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 12
    }
    
    private lazy var authVM: AuthViewModel = AuthViewModel()
    private var currentNonce: String? /// 현재 Nonce
    
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
        buttonsStack.addArrangedSubviews(authorizationAppleIDButton, kakaoLoginButton)
        
        view.addSubviews(labelsStack, buttonsStack, versionLabel)
        
        authorizationAppleIDButton.snp.makeConstraints {
            $0.width.equalTo(345)
            $0.height.equalTo(54)
        }
        kakaoLoginButton.snp.makeConstraints {
            $0.width.equalTo(345)
            $0.height.equalTo(54)
        }
        labelsStack.snp.makeConstraints {
            $0.top.equalToSuperview().offset(170)
            $0.leading.equalToSuperview().offset(28)
        }
        buttonsStack.snp.makeConstraints {
            $0.bottom.equalTo(versionLabel.snp.top).offset(-56)
            $0.centerX.equalToSuperview()
        }
        versionLabel.snp.makeConstraints {
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(0)
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
        startSignInWithAppleFlow()
    }
    
    @objc func kakaoLoginButtonTapped() {
        print("kakaoLoginButtonTapped()")
        authVM.kakaoLogin()
        
        /// 비동기라 여기 작성하기가 힘들듯. Combine Publisher 사용..?
    }
}

extension LoginVC {
    /// - note : 애플 로그인
    func startSignInWithAppleFlow() {
        let nonce = randomNonceString()
        currentNonce = nonce
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        
        /// request 요청을 했을 때 nonce가 포함되어서 릴레이 공격을 방지
        request.requestedScopes = [.fullName, .email]
        request.nonce = sha256(nonce)
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
    
    /// - note : 난수 생성
    private func sha256(_ input: String) -> String {
        let inputData = Data(input.utf8)
        let hashedData = SHA256.hash(data: inputData)
        let hashString = hashedData.compactMap {
            return String(format: "%02x", $0)
        }.joined()
        
        return hashString
    }
    
    /// - note : 난수 문자열 조합
    private func randomNonceString(length: Int = 32) -> String {
        precondition(length > 0)
        let charset: Array<Character> =
        Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
        var result = ""
        var remainingLength = length
        
        while remainingLength > 0 {
            let randoms: [UInt8] = (0 ..< 16).map { _ in
                var random: UInt8 = 0
                let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
                if errorCode != errSecSuccess {
                    fatalError("Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)")
                }
                return random
            }
            
            randoms.forEach { random in
                if remainingLength == 0 {
                    return
                }
                
                if random < charset.count {
                    result.append(charset[Int(random)])
                    remainingLength -= 1
                }
            }
        }
        
        return result
    }
}

//MARK: - ASAuthorizationControllerDelegate
extension LoginVC: ASAuthorizationControllerDelegate {
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            
            let userIdentifier = appleIDCredential.user
//            let userFirstName = appleIDCredential.fullName?.givenName
//            let userLastName = appleIDCredential.fullName?.familyName
//            let userEmail = appleIDCredential.email
            let appleIDProvider = ASAuthorizationAppleIDProvider()
            
            guard let nonce = currentNonce else {
                fatalError("Invalid state: A login callback was received, but no login request was sent.")
            }
            guard let appleIDToken = appleIDCredential.identityToken else {
                print("Unable to fetch identity token")
                return
            }
            guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
                print("Unable to serialize token string from data: \(appleIDToken.debugDescription)")
                return
            }
            
            
            appleIDProvider.getCredentialState(forUserID: userIdentifier) { (credentialState, error) in
                switch credentialState {
                case .authorized:
                    // The Apple ID credential is valid. Show Home UI Here
                    // authorized - 사용자의 identifier 가 정상적으로 인식되었을 경우
                    
                    let credential = OAuthProvider.credential(withProviderID: "apple.com", idToken: idTokenString, rawNonce: nonce)
                    
                    Auth.auth().signIn(with: credential) { authResult, error in
                        if let error = error {
                            print ("Error Apple sign in: %@", error)
                            return
                        }
                        /// Main 화면으로 보내기
                        let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
                        sceneDelegate?.changeRootViewController(Tabbar(), animated: true)
                        UserDefaults.standard.set("APPLE", forKey: "social") /// userDefault에 기록
                    }
                    
                    break
                case .revoked:
                    // The Apple ID credential is revoked. Show SignIn UI Here.
                    // revoked- 사용자의 identifier 가 유효하지 않은 경우
                    
                    break
                case .notFound:
                    // No credential was found. Show SignIn UI Here.
                    // notFoun - 사용자의 identifier 를 찾지 못한 경우
                    
                    break
                default:
                    break
                }
            }
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print(error.localizedDescription)
    }
}

//MARK: - ASWebAuthenticationPresentationContextProviding
extension LoginVC: ASWebAuthenticationPresentationContextProviding {
    func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
        return view.window!
    }
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return ASPresentationAnchor()
        //얘는 뭔지 모르겠음!
    }
}
