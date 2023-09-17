import UIKit
import Then
import SnapKit

final class CategoryNoDataView: UIView {
    
    // MARK: - Properties
    
    private let homeImageView = UIImageView().then {
        $0.image = UIImage(named: "categorie-nodata-page")
        $0.contentMode = .scaleAspectFit
    }

    private let titleLabel = UILabel().then {
        $0.text = "작성된 체크리스트가 존재하지 않습니다"
        $0.font = UIFont(name: Constant.fontSemiBold, size: 24)
        $0.textAlignment = .center
        $0.numberOfLines = 0
    }

    private let subtitleLabel = UILabel().then {
        $0.text = "체크리스트를 추가해주세요"
        $0.textColor = .lightGray
        $0.font = UIFont(name: Constant.fontRegular, size: 16)
        $0.textAlignment = .center
        $0.numberOfLines = 0
    }
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    
    private func configureUI() {
        addSubviews(homeImageView, titleLabel, subtitleLabel)
        
        homeImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(180)
            $0.width.height.equalTo(80)
        }

        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(homeImageView.snp.bottom).offset(30)
            $0.leading.greaterThanOrEqualToSuperview().offset(20)
            $0.trailing.lessThanOrEqualToSuperview().offset(-20)
        }

        subtitleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(titleLabel.snp.bottom).offset(15)
            $0.leading.greaterThanOrEqualToSuperview().offset(20)
            $0.trailing.lessThanOrEqualToSuperview().offset(-20)
        }
    }
}
