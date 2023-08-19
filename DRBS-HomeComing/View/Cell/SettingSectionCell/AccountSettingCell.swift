import UIKit
import Then
import SnapKit

class AccountSettingCell: UITableViewCell {

    static let id = "AccountSettingCell"
    
    // MARK: - Properties
    
    private let stackView = UIStackView().then {
        $0.axis = .horizontal
        $0.alignment = .fill
        $0.distribution = .fill
        $0.spacing = 10
    }

    private let logoutButton = UIButton().then {
        $0.setTitle("로그아웃", for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        $0.setTitleColor(.gray, for: .normal)
    }

    private let withdrawButton = UIButton().then {
        $0.setTitle("회원탈퇴", for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        $0.setTitleColor(.gray, for: .normal)
    }
    
    var logoutAction: (() -> Void)?
    var withdrawAction: (() -> Void)?
    
    // MARK: - Initialization

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
        setupActions()
    }

    required init?(coder: NSCoder) {
        fatalError("")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.separatorInset = UIEdgeInsets(top: 0, left: self.bounds.size.width, bottom: 0, right: 0)
    }


    // MARK: - Helpers
    
    private func configureUI() {
        backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.97, alpha: 1.00)
        
        stackView.addArrangedSubviews(logoutButton, withdrawButton)
        contentView.addSubview(stackView)

        stackView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(13)
            $0.left.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(13)
        }
    }
    
    func prepare(with model: AccountActionModel) {
        logoutButton.setTitle(model.logoutTitle, for: .normal)
        withdrawButton.setTitle(model.withdrawTitle, for: .normal)
        
        self.logoutAction = model.logoutAction
        self.withdrawAction = model.withdrawAction
    }

    // MARK: - Actions
    
    private func setupActions() {
        logoutButton.addTarget(self, action: #selector(handleLogoutPressed), for: .touchUpInside)
        withdrawButton.addTarget(self, action: #selector(handleWithdrawPressed), for: .touchUpInside)
    }

    @objc private func handleLogoutPressed() {
        logoutAction?()
    }

    @objc private func handleWithdrawPressed() {
        withdrawAction?()
    }

}
