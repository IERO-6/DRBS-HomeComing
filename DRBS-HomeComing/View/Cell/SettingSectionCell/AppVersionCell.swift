import UIKit
import Then
import SnapKit

class AppVersionCell: UITableViewCell {
    
    static let id = "AppVersionCell"
    
    // MARK: - Properties
    
    private lazy var stackView = UIStackView().then {
        $0.axis = .horizontal
        $0.alignment = .fill
        $0.distribution = .fill
        $0.spacing = 10
    }

    private let leftTitleLabel = UILabel().then {
        $0.textColor = .label
        $0.font = UIFont(name: Constant.fontRegular, size: 16)
        $0.setContentHuggingPriority(.defaultLow, for: .horizontal)
        $0.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
    }
    
    private let rightTitleLabel = UILabel().then {
        $0.textColor = Constant.appColor
        $0.font = UIFont(name: Constant.fontRegular, size: 14)
        $0.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        $0.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
    }
    
    private let separatorView = UIView().then {
        $0.backgroundColor = .systemGray5
    }
    
    // MARK: - Initialization
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("")
    }
    
    // MARK: - Helpers
    
    private func configureUI() {
        contentView.addSubviews(stackView, separatorView)
        stackView.addArrangedSubviews(leftTitleLabel, rightTitleLabel)
        
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(UIEdgeInsets(top: 13, left: 16, bottom: 13, right: 16))
        }
        
        separatorView.snp.makeConstraints {
            $0.leading.equalTo(contentView).offset(0)
            $0.trailing.equalTo(contentView).offset(0)
            $0.bottom.equalTo(contentView)
            $0.height.equalTo(1)
        }
    }

    func prepare(leftTitleText: String?, rightTitleText: String?) {
        self.leftTitleLabel.text = leftTitleText
        self.rightTitleLabel.text = rightTitleText
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.prepare(leftTitleText: nil, rightTitleText: nil)
    }
}
