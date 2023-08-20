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



