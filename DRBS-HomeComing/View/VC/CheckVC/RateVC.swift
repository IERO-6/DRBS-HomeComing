import UIKit
import Then
import SnapKit

class RateVC: UIViewController {
    //MARK: - Properties
    private let mainTitleLabel = UILabel().then {
        $0.text = "체크리스트 평가"
        $0.font = UIFont(name: "Pretendard-Bold", size: 18)
        $0.textAlignment = .center
        $0.textColor = .black
    }
    
    private let subTitleLabel = UILabel().then {
        $0.text = "해당 공간은 몇 점짜리 공간이였나요?"
        $0.font = UIFont(name: "Pretendard-Regular", size: 14)
        $0.textColor = .darkGray
        $0.textAlignment = .left
    }
    
    private lazy var rateSlider = UISlider().then {
        $0.minimumValue = 0.0
        $0.maximumValue = 5.0
        
        $0.addTarget(self, action: #selector(valueChanged(_:)), for: .valueChanged)
    }
    
    
    //MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        
    }
    //MARK: - Helpers
    private func configureUI() {
        
    }
    
    private func settingModal() {
        if let sheetPresentationController = sheetPresentationController {
            sheetPresentationController.detents = [.medium()]
            sheetPresentationController.prefersGrabberVisible = true
            sheetPresentationController.preferredCornerRadius = 25
        }
    }
    
    //MARK: - Actions
    @objc func valueChanged(_ sender: UISlider) {
        print(sender.value)
    }
    


}
