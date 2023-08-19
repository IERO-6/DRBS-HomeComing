import UIKit
import Then
import SnapKit

class CheckVC2: UIViewController {
    //MARK: - Properties
    
    private lazy var checkView = UIScrollView(frame: self.view.frame).then {
        $0.backgroundColor = .white
        $0.showsVerticalScrollIndicator = false
        
    }
    
    private lazy var backView = UIView().then {
        $0.backgroundColor = .systemBlue
    }
    
    private lazy var test = UILabel().then {
        $0.text = "sdf"
    }
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        settingTableView()
        
    }
    //MARK: - Helpers
    private func configureUI() {
        view.backgroundColor = .white
        view.addSubview(checkView)
        checkView.addSubview(backView)
        backView.snp.makeConstraints {
            $0.top.bottom.leading.trailing.equalToSuperview()
        }
        backView.addSubview(test)
        test.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.leading.equalToSuperview().offset(20)
        }
        
    }
    
    private func settingTableView() {
       
    }
    
    
    //MARK: - Actions
    
    
    
    
    
    
}


//MARK: - Extensions

