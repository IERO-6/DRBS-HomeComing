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
        $0.addArrangedSubview(leftTitleLabel)
        $0.addArrangedSubview(rightTitleLabel)
    }

    private let leftTitleLabel = UILabel().then {
        $0.textColor = .label
        $0.font = .systemFont(ofSize: 16)
        $0.setContentHuggingPriority(.defaultLow, for: .horizontal)
        $0.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
    }
    
    private let rightTitleLabel = UILabel().then {
        $0.textColor = UIColor(red: 0.12, green: 0.27, blue: 0.56, alpha: 1)
        $0.font = .systemFont(ofSize: 14)
        $0.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        $0.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
    }
    
    // MARK: - Initialization
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("")
    }
    
    // MARK: - Setup Layout
    
    private func setupLayout() {
        contentView.addSubview(stackView)
            
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(UIEdgeInsets(top: 13, left: 16, bottom: 13, right: 16))
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
