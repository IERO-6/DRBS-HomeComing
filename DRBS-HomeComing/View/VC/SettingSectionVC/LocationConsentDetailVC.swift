import UIKit
import Then
import SnapKit

class LocationConsentDetailVC: UIViewController {
    
    // MARK: - Properties

    
    
    
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white

        configureNav()
    }
    

    // MARK: - Navigation Bar

    private func configureNav() {
        navigationItem.title = "위치기반서비스 이용동의(선택)"
        
        let appearance = UINavigationBarAppearance().then {
            $0.configureWithOpaqueBackground()
            $0.titleTextAttributes = [.foregroundColor: UIColor.black]
        }
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
    }

    
    
    
    
    
}
