//
//  AppDelegate.swift
//  TestProject
//
//  Created by 김은상 on 2023/07/29.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

       func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
           // 13이상인 경우에는 SceneDelegate에서 이미 초기화 되었으니까 바로 return
           if #available(iOS 13.0, *) {
               return true
           }
           
           // 13이전의 경우에는 SceneDelegate에서 해주었던 작업을 그대로 진행해주면 된다.
           window = UIWindow()
           
//           let vc1 = HomeVC()
//           let vc2 = MapVC()
//           let nav1 = UINavigationController(rootViewController: vc1)
//           let nav2 = UINavigationController(rootViewController: vc2)
//           let tabbar = Tabbar()
//           tabbar.viewControllers = [nav1, nav2]
//           
//           window?.rootViewController = Tabbar() // 시작 VC 작성해주기
           window?.makeKeyAndVisible()
           return true
       }

    

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

