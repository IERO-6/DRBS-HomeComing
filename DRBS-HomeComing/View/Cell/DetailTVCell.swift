import UIKit
import Then
import SnapKit

class DetailTVCell: UITableViewCell {
    
    //MARK: - Properties

    static let identifier = "DetailTVCell"
    
    let nameLabel = UILabel().then {
        $0.text = "신대방역 근처 원룸"
    }
    
    let priceLabel = UILabel().then {
        $0.font = UIFont.boldSystemFont(ofSize: 16)
    }
    
    let roomImageView = UIImageView().then {
        $0.image = UIImage(named: "roomImage")
    }
    
    let starsNumber = UILabel().then {
        $0.textColor = .black
    }
    
    let starImageView = UIImageView().then {
        $0.image = UIImage(named: "star")
    }
    
    let bookMarkButton = UIButton().then {
        if let bookMarkImage = UIImage(systemName: "bookmark") {
            $0.setImage(bookMarkImage, for: .normal)
            $0.tintColor = Constant.appColor
        }
    }
    
    let memoTextField = UITextView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .systemGray6
        $0.isScrollEnabled = false
        $0.font = UIFont.systemFont(ofSize: 16)
        $0.textContainer.maximumNumberOfLines = 2
        $0.textContainer.lineBreakMode = .byTruncatingTail
    }
    //MARK: - LifeCycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        bookMarkButton.addTarget(self, action: #selector(bookMarkButtonTapped), for: .touchUpInside)
        
        addContentView()
        autoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Helpers
    
    private func addContentView() {
        contentView.addSubviews(nameLabel, priceLabel, roomImageView, starsNumber, starImageView, memoTextField, bookMarkButton)
    }
    
    private func autoLayout() {
        
        roomImageView.snp.makeConstraints {
            $0.top.equalTo(priceLabel.snp.bottom).offset(10)
            $0.leading.equalTo(0)
            $0.size.width.height.equalTo(100)
        }
        
        nameLabel.snp.makeConstraints {
            $0.leading.equalTo(0)
            $0.top.equalTo(0)
        }
        
        priceLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).inset(-10)
            $0.leading.equalTo(0)
        }
        
        starsNumber.snp.makeConstraints {
            $0.top.equalTo(0)
            $0.trailing.equalTo(-35)
        }
        
        starImageView.snp.makeConstraints {
            $0.top.equalTo(0)
            $0.trailing.equalTo(-60)
            $0.size.width.height.equalTo(20)
        }
        memoTextField.snp.makeConstraints {
            $0.bottom.equalTo(-15)
            $0.trailing.leading.equalTo(0)
            $0.height.equalTo(60)
        }
        bookMarkButton.snp.makeConstraints {
            $0.top.trailing.equalTo(0)
            $0.size.height.width.equalTo(20)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    //MARK: - Actions

    //버튼을 눌렀을 때, 꽉찬북마크가 나타나게
    @objc private func bookMarkButtonTapped() {
        bookMarkButton.isSelected.toggle()
        let bookMarkImage = bookMarkButton.isSelected ? "bookmark.fill" : "bookmark"
        if let fillBookMarkImage = UIImage(systemName: bookMarkImage) {
            bookMarkButton.setImage(fillBookMarkImage, for: .normal)
        }
    }
}
