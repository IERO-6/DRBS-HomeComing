import UIKit
import FirebaseCore
import FirebaseAuth
import KakaoSDKAuth

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        FirebaseApp.configure()  ///Firebase 구동
        
        self.window = UIWindow(windowScene: windowScene)
        
        /// Auth 로그인 상태 검증
        if Auth.auth().currentUser != nil {
            DispatchQueue.global().async {
                NetworkingManager.shared.fetchHouses { houses in
                    DispatchQueue.main.async {
                        let tabbarController = self.setupTabBarController(with: houses)
                        self.window?.rootViewController = tabbarController
                        self.window?.makeKeyAndVisible()
                    }
                }
            }
        } else {
            self.window?.rootViewController = LoginVC()
            self.window?.makeKeyAndVisible()
        }
    }
    
    //MARK: Kakao Auth handle
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        if let url = URLContexts.first?.url {
            if AuthApi.isKakaoTalkLoginUrl(url) {
                _ = AuthController.handleOpenUrl(url: url)
            }
        }
    }
    
    //MARK: TabBar 구성
    func setupTabBarController(with houses: [House]) -> UITabBarController {
        let vc1 = HomeVC()
        let vc2 = MapVC()
        
        vc1.tabBarItem = UITabBarItem(title: "홈", image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"))
        vc2.tabBarItem = UITabBarItem(title: "지도", image: UIImage(systemName:"map"), selectedImage:UIImage(systemName:"map.fill"))
        
        let nav1 = UINavigationController(rootViewController :vc1)
        let nav2 = UINavigationController(rootViewController :vc2)
        
        nav1.setupHomeBarAppearance()
        nav2.setupMapBarAppearance()
        
        vc1.homeVChouses = houses
        
        let tabbarController = UITabBarController()
        tabbarController.viewControllers=[nav1 ,nav2]
        
        return tabbarController
    }
    
    //MARK: changeRootViewController - 화면 전환 함수
    func changeRootViewController (_ vc: UIViewController, animated: Bool) {
        guard let window = self.window else { return }
        
        if vc is Tabbar {
            DispatchQueue.global().async {
                let cuid = Auth.auth().currentUser?.uid
                NetworkingManager.shared.fetchHousesWithCurrentUser(currentUser: cuid) { houses in
                    DispatchQueue.main.async {
                        let tabbarController = self.setupTabBarController(with: houses)
                        self.window?.rootViewController = tabbarController
                        self.window?.makeKeyAndVisible()
                    }
                }
            }
        } else {
            window.rootViewController = vc // 전환
        }
        UIView.transition(with: window, duration: 0.7, options: [.transitionCrossDissolve], animations: nil, completion: nil)/// 딜레이
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
}

