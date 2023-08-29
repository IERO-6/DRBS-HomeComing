import UIKit
import SnapKit
import Then

final class PopUpVC: UIViewController {
    //MARK: - Properties
    lazy var popUpView = PopUpView()
        
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        settingActions()
    }
    
    
    //MARK: - Helpers
    private func configureUI() {
        self.view.backgroundColor = .clear
        self.view.addSubview(self.popUpView)
        self.popUpView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func settingActions() {
        popUpView.leftButton.addTarget(self, action: #selector(leftButtonTapped), for: .touchUpInside)
        popUpView.rightButton.addTarget(self, action: #selector(rightButtonTapped), for: .touchUpInside)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGesture))
        self.popUpView.addGestureRecognizer(tapGesture)
        self.popUpView.isUserInteractionEnabled = true
    }
    
    //MARK: - Actions
    
    @objc func leftButtonTapped() {
        print(#function)
    }
    @objc func rightButtonTapped() {
        print(#function)

    }
    @objc func tapGesture() {
        print(#function)
        dismiss(animated: true)
    }
}
