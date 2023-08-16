import UIKit



class Tabbar: UITabBarController {
    //MARK: - Properties
    
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTabbar()

    }
    
    //MARK: - Helpers
    func configureTabbar() {
        self.tabBar.isTranslucent = false
        self.tabBar.backgroundColor = .white
        self.tabBar.tintColor = Constant.appColor
    }
}
