import UIKit
import Then
import SnapKit

class NoticeListCell: UITableViewCell {
    
    static let id = "NoticeListCell"
    
    // MARK: - Properties

    private lazy var titleLabel = UILabel().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = .systemFont(ofSize: 14)
        $0.numberOfLines = 0
        //$0.lineBreakMode = .byWordWrapping // 단어 단위로 줄바꿈 (단어 전체가 들어갈 공간이 없으면 다음 줄로 줄바꿈)
        $0.lineBreakStrategy = .hangulWordPriority
        $0.setContentHuggingPriority(.defaultHigh, for: .vertical)
        $0.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
    }

    private lazy var dateLabel = UILabel().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = .systemFont(ofSize: 12)
        $0.textColor = .lightGray
    }
    
//    lazy var buttonImageView = UIImageView(image: UIImage(systemName: "chevron.right")).then {
//        $0.translatesAutoresizingMaskIntoConstraints = false
//        $0.contentMode = .scaleAspectFit
//        $0.tintColor = .lightGray
//    }
    
    private lazy var stackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 15
        $0.distribution = .fill
    }

    // MARK: - Initialization & Setup

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.bottom.equalToSuperview().offset(-20)
        }
        
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(dateLabel)
        //stackView.addArrangedSubview(buttonImageView)

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
        
//        contentView.addSubview(buttonImageView)
//        buttonImageView.snp.makeConstraints {
//            $0.centerY.equalToSuperview()
//            $0.trailing.equalToSuperview().offset(-20)
//            $0.width.equalTo(20)
//            $0.height.equalTo(20)
//        }

        
    }

    required init?(coder: NSCoder) {
        fatalError("")
    }

    func configure(title: String, date: String) {
        titleLabel.text = title
        dateLabel.text = date
    }


}
