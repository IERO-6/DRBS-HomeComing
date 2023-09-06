import UIKit
import KakaoSDKAuth
import Then
import SnapKit
import MapKit

final class MyHouseVC: UIViewController {
    //MARK: - Properties
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private lazy var mainImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.image = UIImage(named: "roomImage.png")
    }
    
    private lazy var imageBackView = UIView().then {
        $0.backgroundColor = .black.withAlphaComponent(0.8)
        $0.layer.cornerRadius = 10
    }
    
    private lazy var photoImage = UIImageView().then {
        $0.image = UIImage(systemName: "photo.on.rectangle")
        $0.tintColor = .white
    }
    
    private lazy var imageCount = UILabel().then {
        $0.textColor = .white
        $0.font = UIFont(name: "Pretendard-Bold", size: 12)
        $0.text = "+2"
    }
    
    private lazy var nameLabel = UILabel().then {
        $0.font = UIFont(name: "Pretendard", size: 18)
        $0.text = "개포 3동 2층 원룸"
        $0.textColor = .black
        $0.textAlignment = .left
    }
    private lazy var livingMethodLabel = UILabel().then {
        $0.font = UIFont(name: "Pretendard", size: 16)
        $0.text = "원룸"
        $0.textColor = Constant.appColor
        $0.textAlignment = .center
        $0.layer.cornerRadius = 3
        $0.clipsToBounds = true
        $0.layer.borderColor = Constant.appColor.cgColor
        $0.layer.borderWidth = 1}
    private lazy var starImage = UIImageView().then {
        $0.image = UIImage(named: "star.png")
    }
    private lazy var rateLabel = UILabel().then {
        $0.font = UIFont(name: "Pretendard", size: 16)
        $0.textColor = .darkGray
        $0.text = "4.0"
        $0.textAlignment = .center
    }
    private lazy var firstContainView = UIView()
    private lazy var addressLabel = UILabel().then {
        $0.font = UIFont(name: "Pretendard", size: 16)
        $0.textColor = .black
        $0.text = "서울특별시 강남구 개포동 153"
        $0.textAlignment = .left
    }
    private lazy var tradeMethodLabel = UILabel().then {
        $0.font = UIFont(name: "Pretendard", size: 16)
        $0.text = "월세"
        $0.textColor = Constant.appColor
        $0.textAlignment = .center
        $0.layer.cornerRadius = 3
        $0.clipsToBounds = true
        $0.layer.borderColor = Constant.appColor.cgColor
        $0.layer.borderWidth = 1
    }
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
        $0.textAlignment = .left
    }
    private lazy var noneMaintenanceLabel = UILabel().then {
        $0.font = UIFont(name: "Pretendard", size: 14)
        $0.textColor = .black
        $0.text = "관리비\n미포함"
        $0.numberOfLines = 2
        $0.textAlignment = .left
    }
    private lazy var noneMaintenanceImagesStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 10
        $0.distribution = .equalSpacing
        $0.layer.borderColor = UIColor.black.cgColor
    }
    private lazy var mapLabel = UILabel().then {
        $0.font = UIFont(name: "Pretendard-Bold", size: 16)
        $0.textColor = .black
        $0.text = "지도"
    }
    private lazy var mapView = MKMapView()
    private lazy var mapStackView = UIView()
    private lazy var memoLabel = UILabel().then {
        $0.font = UIFont(name: "Pretendard-Bold", size: 16)
        $0.textColor = .black
        $0.text = "메모"
    }
    private lazy var memoTextView = UITextView().then {
        $0.layer.borderColor = UIColor.lightGray.cgColor
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 3
    }
    private lazy var detailView = UIView()
    private lazy var 면적ImageView = UIImageView().then {$0.image = UIImage(named: "areaImage.png")}
    private lazy var 입주가능일ImageView = UIImageView().then {$0.image = UIImage(named: "calendarImage.png")}
    private lazy var 계약기간ImageView = UIImageView().then {$0.image = UIImage(named: "homeImage.png")}
    private lazy var 면적ValueLabel = UILabel().then {
        $0.font = UIFont(name: "Pretendard-Bold", size: 16)
        $0.textColor = .black
    }
    private lazy var 입주가능일ValueLabel = UILabel().then {
        $0.font = UIFont(name: "Pretendard-Bold", size: 16)
        $0.textColor = .black
    }
    private lazy var 계약기간ValueLabel = UILabel().then {
        $0.font = UIFont(name: "Pretendard-Bold", size: 16)
        $0.textColor = .black
    }
    private lazy var textCountLabel = UILabel().then {
        $0.font = UIFont(name: "Pretendard-Regular", size: 14)
        $0.textColor = .lightGray
        $0.text = "(242/500)"
    }
    private lazy var memoView = UIView()
    private lazy var button = UIButton().then {
        $0.backgroundColor = Constant.appColor
        $0.setTitle("확인", for: .normal)
        $0.layer.cornerRadius = 5
        $0.clipsToBounds = true
    }
    private lazy var checkView = UIView()
    private lazy var checkLabel = UILabel().then {
        $0.font = UIFont(name: "Pretendard-Bold", size: 16)
        $0.textColor = .black
        $0.text = "체크 리스트"
    }
    private lazy var CheckListView = CheckListUIView()
    
    var selectedHouse: House? {
        didSet {
            configureUIWithData()
        }
    }
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        settingNav()
        fetchSelectedHouseData()
    }
    
    override func viewDidLayoutSubviews() {
        mainView.layer.addBottomLayer()
        mapStackView.layer.addBottomLayer()
        memoView.layer.addBottomLayer()
        detailView.layer.addBottomLayer()
    }
    
    //MARK: - Helpers
    private func configureUI() {
        view.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        mainImageView.addSubview(imageBackView)
        imageBackView.addSubviews(photoImage, imageCount)
        mainView.addSubviews(firstContainView,
                             addressLabel,
                             secondContainView,
                             maintenanceLabel,
                             noneMaintenanceLabel,
                             noneMaintenanceImagesStackView)
        firstContainView.addSubviews(nameLabel,
                                     livingMethodLabel,
                                     starImage,
                                     rateLabel)
        secondContainView.addSubviews(tradeMethodLabel, costLabel)
        mapStackView.addSubviews(mapLabel, mapView)
        memoView.addSubviews(memoLabel, memoTextView, textCountLabel)
        detailView.addSubviews(면적ImageView,
                               면적ValueLabel,
                               입주가능일ImageView,
                               입주가능일ValueLabel,
                               계약기간ImageView,
                               계약기간ValueLabel)
        checkView.addSubviews(checkLabel, CheckListView)
        scrollView.snp.makeConstraints {$0.edges.equalToSuperview()}
        contentView.addSubviews(mainImageView,
                                mainView,
                                mapStackView,
                                memoView,
                                detailView,
                                checkView,
                                button)
        
        contentView.snp.makeConstraints {$0.edges.width.equalTo(scrollView)}
        
        mainImageView.snp.makeConstraints {
            $0.top.trailing.leading.equalTo(contentView)
            $0.height.equalTo(250)
        }
        
        imageBackView.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-10)
            $0.bottom.equalToSuperview().offset(-10)
            $0.width.equalTo(70)
            $0.height.equalTo(30)
        }
        
        photoImage.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(10)
            $0.width.height.equalTo(20)
        }
        
        imageCount.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-10)
            $0.width.height.equalTo(20)
        }
        
        mainView.snp.makeConstraints {
            $0.top.equalTo(mainImageView.snp.bottom).offset(30)
            $0.leading.equalTo(contentView).offset(10)
            $0.trailing.equalTo(contentView).offset(-10)
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
            $0.bottom.equalToSuperview().offset(-60)
        }
        
        noneMaintenanceLabel.snp.makeConstraints {
            $0.top.equalTo(maintenanceLabel.snp.bottom).offset(5)
            $0.leading.equalToSuperview()
            $0.height.equalTo(60)
        }
        
        noneMaintenanceImagesStackView.snp.makeConstraints {
            $0.top.equalTo(noneMaintenanceLabel).offset(13)
            $0.leading.equalTo(noneMaintenanceLabel.snp.trailing).offset(10)
            $0.height.equalTo(36)
            $0.width.equalTo(27*5 + 5*4)
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
        
        detailView.snp.makeConstraints {
            $0.top.equalTo(memoView.snp.bottom).offset(30)
            $0.leading.trailing.equalTo(mainView)
            $0.height.equalTo(180)
        }
        
        면적ImageView.snp.makeConstraints {
            $0.top.equalTo(detailView).offset(15)
            $0.leading.equalTo(detailView).offset(15)
            $0.width.height.equalTo(24)
        }
        
        면적ValueLabel.snp.makeConstraints {
            $0.centerY.equalTo(면적ImageView)
            $0.leading.equalTo(면적ImageView.snp.trailing).offset(15)
        }
        
        입주가능일ImageView.snp.makeConstraints {
            $0.top.equalTo(면적ImageView).offset(53)
            $0.leading.equalTo(detailView).offset(15)
            $0.width.height.equalTo(24)
        }
        
        입주가능일ValueLabel.snp.makeConstraints {
            $0.centerY.equalTo(입주가능일ImageView)
            $0.leading.equalTo(입주가능일ImageView.snp.trailing).offset(15)
        }
        
        계약기간ImageView.snp.makeConstraints {
            $0.top.equalTo(입주가능일ImageView).offset(47)
            $0.leading.equalTo(detailView).offset(12)
            $0.width.height.equalTo(30)
        }
        
        계약기간ValueLabel.snp.makeConstraints {
            $0.centerY.equalTo(계약기간ImageView)
            $0.leading.equalTo(계약기간ImageView.snp.trailing).offset(12)
        }
        
        checkView.snp.makeConstraints {
            $0.top.equalTo(detailView.snp.bottom).offset(30)
            $0.leading.equalToSuperview().offset(12)
            $0.trailing.equalToSuperview().offset(-12)
            $0.height.equalTo(550)
        }
        
        checkLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().offset(5)
        }
        
        CheckListView.snp.makeConstraints {
            $0.top.equalTo(checkLabel.snp.bottom).offset(10)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        button.snp.makeConstraints {
            $0.top.equalTo(checkView.snp.bottom).offset(200)   //바꿔야함
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
        let appearance = UINavigationBarAppearance().then {
            $0.configureWithOpaqueBackground()
            $0.backgroundColor = .white
            $0.titleTextAttributes = [.foregroundColor: UIColor.black]
        }
        navigationController?.navigationBar.topItem?.title = ""
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        let ellipsis = self.navigationItem.makeSFSymbolButtonWithMenu(self, action: #selector(ellipsisButtonTapped), symbolName: "ellipsis.circle")
        let bookmark = self.navigationItem.makeSFSymbolButton(self, action: #selector(bookmarkButtonTapped), symbolName: "bookmark")
        let barButtonItem = UIBarButtonItem(customView: ellipsis)
        barButtonItem.customView?.translatesAutoresizingMaskIntoConstraints = false
        barButtonItem.customView?.heightAnchor.constraint(equalToConstant: 24).isActive = true
        barButtonItem.customView?.widthAnchor.constraint(equalToConstant: 24).isActive = true
        let edit = UIAction(title: "편집", image: UIImage(systemName: "square.and.pencil"), handler: { _ in
            //            let rateVC = RateVC()
        })
        
        let delete = UIAction(title: "삭제", image: UIImage(systemName: "trash.fill"), handler: { _ in
            print("삭제하기")
            
        })
        
        ellipsis.menu = UIMenu(title: "메뉴를 선택해주세요",
                               image: nil,
                               identifier: nil,
                               options: .displayInline,
                               children: [edit, delete])
        navigationItem.rightBarButtonItems = [barButtonItem,  bookmark]
    }
    
    private func configureUIWithData() {
        guard let house = selectedHouse else { return }
        var selectedImages: [UIImage] = []
        let imageMapping: [String: String] = [
            "가스": "gassImage.png",
            "전기": "lightImage.png",
            "수도": "waterImage.png",
            "TV": "tvImage.png",
            "인터넷": "internetImage.png"
        ]
        for (key, imageName) in imageMapping {
            if let 관리비미포함목록 = house.관리비미포함목록, 관리비미포함목록.contains(key) {
                if let image = UIImage(named: imageName) {
                    selectedImages.append(image)
                }
            }
        }
        // 빈 이미지를 추가하여 총 5개의 이미지가 되도록 한다
        while selectedImages.count < 5 {
            if let placeholder = UIImage(named: "emptyImage.png") {
                selectedImages.append(placeholder)
            }
        }
        
        let image = UIImage(systemName: "photo.on.rectangle")
        DispatchQueue.main.async {
            for image in selectedImages {
                let imageView = UIImageView()
                imageView.translatesAutoresizingMaskIntoConstraints = false
                imageView.image = image
                imageView.contentMode = .scaleAspectFit
                
                let desiredWidth: CGFloat = 27.0
                let desiredHeight: CGFloat = 36.0
                imageView.widthAnchor.constraint(equalToConstant: desiredWidth).isActive = true
                imageView.heightAnchor.constraint(equalToConstant: desiredHeight).isActive = true
                self.noneMaintenanceImagesStackView.addArrangedSubview(imageView)
            }
            self.noneMaintenanceImagesStackView.spacing = 5.0
        }
        
        if let 면적 = house.면적 {
            self.면적ValueLabel.text = "\(면적) ㎡"
        }
        
//        if let 입주가능일 = house.입주가능일 {
//            let baseFont = UIFont.systemFont(ofSize: 10)
//            let boldFont = UIFont(name: "Pretendard-Bold", size: 16) ?? baseFont
//            let 입주가능일Text = NSMutableAttributedString(string: "\(입주가능일)", attributes: [NSAttributedString.Key.font: boldFont])
//            let prefix = NSAttributedString(string: " (입주가능일)", attributes: [NSAttributedString.Key.font: baseFont])
//            입주가능일Text.append(prefix)
//            self.입주가능일ValueLabel.attributedText = 입주가능일Text
//        }
//
        self.입주가능일ValueLabel.text = " (입주가능일)" + (house.입주가능일 ?? "")

        
        if let 계약기간 = house.계약기간 {
            let baseFont = UIFont.systemFont(ofSize: 10)
            let boldFont = UIFont(name: "Pretendard-Bold", size: 16) ?? baseFont
            let 계약기간Text = NSMutableAttributedString(string: "\(계약기간)년", attributes: [NSAttributedString.Key.font: boldFont])
            let prefix = NSAttributedString(string: " (계약기간)", attributes: [NSAttributedString.Key.font: baseFont])
            계약기간Text.append(prefix)
            self.계약기간ValueLabel.attributedText = 계약기간Text
        }
    }
    
    private func fetchSelectedHouseData() {
        guard let house = selectedHouse else { return }
        
    }
    
    
    //MARK: - Actions
    
    @objc func bookmarkButtonTapped() {
        print("b")
        
    }
    
    @objc func ellipsisButtonTapped() {
        print("e")
        
    }
    
}
