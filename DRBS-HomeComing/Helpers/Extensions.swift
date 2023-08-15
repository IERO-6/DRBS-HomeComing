import UIKit


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
//        navigationBar color 뷰 컬러와 동일하게 맞추기
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        //navigationBar bottom bolder line 제거하기
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
    }
}

//MARK: - 뷰

extension UIView {

    // 한 번에 여러 객체 addSubView하기
    func addSubviews(_ views: UIView...) {
        for view in views {
            addSubview(view)
        }
    }
}
extension UIStackView {
    
    func addArrangedSubviews(_ views: UIView...) {
        for view in views {
            addArrangedSubview(view)
        }
    }

}

extension UIColor {
    class var mainColor: UIColor? { return UIColor(named: "mainColor") }
}
