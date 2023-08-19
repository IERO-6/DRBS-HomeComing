import UIKit
import Then
import SnapKit

class CheckVC2Cell: UITableViewCell {
    //MARK: - Properties

    static let identifierCheckVC2 = "CheckVC2Cell"
    
    let 보증금 = UILabel().then {
        $0.text = "보증금*"
    }
    
    let 보증금TextField = UITextField().then {$0.placeholder = "000"}

    
    let 만원 = UILabel().then {
        $0.text = "만원"
        $0.textColor = .black
        $0.font = UIFont.boldSystemFont(ofSize: 17)
    }
    
    
    //MARK: - LifeCycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addContentView()
        autoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helpers

    private func addContentView() {
        contentView.addSubviews(보증금, 보증금TextField, 만원)
        
    }
    
    private func autoLayout() {
        보증금.snp.makeConstraints {
            $0.leading.equalTo(0)
            $0.top.equalTo(0)
        }
        
        보증금TextField.snp.makeConstraints {
            $0.top.equalTo(보증금.snp.bottom).offset(10)
            $0.height.equalTo(30)

//            $0.leading.equalTo(safeAreaLayoutGuide.snp.leading).offset(23)
//            $0.trailing.equalTo(safeAreaLayoutGuide.snp.trailing).offset(-23)
            
            $0.leading.trailing.equalToSuperview().offset(0)
            
        }
        만원.snp.makeConstraints {
            $0.centerY.equalTo(보증금TextField)
            $0.trailing.equalTo(보증금TextField)
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

}
