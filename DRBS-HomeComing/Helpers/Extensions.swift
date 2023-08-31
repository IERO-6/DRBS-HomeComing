import UIKit
import MapKit
import CoreLocation

//MARK: - 네비게이션

extension UINavigationController {
    func setupHomeBarAppearance() {
        self.navigationController?.navigationBar.isTranslucent = false
        navigationBar.tintColor = .black
        self.navigationController?.navigationBar.barTintColor = .white
        navigationBar.prefersLargeTitles = false
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }

    func setupMapBarAppearance() {
        self.navigationController?.navigationBar.shadowImage = UIImage()
        //navigationBar color 뷰 컬러와 동일하게 맞추기
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        //navigationBar bottom bolder line 제거하기
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
}

//MARK: - 뷰

extension UIView {
    // 한 번에 여러 객체 addSubView하기
    func addSubviews(_ views: UIView...) {
        for view in views { addSubview(view) }
    }
    static func createSeparatorLine() -> UIView {
        let separator = UIView()
        separator.backgroundColor = .systemGray5
        return separator
    }
}

extension UIStackView {
    func addArrangedSubviews(_ views: UIView...) {
        for view in views {addArrangedSubview(view)}
    }
}

extension CALayer {
    func addBottomLayer() {
        let border = CALayer()
        border.borderColor = UIColor.systemGray4.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - 1, width:  self.frame.size.width, height: 1)
        border.borderWidth = 1
        self.addSublayer(border)
        self.masksToBounds = true
    }
}
extension Encodable {
    /// Object to Dictionary
    /// cf) Dictionary to Object: JSONDecoder().decode(Object.self, from: dictionary)
    var asDictionary: [String: Any]? {
        guard let object = try? JSONEncoder().encode(self),
              let dictinoary = try? JSONSerialization.jsonObject(with: object, options: []) as? [String: Any] else { return nil }
        return dictinoary
    }
}
extension UIWindow {
    
    public var visibleViewController: UIViewController? {
        return self.visibleViewControllerFrom(vc: self.rootViewController)
    }
    
    /**
     # visibleViewControllerFrom
     - Author: suni
     - Date:
     - Parameters:
        - vc: rootViewController 혹은 UITapViewController
     - Returns: UIViewController?
     - Note: vc내에서 가장 최상위에 있는 뷰컨트롤러 반환
    */
    public func visibleViewControllerFrom(vc: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nc = vc as? UINavigationController {
            return self.visibleViewControllerFrom(vc: nc.visibleViewController)
        } else if let tc = vc as? UITabBarController {
            return self.visibleViewControllerFrom(vc: tc.selectedViewController)
        } else {
            if let pvc = vc?.presentedViewController {
                return self.visibleViewControllerFrom(vc: pvc)
            } else {
                return vc
            }
        }
    }
}

extension String {
    func makeStringToUIImage(string: String) -> UIImage? {
        if let data = Data(base64Encoded: string, options: .ignoreUnknownCharacters) {
            return UIImage(data: data)
        }
        return nil
    }
    func toImage() -> UIImage? {
        if let data = Data(base64Encoded: self, options: .ignoreUnknownCharacters){
            return UIImage(data: data)
        }
        return nil
    }
}
extension UIImage {
    func toPngString() -> String? {
        let data = self.pngData()
//        let encodedString = data?.base64EncodedString(options: .endLineWithLineFeed)
        let encodedString = data?.base64EncodedString()

        return encodedString
    }
}
