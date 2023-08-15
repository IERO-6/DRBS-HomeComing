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
        $0.setTitleColor(UIColor(red: 0.12, green: 0.27, blue: 0.56, alpha: 1), for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        $0.contentHorizontalAlignment = .left
    }
    
    let toggleSwitch = UISwitch().then {
        $0.onTintColor = UIColor(red: 0.12, green: 0.27, blue: 0.56, alpha: 1)
    }
    
    var onDetailsButtonTapped: (() -> Void)?
    
    // MARK: - Initialization
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
        detailsButton.addTarget(self, action: #selector(detailsButtonTapped), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("")
    }
    
    // MARK: - Setup
    
    private func setupLayout() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(subTitleLabel)
        contentView.addSubview(detailsButton)
        contentView.addSubview(toggleSwitch)

        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.top.equalToSuperview().offset(16)
        }

        subTitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(4)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalTo(toggleSwitch.snp.leading).offset(-16)
        }

        detailsButton.snp.makeConstraints {
            $0.top.equalTo(subTitleLabel.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(16)
            $0.bottom.equalToSuperview().offset(-16)
        }

        toggleSwitch.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-16)
            $0.centerY.equalToSuperview()
            $0.width.equalTo(51)
            $0.height.equalTo(31)
        }
    }

    // MARK: - Action
    
    @objc private func detailsButtonTapped() {
        onDetailsButtonTapped?()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
}
