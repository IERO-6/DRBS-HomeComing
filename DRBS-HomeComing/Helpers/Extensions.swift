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
//MARK: - 네비게이션 아이템
extension UINavigationItem {
    func makeSFSymbolButton(_ target: Any?, action: Selector, symbolName: String) -> UIBarButtonItem {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: symbolName), for: .normal)
        button.addTarget(target, action: action, for: .touchUpInside)
        button.tintColor = .black
        let barButtonItem = UIBarButtonItem(customView: button)
        barButtonItem.customView?.translatesAutoresizingMaskIntoConstraints = false
        barButtonItem.customView?.heightAnchor.constraint(equalToConstant: 24).isActive = true
        barButtonItem.customView?.widthAnchor.constraint(equalToConstant: 24).isActive = true
            
        return barButtonItem
    }
    func makeSFSymbolButtonWithMenu(_ target: Any?, action: Selector, symbolName: String) -> UIButton {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: symbolName), for: .normal)
        button.addTarget(target, action: action, for: .touchUpInside)
        button.tintColor = .black
        
        
        return button
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
//MARK: - 스택뷰

extension UIStackView {
    func addArrangedSubviews(_ views: UIView...) {
        for view in views {addArrangedSubview(view)}
    }
}

//MARK: - CALayer

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

//MARK: - Encodable

extension Encodable {
    /// Object to Dictionary
    /// cf) Dictionary to Object: JSONDecoder().decode(Object.self, from: dictionary)
    var asDictionary: [String: Any]? {
        guard let object = try? JSONEncoder().encode(self),
              let dictinoary = try? JSONSerialization.jsonObject(with: object, options: []) as? [String: Any] else { return nil }
        return dictinoary
    }
}

//MARK: - String

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

//MARK: - UIImage
extension UIImage {
    func toPngString() -> String? {
        let data = self.pngData()
//        let encodedString = data?.base64EncodedString(options: .endLineWithLineFeed)
        let encodedString = data?.base64EncodedString()
        return encodedString
    }
    
    //from/종권위키
    func resize(targetSize: CGSize) -> UIImage? {
        let newRect = CGRect(x: 0, y: 0, width: targetSize.width, height: targetSize.height).integral
        UIGraphicsBeginImageContextWithOptions(newRect.size, true, 0)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        context.interpolationQuality = .high
        draw(in: newRect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
}

//MARK: - 뷰컨
extension UIViewController {
    func presentAlert(alertTitle: String, message: String, confirmMessage: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: alertTitle, message: message, preferredStyle: .alert)
            let confirm = UIAlertAction(title: confirmMessage, style: .default)
            alert.addAction(confirm)
            self.present(alert, animated: true)
        }
    }
    func goSettingAlert() {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "위치 정보 이용", message: "위치 서비스를 사용할 수 없습니다.\n디바이스의 '설정 > 개인정보 보호'에서 위치 서비스를 켜주세요.", preferredStyle: .alert)
            let goSetting = UIAlertAction(title: "설정으로 이동", style: .default) { _ in
                if let appSetting = URL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(appSetting)
                }
            }
            alert.addAction(goSetting)
            self.present(alert, animated: true)
        }
    }
}
//MARK: - MKMapView
extension MKMapView {
    func limitRegionToKorea(currentRegion: MKCoordinateRegion) {
        let koreaCoordinateRegion = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 36.5, longitude: 127.5), // 대한민국 중심 좌표
            span: MKCoordinateSpan(latitudeDelta: 5.0, longitudeDelta: 5.0) // 지도 확대 정도
        )
        if currentRegion.center.latitude < koreaCoordinateRegion.center.latitude - koreaCoordinateRegion.span.latitudeDelta / 2 {
            // 위로 스크롤 시
            self.setRegion(koreaCoordinateRegion, animated: true)
        } else if currentRegion.center.latitude > koreaCoordinateRegion.center.latitude + koreaCoordinateRegion.span.latitudeDelta / 2 {
            // 아래로 스크롤 시
            self.setRegion(koreaCoordinateRegion, animated: true)
        } else if currentRegion.center.longitude < koreaCoordinateRegion.center.longitude - koreaCoordinateRegion.span.longitudeDelta / 2 {
            // 왼쪽으로 스크롤 시
            self.setRegion(koreaCoordinateRegion, animated: true)
        } else if currentRegion.center.longitude > koreaCoordinateRegion.center.longitude + koreaCoordinateRegion.span.longitudeDelta / 2 {
            // 오른쪽으로 스크롤 시
            self.setRegion(koreaCoordinateRegion, animated: true)
        }
    }
}

extension CLLocationCoordinate2D: Codable {
    public func encode(to encoder: Encoder) throws {
        var container = encoder.unkeyedContainer()
        try container.encode(latitude)
        try container.encode(longitude)
    }
    
    public init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        let latitude = try container.decode(CLLocationDegrees.self)
        let longitude = try container.decode(CLLocationDegrees.self)
        self.init(latitude: latitude, longitude: longitude)
    }
}
