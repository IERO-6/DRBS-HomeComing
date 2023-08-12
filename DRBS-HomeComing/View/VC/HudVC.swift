import UIKit
import JGProgressHUD
import Then

class HudVC: UIViewController {
    //MARK: - Properties
    private lazy var hud = JGProgressHUD().then {$0.style = .dark}


    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    //MARK: - Helpers
    func showLoading() {DispatchQueue.main.async {self.hud.show(in: self.view, animated: true)}}
    
    func hideLoading() {DispatchQueue.main.async {self.hud.dismiss(animated: true)}}

    //MARK: - Actions



}
