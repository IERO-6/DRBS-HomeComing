import UIKit
import Then
import SnapKit

class NoticeDetailVC: UIViewController {
    
    // MARK: - Properties
    
    var notice: NoticeList?
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    private let dateLabel = UILabel().then {
        $0.font = UIFont(name: "Pretendard-Medium", size: 14)
        $0.textColor = .gray
        $0.textAlignment = .left
    }
    
    private let titleLabel = UILabel().then {
        $0.font = UIFont(name: "Pretendard-Medium", size: 16)
        $0.textColor = .black
        $0.numberOfLines = 0
        $0.textAlignment = .left
    }
    
    private let contentLabel = UILabel().then {
        $0.font = UIFont(name: "Pretendard", size: 14)
        $0.textColor = .darkGray
        $0.numberOfLines = 0
        $0.textAlignment = .left
    }
    
    private let stackViewContainerView : UIView      = UIView()
    
    // MARK: - lifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        guard let noticeItem = self.notice else { return }
        
        dateLabel.text     = noticeItem.date
        titleLabel.text      = noticeItem.title
        contentLabel.text    = noticeItem.content
        
        configureNav()
        configureUI()
    }
    
    // MARK: - Helpers
    private func configureNav() {
        navigationItem.title = "상세공지"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)

        let appearance = UINavigationBarAppearance().then {
            $0.configureWithOpaqueBackground()
            $0.backgroundColor = Constant.appColor
            $0.titleTextAttributes = [.foregroundColor: UIColor.white]
        }
        
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    private func configureUI() {
        view.addSubviews(dateLabel, titleLabel, stackViewContainerView)
        stackViewContainerView.addSubview(contentLabel)
        
        stackViewContainerView.backgroundColor   = UIColor(red: 0.95, green: 0.95, blue: 0.96, alpha: 1.00)
        
        dateLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(16)
            $0.leading.equalToSuperview().offset(16)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(dateLabel.snp.bottom).offset(6)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        stackViewContainerView.snp.makeConstraints{
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview()
        }
        
        contentLabel.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(20)
        }
    }
    
}
