import UIKit
import Then
import SnapKit

class LocationSettingCell: UITableViewCell {

    static let id  = "LocationSettingCell"
    
    // MARK: - Properties
    
    let titleLabel = UILabel().then {
        $0.textColor = .black
        $0.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
    }
    
    private let subTitleLabel = UILabel().then {
        $0.textColor = .gray
        $0.text = "위치정보 이용동의 후 DRBS가 내 위치정보를 확인할 수 있습니다"
        $0.font = UIFont.systemFont(ofSize: 12)
        $0.numberOfLines = 0
    }
    
    private let detailsButton = UIButton().then {
        $0.setTitle("위치정보 이용동의 전문보기", for: .normal)
        $0.setTitleColor(Constant.appColor, for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        $0.contentHorizontalAlignment = .left
    }
    
    let toggleSwitch = UISwitch().then {
        $0.onTintColor = Constant.appColor
    }
    
    private let verticalStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 5
        $0.distribution = .fill
        $0.alignment = .leading
    }
    
    var onDetailsButtonTapped: (() -> Void)?
    
    // MARK: - Initialization
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
        detailsButton.addTarget(self, action: #selector(detailsButtonTapped), for: .touchUpInside)
        toggleSwitch.addTarget(self, action: #selector(toggleSwitchValueChanged), for: .valueChanged)
    }
    
    required init?(coder: NSCoder) {
        fatalError("")
    }
    
    // MARK: - Helpers
    
    private func configureUI() {
        verticalStackView.addArrangedSubviews(titleLabel, subTitleLabel, detailsButton)
        contentView.addSubviews(verticalStackView, toggleSwitch)
        
        verticalStackView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.top.equalToSuperview().offset(16)
            $0.trailing.lessThanOrEqualTo(toggleSwitch.snp.leading).offset(-16)
            $0.bottom.lessThanOrEqualToSuperview().offset(-16)
        }

        toggleSwitch.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-16)
            $0.centerY.equalToSuperview()
            $0.width.equalTo(51)
            $0.height.equalTo(31)
        }
    }

    // MARK: - Actions
    
    @objc private func detailsButtonTapped() {
        onDetailsButtonTapped?()
    }
    
    @objc private func toggleSwitchValueChanged(sender: UISwitch) {
        if sender.isOn {
            guard let url = URL(string: UIApplication.openSettingsURLString) else {
                return
            }
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
}
