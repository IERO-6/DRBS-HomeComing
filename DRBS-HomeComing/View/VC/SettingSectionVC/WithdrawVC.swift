import UIKit
import Then
import SnapKit

class WithdrawVC: UIViewController {
    
    // MARK: - Properties
    
    private let infoTexts = [
        "탈퇴 하시게 되면 저장했던 모든 정보는 삭제 됩니다.",
        "탈퇴 후에는 작성하신 리뷰를 수정, 삭제하실 수 없습니다. 탈퇴 하시기 전에 확인해주세요!",
        "탈퇴 하시게 되면 저장했던 모든 정보는 삭제 됩니다."
    ]
    
    private let titleLabel = UILabel().then {
        $0.text = "정말 탈퇴하시겠어요?"
        $0.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
    }
    
    private lazy var infoViews: [UIStackView] = {
        return infoTexts.map { text in
            let icon = UIImageView().then {
                $0.image = UIImage(systemName: "exclamationmark.triangle")
                $0.tintColor = UIColor(red: 0.75, green: 0.75, blue: 0.75, alpha: 1.00)
            }
            
            let label = UILabel().then {
                $0.text = text
                $0.numberOfLines = 0
                $0.font = UIFont.systemFont(ofSize: 14)
            }
            
            let stackView = UIStackView(arrangedSubviews: [icon, label]).then {
                $0.axis = .horizontal
                $0.spacing = 8
                $0.alignment = .center
            }
            
            return stackView
        }
    }()
    
    private lazy var checkBoxButton = UIButton().then {
        $0.setImage(UIImage(systemName: "square"), for: .normal)
        $0.setImage(UIImage(systemName: "checkmark.square.fill"), for: .selected)
        $0.tintColor = UIColor(red: 0.75, green: 0.75, blue: 0.75, alpha: 1.00)
        $0.addTarget(self, action: #selector(handleCheckBox), for: .touchUpInside)
    }

    private let checkBoxLabel = UILabel().then {
        $0.text = "회원 탈퇴 유의사항을 확인하였으며 동의합니다."
        $0.font = UIFont.systemFont(ofSize: 14)
        $0.textColor = .lightGray
    }

    private let reasonLabel = UILabel().then {
        $0.text = "탈퇴하시는 이유를 알려주세요."
        $0.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
    }

    private let reasonTextView = UITextView().then {
        $0.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.96, alpha: 1.00)
        $0.layer.cornerRadius = 5
    }

    private let withdrawButton = UIButton().then {
        $0.setTitle("탈퇴 하기", for: .normal)
        $0.backgroundColor = UIColor(red: 0.75, green: 0.75, blue: 0.75, alpha: 1.00)
        $0.layer.cornerRadius = 5
    }

    private lazy var checkBoxStackView = UIStackView(arrangedSubviews: [checkBoxButton, checkBoxLabel]).then {
        $0.axis = .horizontal
        $0.spacing = 8
        $0.alignment = .center
    }

    private let scrollView = UIScrollView().then {
        $0.isScrollEnabled = true
    }
    private let contentView = UIView()

    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        configureNav()
        setupScrollView()
        
        self.extendedLayoutIncludesOpaqueBars = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    // MARK: - Navigation Bar
    
    private func configureNav() {
        navigationItem.title = "회원탈퇴"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)

        let appearance = UINavigationBarAppearance().then {
            $0.configureWithOpaqueBackground()
            $0.titleTextAttributes = [.foregroundColor: UIColor.black]
        }
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }

    // MARK: - Method & Action
    
    private func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)

        scrollView.snp.makeConstraints {
            $0.edges.equalTo(view)
        }

        contentView.snp.makeConstraints {
            $0.edges.equalTo(scrollView)
            $0.width.equalTo(view)
        }

        contentView.addSubviews(titleLabel, checkBoxStackView, reasonLabel, reasonTextView, withdrawButton)
        infoViews.forEach(contentView.addSubview)

        titleLabel.snp.makeConstraints {
            $0.top.equalTo(contentView).offset(30)
            $0.left.equalTo(contentView).offset(20)
            $0.right.equalTo(contentView).offset(-20)
        }

        var previousView: UIView = titleLabel

        for infoView in infoViews {
            infoView.snp.makeConstraints {
                $0.top.equalTo(previousView.snp.bottom).offset(20)
                $0.left.equalTo(contentView).offset(20)
            }
            previousView = infoView
        }

        checkBoxStackView.snp.makeConstraints {
            $0.top.equalTo(previousView.snp.bottom).offset(100)
            $0.left.equalTo(contentView).offset(20)
        }

        reasonLabel.snp.makeConstraints {
            $0.top.equalTo(checkBoxStackView.snp.bottom).offset(20)
            $0.left.equalTo(contentView).offset(20)
            $0.right.equalTo(contentView).offset(-20)
        }

        reasonTextView.snp.makeConstraints {
            $0.top.equalTo(reasonLabel.snp.bottom).offset(10)
            $0.left.equalTo(contentView).offset(20)
            $0.width.equalTo(350)
            $0.height.equalTo(200)
        }

        withdrawButton.snp.makeConstraints {
            $0.top.equalTo(reasonTextView.snp.bottom).offset(60)
            $0.centerX.equalTo(contentView)
            $0.width.equalTo(350)
            $0.height.equalTo(60)
            $0.bottom.equalTo(contentView).offset(-20)
        }
    }


    @objc private func handleCheckBox(button: UIButton) {
        button.isSelected = !button.isSelected

        if button.isSelected {
            withdrawButton.backgroundColor = UIColor(red: 0.12, green: 0.27, blue: 0.56, alpha: 1)
            checkBoxButton.tintColor = UIColor(red: 0.12, green: 0.27, blue: 0.56, alpha: 1)
            checkBoxLabel.textColor = UIColor(red: 0.12, green: 0.27, blue: 0.56, alpha: 1)
        } else {
            withdrawButton.backgroundColor = UIColor(red: 0.75, green: 0.75, blue: 0.75, alpha: 1.00)
            checkBoxButton.tintColor = UIColor(red: 0.75, green: 0.75, blue: 0.75, alpha: 1.00)
            checkBoxLabel.textColor = .lightGray
        }
    }



}
