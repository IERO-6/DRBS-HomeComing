import UIKit
import SnapKit
import Then

class ModalVC: UIViewController {
    //MARK: - Properties
    private let titleLabel = UILabel().then {
        $0.textColor = .black
        $0.font = UIFont.boldSystemFont(ofSize: 22)
        $0.textAlignment = .left
        
        
    }
    
    private let star = UIImageView().then {
        $0.image = UIImage(named: "star.png")
    }
    
    private let rateLabel = UILabel().then {
        $0.textColor = .systemGray4
        $0.font = UIFont.systemFont(ofSize: 18)
        $0.textAlignment = .left
        
    }
    
    private let addressLabel = UILabel().then {
        $0.textColor = .systemGray4
        $0.font = UIFont.systemFont(ofSize: 14)
        $0.textAlignment = .left
        
    }
    
    private let bookMarkButton = UIButton().then {
        $0.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
//        $0.contentMode = .scaleAspectFit
        $0.contentMode = .scaleToFill
        $0.tintColor = Constant.appColor
        
        
    }
    
    private let 주거형태레이블 = UILabel().then {
        $0.textColor = Constant.appColor
        $0.font = UIFont.systemFont(ofSize: 11)
        $0.textAlignment = .center
        $0.layer.cornerRadius = 5
        $0.layer.borderColor = Constant.appColor.cgColor
        $0.layer.borderWidth = 1
    }
    
    private let 매매형태레이블 = UILabel().then {
        $0.textColor = Constant.appColor
        $0.font = UIFont.systemFont(ofSize: 11)
        $0.textAlignment = .center
        $0.layer.cornerRadius = 5
        $0.layer.borderColor = Constant.appColor.cgColor
        $0.layer.borderWidth = 1
    }
    
    private let costLabel = UILabel().then {
        $0.font = UIFont.boldSystemFont(ofSize: 18)
        $0.textColor = .black
        $0.textAlignment = .left
        
        
    }
    
    private let imageStackView = UIStackView().then {
        $0.backgroundColor = .clear
        $0.axis = .horizontal
        $0.spacing = 5
        $0.distribution = .fillEqually
        
        
    }
    
    private let firstImageView = UIImageView().then {
        $0.layer.cornerRadius = 5
        $0.clipsToBounds = true
    }
    private let secondImageView = UIImageView().then {
        $0.layer.cornerRadius = 5
        $0.clipsToBounds = true
    }
    private let thirdImageView = UIImageView().then {
        $0.layer.cornerRadius = 5
        $0.clipsToBounds = true
    }
    private let fourthImageView = UIImageView().then {
        $0.layer.cornerRadius = 5
        $0.clipsToBounds = true
    }
    
    private let textView = UIView().then {
        $0.backgroundColor = .systemGray4
        $0.layer.cornerRadius = 5
        $0.clipsToBounds = true
        
    }
    
    private let textLabel = UILabel().then {
        $0.textColor = .darkGray
        $0.font = UIFont.systemFont(ofSize: 12)
    }
    
    private lazy var 신대방: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "신대방역 근처 원룸"
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .left
        return label
    }()
    
    
    
    
    private lazy var 천육십: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "1000 / 60"
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .left
        return label
    }()
    
    private lazy var 원룸: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "원룸"
        label.textColor = Constant.appColor
        label.backgroundColor = .white
        label.layer.cornerRadius = 3
        label.clipsToBounds = true
        label.layer.borderColor = UIColor(red: 0.12, green: 0.27, blue: 0.56, alpha: 1.00).cgColor
        label.layer.borderWidth = 1
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var 월세: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "월세"
        label.textColor = Constant.appColor
        label.backgroundColor = .white
        label.layer.cornerRadius = 3
        label.clipsToBounds = true
        label.layer.borderColor = UIColor(red: 0.12, green: 0.27, blue: 0.56, alpha: 1.00).cgColor
        label.layer.borderWidth = 1
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        return label
    }()
    
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        settingModal()
    }
    
    
    //MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = .white
        imageStackView.addArrangedSubviews(firstImageView, secondImageView, thirdImageView, fourthImageView)
        textView.addSubview(textLabel)
        view.addSubviews(titleLabel, star, rateLabel, bookMarkButton, addressLabel, imageStackView, textView)
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(48)
            $0.left.equalToSuperview().offset(24)
            $0.width.equalTo(view.frame.width/2)
        }
        
        titleLabel.text = "신대방역 근처 원룸"
        
        bookMarkButton.snp.makeConstraints {
            $0.centerY.equalTo(titleLabel.snp.centerY)
            $0.right.equalToSuperview().offset(-24)
            $0.width.height.equalTo(30)
        }
        rateLabel.snp.makeConstraints {
            $0.centerY.equalTo(titleLabel.snp.centerY)
            $0.right.equalTo(bookMarkButton.snp.left).offset(-10)
            $0.width.equalTo(30)
        }
        rateLabel.text = "5.0"
        
        star.snp.makeConstraints {
            $0.centerY.equalTo(titleLabel.snp.centerY)
            $0.right.equalTo(rateLabel.snp.left).offset(-5)
            $0.width.height.equalTo(30)
        }
        
    }
    
//    func configureUI() {
//        view.backgroundColor = .white
//        view.addSubview(신대방)
//        view.addSubview(천육십)
//        view.addSubview(월세)
//        view.addSubview(원룸)
//
//        NSLayoutConstraint.activate([
//            신대방.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 30),
//            신대방.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10),
//            신대방.heightAnchor.constraint(equalToConstant: 30),
//            신대방.widthAnchor.constraint(equalToConstant: 200),
//
//            천육십.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 30),
//            천육십.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10),
//            천육십.heightAnchor.constraint(equalToConstant: 30),
//            천육십.widthAnchor.constraint(equalToConstant: 100),
//
//            월세.topAnchor.constraint(equalTo: 천육십.bottomAnchor, constant: 10),
//            월세.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10),
//            월세.heightAnchor.constraint(equalToConstant: 30),
//            월세.widthAnchor.constraint(equalToConstant: 50),
//
//            원룸.topAnchor.constraint(equalTo: 천육십.bottomAnchor, constant: 10),
//            원룸.trailingAnchor.constraint(equalTo: 월세.leadingAnchor, constant: -10),
//            원룸.heightAnchor.constraint(equalToConstant: 30),
//            원룸.widthAnchor.constraint(equalToConstant: 50),
//
//
//        ])
//
//
//    }
    
    func settingModal() {
        if let sheetPresentationController = sheetPresentationController {
            sheetPresentationController.detents = [.medium()]
            sheetPresentationController.prefersGrabberVisible = true
            sheetPresentationController.preferredCornerRadius = 25
        }
        
        
    }
    
    //MARK: - Actions


    

}
