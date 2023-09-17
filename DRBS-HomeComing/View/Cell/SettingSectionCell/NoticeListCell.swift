import UIKit
import Then
import SnapKit

class NoticeListCell: UITableViewCell {
    
    static let id = "NoticeListCell"
    
    // MARK: - Properties

    private lazy var titleLabel = UILabel().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = UIFont(name: Constant.fontRegular, size: 14)
        $0.numberOfLines = 0
        $0.lineBreakStrategy = .hangulWordPriority
        $0.setContentHuggingPriority(.defaultHigh, for: .vertical)
        $0.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
    }

    private lazy var dateLabel = UILabel().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = UIFont(name: Constant.fontRegular, size: 12)
        $0.textColor = .lightGray
    }
    
    private lazy var stackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 15
        $0.distribution = .fill
    }

    // MARK: - Initialization & Setup

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.addSubview(stackView)
        stackView.addArrangedSubviews(titleLabel, dateLabel)
        
        stackView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.bottom.equalToSuperview().offset(-20)
        }
        
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
        }

        contentView.addSubview(dateLabel)
        dateLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
            $0.leading.equalTo(titleLabel)
            $0.bottom.equalToSuperview().offset(-20)
        }
        
    }

    required init?(coder: NSCoder) {
        fatalError("")
    }

    func configure(title: String, date: String) {
        titleLabel.text = title
        dateLabel.text = date
    }


}
