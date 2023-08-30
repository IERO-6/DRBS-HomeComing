import Then
import SnapKit
import UIKit

final class PopUpView: UIView {
    //MARK: - Properties
    var image: UIImage?
    
    lazy var popupView = UIImageView().then {
        $0.layer.cornerRadius = 12
        $0.clipsToBounds = true
        $0.contentMode = .scaleAspectFill
    }
    
    lazy var leftButton = UIButton().then {
        $0.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        $0.tintColor = .white
    }
    
    lazy var rightButton = UIButton().then {
        $0.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        $0.tintColor = .white
    }
    
    
    //MARK: - LifeCycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helpers
    private func configureUI() {
        self.backgroundColor = .black.withAlphaComponent(0.3)
        popupView.image = image
        self.addSubviews(self.popupView, self.leftButton, self.rightButton)
        self.popupView.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(32)
            $0.height.equalTo(300)
            $0.centerY.equalToSuperview()
        }
        self.leftButton.snp.makeConstraints {
            $0.centerY.equalTo(popupView)
            $0.leading.equalToSuperview().offset(10)
            $0.width.height.equalTo(30)
        }
        self.rightButton.snp.makeConstraints {
            $0.centerY.equalTo(popupView)
            $0.trailing.equalToSuperview().offset(-10)
            $0.width.height.equalTo(30)
        }
    }
    
    func updateImage(_ image: UIImage?) {
        popupView.image = image
    }
    
    
    //MARK: - Actions
   
    
}
