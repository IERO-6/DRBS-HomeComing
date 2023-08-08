import UIKit



extension UINavigationController {
    func setupBarAppearance() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithDefaultBackground()
        appearance.backgroundColor = .white
        self.title = "도라방스: 임장"
        navigationBar.standardAppearance = appearance
        navigationBar.compactAppearance = appearance
        navigationBar.scrollEdgeAppearance = appearance
        self.navigationController?.navigationBar.isTranslucent = false
        navigationBar.tintColor = .black
        self.navigationController?.navigationBar.barTintColor = .white
        navigationBar.prefersLargeTitles = false
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
}
