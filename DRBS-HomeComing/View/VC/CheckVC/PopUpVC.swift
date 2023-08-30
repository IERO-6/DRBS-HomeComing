import UIKit
import SnapKit
import Then

final class PopUpVC: UIViewController {
    //MARK: - Properties
    var images: [UIImage?] = [] // 모든 이미지를 포함하는 배열
    var currentIndex: Int = 0 // 현재 표시된 이미지의 인덱스
    
    lazy var popUpView = PopUpView()
        
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        settingActions()
        popUpView.updateImage(images[currentIndex])
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
        currentIndex = (currentIndex - 1 + images.count) % images.count
        popUpView.updateImage(images[currentIndex])
    }
    
    @objc func rightButtonTapped() {
        print(#function)
        currentIndex = (currentIndex + 1) % images.count
        popUpView.updateImage(images[currentIndex])
    }
    
    @objc func tapGesture() {
//        print(#function)
        print(currentIndex)
        dismiss(animated: true)
    }
}
