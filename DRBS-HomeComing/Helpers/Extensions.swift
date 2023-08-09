import UIKit



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
