import UIKit

final class Tabbar: UITabBarController {
    //MARK: - Properties
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTabbar()
    }
    //MARK: - Helpers
    private func configureTabbar() {
        self.tabBar.isTranslucent = false
        self.tabBar.backgroundColor = .white
        self.tabBar.tintColor = Constant.appColor
    }
}
