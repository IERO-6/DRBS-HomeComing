import UIKit
import Then
import SnapKit

class OptionCell: UITableViewCell {
    
    static let id = "OptionCell"
    
    // MARK: - Properties
    
    private let stackView: UIStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.alignment = .fill
        $0.distribution = .fill
    }
    
    private let leftTitleLabel = UILabel().then {
        $0.textColor = .label
        $0.font = .systemFont(ofSize: 16)
    }
    
    private let rightButton = UIButton().then {
        $0.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        $0.tintColor = Constant.appColor
        $0.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        $0.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
    }
    
    private let separatorView = UIView().then {
        $0.backgroundColor = .systemGray5
    }
    
    // MARK: - Initialization
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("")
    }
    
    // MARK: - Helpers
    
    private func configureUI() {
        stackView.addArrangedSubviews(leftTitleLabel, rightButton)
        contentView.addSubviews(stackView, separatorView)
        
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
    
    func prepare(leftTitleText: String?) {
        self.leftTitleLabel.text = leftTitleText
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.prepare(leftTitleText: nil)
    }
}
