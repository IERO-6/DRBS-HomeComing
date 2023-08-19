import UIKit
import Then
import SnapKit
import MapKit

class MyHouseVC: UIViewController {
    //MARK: - Properties
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private lazy var mainImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.image = UIImage(named: "roomImage.png")}
    private lazy var nameLabel = UILabel().then {
        $0.font = UIFont(name: "Pretendard", size: 18)
        $0.text = "개포 3동 2층 원룸"
        $0.textColor = .black
        $0.textAlignment = .left}
    private lazy var livingMethodLabel = UILabel().then {
        $0.font = UIFont(name: "Pretendard", size: 16)
        $0.text = "원룸"
        $0.textColor = Constant.appColor
        $0.textAlignment = .center
        $0.layer.cornerRadius = 3
        $0.clipsToBounds = true
        $0.layer.borderColor = Constant.appColor.cgColor
        $0.layer.borderWidth = 1}
    private lazy var starImage = UIImageView().then {$0.image = UIImage(named: "star.png")}
    private lazy var rateLabel = UILabel().then {
        $0.font = UIFont(name: "Pretendard", size: 16)
        $0.textColor = .darkGray
        $0.text = "4.0"
        $0.textAlignment = .center}
    private lazy var firstContainView = UIView()
    private lazy var addressLabel = UILabel().then {
        $0.font = UIFont(name: "Pretendard", size: 16)
        $0.textColor = .black
        $0.text = "서울특별시 강남구 개포동 153"
        $0.textAlignment = .left}
    private lazy var tradeMethodLabel = UILabel().then {
        $0.font = UIFont(name: "Pretendard", size: 16)
        $0.text = "월세"
        $0.textColor = Constant.appColor
        $0.textAlignment = .center
        $0.layer.cornerRadius = 3
        $0.clipsToBounds = true
        $0.layer.borderColor = Constant.appColor.cgColor
        $0.layer.borderWidth = 1}
    private lazy var costLabel = UILabel().then {
        $0.font = UIFont(name: "Pretendard-Bold", size: 22)
        $0.text = "1000/60"
        $0.textColor = .black
        $0.textAlignment = .left}
    private lazy var secondContainView = UIView()
    private lazy var mainView = UIView()
    private lazy var maintenanceLabel = UILabel().then {
        $0.font = UIFont(name: "Pretendard", size: 14)
        $0.textColor = .black
        $0.text = "관리비 7만원"
        $0.textAlignment = .left}
    // 아직 관리비 미포함 목록 안함
    private lazy var mapLabel = UILabel().then {
        $0.font = UIFont(name: "Pretendard-Bold", size: 16)
        $0.textColor = .black
        $0.text = "지도"}
    private lazy var mapView = MKMapView()
    private lazy var mapStackView = UIView()
    private lazy var memoLabel = UILabel().then {
        $0.font = UIFont(name: "Pretendard-Bold", size: 16)
        $0.textColor = .black
        $0.text = "메모"}
    private lazy var memoTextView = UITextView().then {
        $0.layer.borderColor = UIColor.lightGray.cgColor
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 3}
    private lazy var textCountLabel = UILabel().then {
        $0.font = UIFont(name: "Pretendard-Regular", size: 14)
        $0.textColor = .lightGray
        $0.text = "(242/500)"}
    private lazy var memoView = UIView()
    private lazy var button = UIButton().then {
        $0.backgroundColor = Constant.appColor
        $0.setTitle("확인", for: .normal)
        $0.layer.cornerRadius = 5
        $0.clipsToBounds = true}
    private lazy var checkView = UIView().then {
        $0.layer.cornerRadius = 8
        $0.clipsToBounds = true
        $0.layer.borderColor = UIColor.lightGray.cgColor
        $0.layer.borderWidth = 1}
    private lazy var checkLabel = UILabel().then {
        $0.font = UIFont(name: "Pretendard-Bold", size: 16)
        $0.textColor = .black
        $0.text = "체크 리스트"}
    private lazy var 방향label = UILabel()
    private lazy var 방음label = UILabel()
    private lazy var 수압label = UILabel()
    private lazy var 벌레label = UILabel()
    private lazy var 통풍label = UILabel()
    private lazy var 보안label = UILabel()
    private lazy var 곰팡이label = UILabel()
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        settingNav()
    }
    
    override func viewDidLayoutSubviews() {
        mainView.layer.addBottomLayer()
        mapStackView.layer.addBottomLayer()
        memoView.layer.addBottomLayer()
    }
    
    //MARK: - Helpers
    private func configureUI() {
        view.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        mainView.addSubviews(firstContainView,
                                      addressLabel,
                                      secondContainView,
                                      maintenanceLabel)
        firstContainView.addSubviews(nameLabel,
                                    livingMethodLabel,
                                    starImage,
                                    rateLabel)
        secondContainView.addSubviews(tradeMethodLabel, costLabel)
        mapStackView.addSubviews(mapLabel, mapView)
        memoView.addSubviews(memoLabel, memoTextView, textCountLabel)
        scrollView.snp.makeConstraints {$0.edges.equalToSuperview()}
        contentView.addSubviews(mainImageView,
                                mainView,
                                mapStackView,
                                memoView,
                                button)

        contentView.snp.makeConstraints {$0.edges.width.equalTo(scrollView)}
        
        mainImageView.snp.makeConstraints {
            $0.top.trailing.leading.equalTo(contentView)
            $0.height.equalTo(250)
        }

        mainView.snp.makeConstraints {
            $0.top.equalTo(mainImageView.snp.bottom).offset(30)
            $0.leading.equalTo(contentView).offset(10)
            $0.trailing.equalTo(contentView).offset(-10)
            $0.height.equalTo(180)
        }
        
        firstContainView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(30)
        }
        nameLabel.snp.makeConstraints {
            $0.bottom.top.leading.equalToSuperview()
        }
        rateLabel.snp.makeConstraints {
            $0.trailing.bottom.top.equalToSuperview()
            $0.width.equalTo(30)
        }
        starImage.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.trailing.equalTo(rateLabel.snp.leading).offset(-5)
            $0.width.equalTo(30)
        }
        livingMethodLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.trailing.equalTo(starImage.snp.leading).offset(-5)
            $0.width.equalTo(35)
        }
        addressLabel.snp.makeConstraints {
            $0.top.equalTo(firstContainView.snp.bottom).offset(5)
            $0.leading.equalToSuperview()
            $0.height.equalTo(30)
        }
        secondContainView.snp.makeConstraints {
            $0.top.equalTo(addressLabel.snp.bottom).offset(5)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(30)
        }
        tradeMethodLabel.snp.makeConstraints {
            $0.top.leading.bottom.equalToSuperview()
            $0.width.equalTo(35)
        }
        costLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.equalTo(tradeMethodLabel.snp.trailing).offset(10)
        }
        maintenanceLabel.snp.makeConstraints {
            $0.top.equalTo(secondContainView.snp.bottom).offset(5)
            $0.leading.equalToSuperview()
            $0.height.equalTo(30)
            $0.bottom.equalToSuperview().offset(-30)
        }
        
        mapStackView.snp.makeConstraints {
            $0.top.equalTo(mainView.snp.bottom).offset(30)
            $0.leading.trailing.equalTo(mainView)
            $0.height.equalTo(210)
        }
        
        mapLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().offset(5)
        }
        mapView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(3)
            $0.trailing.equalToSuperview().offset(-3)
            $0.top.equalTo(mapLabel.snp.bottom).offset(5)
            $0.bottom.equalTo(mapStackView.snp.bottom).offset(-20)
        }
        
        memoView.snp.makeConstraints {
            $0.top.equalTo(mapStackView.snp.bottom).offset(30)
            $0.leading.trailing.equalTo(mainView)
            $0.height.equalTo(234)
        }
        
        memoLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().offset(5)
        }
        
        textCountLabel.snp.makeConstraints {
            $0.bottom.equalTo(memoView.snp.bottom).offset(-20)
            $0.trailing.equalToSuperview().offset(-3)
            $0.height.equalTo(24)
        }
        
        memoTextView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(3)
            $0.trailing.equalToSuperview().offset(-3)
            $0.top.equalTo(memoLabel.snp.bottom).offset(5)
            $0.bottom.equalTo(textCountLabel.snp.top).offset(-5)
        }
        
        
        
        button.snp.makeConstraints {
            $0.top.equalTo(memoView.snp.bottom).offset(200)   //바꿔야함
            $0.leading.equalToSuperview().offset(15)
            $0.trailing.equalToSuperview().inset(15)
            $0.height.equalTo(50)
        }
        
        contentView.snp.makeConstraints {
            $0.bottom.equalTo(button.snp.bottom).offset(20)
            $0.height.greaterThanOrEqualTo(scrollView)
            $0.width.equalToSuperview()

        }
        
        
        
    }
        
        private func settingNav() {
            self.navigationController?.navigationBar.shadowImage = UIImage()
            self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
            self.navigationController?.navigationBar.shadowImage = UIImage()
            self.navigationController?.navigationBar.isTranslucent = true
            self.navigationController?.navigationBar.topItem?.title = ""
            self.navigationController?.navigationBar.tintColor = .white
        }
    
    //MARK: - Actions



}
