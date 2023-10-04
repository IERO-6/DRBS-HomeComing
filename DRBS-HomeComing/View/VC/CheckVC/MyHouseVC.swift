import UIKit
import KakaoSDKAuth
import Then
import SnapKit
import MapKit
import FirebaseFirestore
import FirebaseStorage
import FirebaseAuth

final class MyHouseVC: UIViewController {
    
    //MARK: - Properties
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private lazy var mainImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.isUserInteractionEnabled = true
    }
    
    private lazy var imageBackButton = UIButton(type: .custom).then {
        $0.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        $0.layer.cornerRadius = 10
        $0.addTarget(self, action: #selector(ImageButtonTapped), for: .touchUpInside)
    }
    
    private lazy var photoImage = UIImageView().then {
        $0.image = UIImage(systemName: "photo.on.rectangle")
        $0.tintColor = .white
    }
    
    private lazy var imageCount = UILabel().then {
        $0.textColor = .white
        $0.font = UIFont(name: "Pretendard-Bold", size: 12)
        $0.textAlignment = .center
    }
    
    private lazy var nameLabel = UILabel().then {
        $0.font = UIFont(name: "Pretendard", size: 18)
        $0.textColor = .black
        $0.textAlignment = .left
    }
    private lazy var livingTypeLabel = UILabel().then {
        $0.font = UIFont(name: "Pretendard", size: 16)
        $0.textColor = Constant.appColor
        $0.textAlignment = .center
        $0.layer.cornerRadius = 5
        $0.clipsToBounds = true
        $0.layer.borderColor = Constant.appColor.cgColor
        $0.layer.borderWidth = 1
    }
    
    private lazy var starImage = UIImageView().then {
        $0.image = UIImage(named: "star_fill.png")
        $0.contentMode = .scaleAspectFill
    }
    
    private lazy var rateLabel = UILabel().then {
        $0.font = UIFont(name: "Pretendard", size: 16)
        $0.textColor = .darkGray
        $0.textAlignment = .center
    }
    
    private lazy var firstContainView = UIView()
    
    private lazy var addressLabel = UILabel().then {
        $0.font = UIFont(name: "Pretendard", size: 16)
        $0.textColor = .black
        $0.textAlignment = .left
    }
    
    private lazy var tradingTypeLabel = UILabel().then {
        $0.font = UIFont(name: "Pretendard", size: 16)
        $0.textColor = Constant.appColor
        $0.textAlignment = .center
        $0.layer.cornerRadius = 5
        $0.clipsToBounds = true
        $0.layer.borderColor = Constant.appColor.cgColor
        $0.layer.borderWidth = 1
        $0.sizeToFit()
    }
    
    private lazy var priceLabel = UILabel().then {
        $0.font = UIFont(name: "Pretendard-Bold", size: 22)
        $0.textColor = .black
        $0.textAlignment = .left
    }
    
    private lazy var secondContainView = UIView()
    
    private lazy var mainView = UIView()
    
    private lazy var maintenanceLabel = UILabel().then {
        $0.font = UIFont(name: "Pretendard", size: 14)
        $0.textColor = .black
        $0.textAlignment = .left
        $0.text = "관리비"
    }
    
    private lazy var maintenanceCostLabel = UILabel().then {
        $0.font = UIFont(name: "Pretendard-Bold", size: 16)
        $0.textColor = .black
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
    
    private lazy var mapView = MKMapView().then {
        $0.isUserInteractionEnabled = false
    }
    
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
        $0.isUserInteractionEnabled = false
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
    
    lazy var checkListView = CheckListUIView()
    
    var houseViewModel: HouseViewModel?
    
    var selectedHouse: House? {
        didSet { self.configureUIWithData() }
    }
    var sendHouseImages: [String] = []
    var from: String = ""
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        settingNav()
        scrollView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateUIForImages()
        updateBookmarkButtonState()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        mainView.layer.addBottomLayer()
        mapStackView.layer.addBottomLayer()
        memoView.layer.addBottomLayer()
        detailView.layer.addBottomLayer()
    }
    
    //MARK: - Helpers
    private func configureUI() {
        // 뷰에는 스크롤뷰
        // 스크롤뷰에는 메인 이미지뷰, 메인뷰(이름주소별점관리비등등),지도뷰(지도 이름, 지도),
        // 메모뷰(메모 이름, 메모, 메모글자수), 디테일뷰(면적, 입주가능일, 계약기간), 체크리스트
        view.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        mainImageView.addSubview(imageBackButton)
        imageBackButton.addSubviews(photoImage, imageCount)
        mainView.addSubviews(firstContainView,
                             addressLabel,
                             secondContainView)
        firstContainView.addSubviews(nameLabel,
                                     livingTypeLabel,
                                     starImage,
                                     rateLabel)
        secondContainView.addSubviews(tradingTypeLabel, priceLabel)
        mapStackView.addSubviews(mapLabel, mapView)
        memoView.addSubviews(memoLabel, memoTextView, textCountLabel)
        detailView.addSubviews(면적ImageView,
                               면적ValueLabel,
                               입주가능일ImageView,
                               입주가능일ValueLabel,
                               계약기간ImageView,
                               계약기간ValueLabel)
        checkView.addSubviews(checkLabel, checkListView)
        scrollView.snp.makeConstraints {$0.edges.equalToSuperview()}
        contentView.addSubviews(mainImageView,
                                mainView,
                                mapStackView,
                                memoView,
                                detailView,
                                checkView)

        contentView.snp.makeConstraints {$0.edges.width.equalTo(scrollView)}

        mainImageView.snp.makeConstraints {
            $0.top.trailing.leading.equalTo(contentView)
            $0.height.equalTo(250)
        }

        imageBackButton.snp.makeConstraints {
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
        rateLabel.snp.makeConstraints {
            $0.trailing.bottom.top.equalToSuperview()
            $0.width.equalTo(30)
        }
        starImage.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalTo(rateLabel.snp.leading).offset(-5)
            $0.width.height.equalTo(15)
        }
        livingTypeLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.trailing.equalTo(starImage.snp.leading).offset(-5)
        }
        nameLabel.snp.makeConstraints {
            $0.bottom.top.leading.equalToSuperview()
            $0.trailing.equalTo(livingTypeLabel.snp.leading).offset(-10)
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
        tradingTypeLabel.snp.makeConstraints {
            $0.top.leading.bottom.equalToSuperview()
            $0.width.equalTo(35)
        }
        priceLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.equalTo(tradingTypeLabel.snp.trailing).offset(10)
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
            $0.leading.equalTo(detailView).offset(15)
            $0.width.height.equalTo(24)
        }
        계약기간ValueLabel.snp.makeConstraints {
            $0.centerY.equalTo(계약기간ImageView)
            $0.leading.equalTo(계약기간ImageView.snp.trailing).offset(15)
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
        checkListView.snp.makeConstraints {
            $0.top.equalTo(checkLabel.snp.bottom).offset(10)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        contentView.snp.makeConstraints {
            $0.bottom.equalTo(checkListView.snp.bottom).offset(20)
            $0.height.greaterThanOrEqualTo(scrollView)
            $0.width.equalToSuperview()
        }
    }
    
    private func settingNav() {
        let appearance = UINavigationBarAppearance().then {
            $0.configureWithTransparentBackground()
            $0.backgroundColor = .clear
            $0.titleTextAttributes = [.foregroundColor: UIColor.black]
            $0.shadowColor = nil
        }
        
        navigationController?.navigationBar.topItem?.title = ""
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        let ellipsis = self.navigationItem.makeSFSymbolButtonWithMenu(self, action: #selector(ellipsisButtonTapped), symbolName: "ellipsis.circle")
        let bookmark = self.navigationItem.makeSFSymbolButton(self, action: #selector(bookmarkButtonTapped), symbolName: "bookmark")
        let barButtonItem = UIBarButtonItem(customView: ellipsis)
        barButtonItem.customView?.translatesAutoresizingMaskIntoConstraints = false
        barButtonItem.customView?.heightAnchor.constraint(equalToConstant: 24).isActive = true
        barButtonItem.customView?.widthAnchor.constraint(equalToConstant: 24).isActive = true
        navigationItem.rightBarButtonItems = [barButtonItem,  bookmark]
    }
    
    
    //MARK: - UI
    func configureUIWithData() {
        guard let house = self.selectedHouse else { return }
        //하우스 모델을 받아옴
        self.checkListView.isUserInteractionEnabled = false
        DispatchQueue.main.async {
            //거주형태, 거래방식에 대한 값 조정
            switch house.livingType ?? "" {
            case "아파트/오피스텔":
                self.livingTypeLabel.snp.makeConstraints{$0.width.equalTo(110)}
            case "빌라/주택":
                self.livingTypeLabel.snp.makeConstraints{$0.width.equalTo(80)}
            case "원룸/투룸+":
                self.livingTypeLabel.snp.makeConstraints{$0.width.equalTo(90)}
            default:
                self.livingTypeLabel.snp.makeConstraints{$0.width.equalTo(90)}
            }
        }
        
        self.checkListView.checkViewModel.checkListModel = house.체크리스트 ?? CheckList()
        guard let houseImages = house.사진 else { return }
        sendHouseImages = houseImages
        var selectedImages: [UIImage] = []
        let imageMapping: [String: String] = [
            "가스": "gassImage.png",
            "전기": "lightImage.png",
            "수도": "waterImage.png",
            "TV": "tvImage.png",
            "인터넷": "internetImage.png",
            "기타": "etc.png"
        ]
        for (key, imageName) in imageMapping {
            if let 관리비미포함목록 = house.관리비미포함목록, 관리비미포함목록.contains(key) {
                if let image = UIImage(named: imageName) {
                    selectedImages.append(image)
                }
            }
        }
        // 빈 이미지를 추가하여 총 5개의 이미지가 되도록 한다
        while selectedImages.count < 6 {
            if let placeholder = UIImage(named: "emptyImage.png") {
                selectedImages.append(placeholder)
            }
        }

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
        if !houseImages.isEmpty {
            self.mainImageView.sd_setImage(with: URL(string: houseImages[0]))
        } else {
            self.mainImageView.image = .none
            let emptyImageView = UIImageView().then {
                $0.image = UIImage(named: "default-empty-Image")
                $0.tintColor = .darkGray
                $0.contentMode = .scaleAspectFit
            }
            self.mainImageView.addSubview(emptyImageView)
            emptyImageView.snp.makeConstraints {
                $0.centerX.centerY.equalToSuperview()
                $0.width.height.equalTo(50)
            }
        }
        self.imageCount.text = houseImages.isEmpty ? "0" : String(houseImages.count)
        self.nameLabel.text = house.title ?? ""

        self.rateLabel.text = String(house.별점 ?? 0.0)

        self.priceLabel.text = house.보증금! + "/" + house.월세!

        self.maintenanceCostLabel.text = (house.관리비 ?? "") + "만원"

        self.addressLabel.text = house.address ?? ""

        self.livingTypeLabel.text = (house.livingType ?? "") + " "

        self.tradingTypeLabel.text = house.tradingType ?? ""

        self.mapView.setRegion(MKCoordinateRegion(center: house.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)), animated: false)
        self.mapView.addAnnotation(house)
        //span의 델타값이 작을수록 확대레벨 올라감

        self.memoTextView.text = house.기록 ?? ""

        self.textCountLabel.text = "(\((house.기록 ?? "").count)/500)"

        if (house.면적 ?? "0") == "0" {
            self.면적ValueLabel.text = "정보가 없습니다"
        }
        if (house.입주가능일 ?? "").isEmpty {
            self.입주가능일ValueLabel.text = "정보가 없습니다"
        }
        if (house.계약기간 ?? "").isEmpty {
            self.계약기간ValueLabel.text = "정보가 없습니다"
        }
        self.면적ValueLabel.text = "\(house.면적 ?? "0") ㎡"

        self.입주가능일ValueLabel.text = "(입주가능일)" + (house.입주가능일 ?? " ")

        self.계약기간ValueLabel.text = (house.계약기간 ?? "") + "년"

    }
    
    private func updateBookmarkButtonState() {
        guard let house = selectedHouse else { return }
        let imageName = house.isBookMarked! ? "bookmark.fill" : "bookmark"
        guard let rightBarButtonItems = self.navigationItem.rightBarButtonItems,
              rightBarButtonItems.count > 1,
              let bookmarkButton = rightBarButtonItems[1].customView as? UIButton else { return }
        
        bookmarkButton.setImage(UIImage(named: imageName), for: .normal)
    }
    
    
    //MARK: - Actions
    @objc func bookmarkButtonTapped(sender: UIButton) {
        guard let house = selectedHouse else { return }
        house.isBookMarked = !(house.isBookMarked ?? false)
        let imageName = house.isBookMarked! ? "bookmark.fill" : "bookmark"
        sender.setImage(UIImage(named: imageName), for: .normal)
        
        guard let houseId = house.houseId else { return }
        let houseRef = Firestore.firestore().collection("Homes").document(houseId)
        houseRef.updateData(["isBookMarked": house.isBookMarked!]) { error in
            if let error = error {
                print("Failed to update bookmark : \(error.localizedDescription)")
                return
            }
        }
    }
    
    @objc func ellipsisButtonTapped(_ sender: UIButton) {
        let edit = UIAction(title: "편집", image: UIImage(systemName: "square.and.pencil"), handler: { _ in
            let checkVC1 = CheckVC1()
            checkVC1.houseViewModel.house = self.selectedHouse
            self.navigationController?.pushViewController(checkVC1, animated: true)
        })
        
        let delete = UIAction(title: "삭제", image: UIImage(systemName: "trash.fill"), handler: { _ in
            if let selectedHouse = self.selectedHouse, let houseId = selectedHouse.houseId {
                print("Deleting house ID: \(houseId)")
                NetworkingManager.shared.deleteHouse(houseId: houseId) { success in
                    if success {
                        NotificationCenter.default.post(name: Notification.Name("houseDeleted"), object: nil, userInfo: ["deletedHouseId": houseId])
                        self.navigationController?.popViewController(animated: true)
                    } else {
                        print("집을 지우지 못했습니다.")
                    }
                }
            } else {
                print("houseId is not founded")
            }
        })
        
        let menu = UIMenu(title: "메뉴를 선택해주세요",
                          image: nil,
                          identifier: nil,
                          options: .displayInline,
                          children: [edit, delete])
        
        sender.menu = menu
        sender.showsMenuAsPrimaryAction = true
    }

    @objc func ImageButtonTapped() {
        let myHouseImageVC = MyHouseImageVC()
        myHouseImageVC.houseImages = sendHouseImages
        myHouseImageVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(myHouseImageVC, animated: true)
    }
}

//MARK: - Extension
extension MyHouseVC {
    func updateUIForImages() {
        guard let house = selectedHouse else { return }
        if (selectedHouse?.관리비?.isEmpty ?? true == false) && (selectedHouse?.관리비미포함목록?.isEmpty ?? true == false) {
            mainView.addSubviews(maintenanceLabel, maintenanceCostLabel, noneMaintenanceLabel, noneMaintenanceImagesStackView)
            maintenanceLabel.snp.makeConstraints {
                $0.top.equalTo(secondContainView.snp.bottom).offset(5)
                $0.leading.equalToSuperview()
                $0.height.equalTo(30)
                $0.width.equalTo(38)
                $0.bottom.equalTo(mainView.snp.bottom).offset(-60)
            }
            maintenanceCostLabel.snp.makeConstraints {
                $0.top.equalTo(secondContainView.snp.bottom).offset(5)
                $0.leading.equalTo(maintenanceLabel.snp.trailing).offset(10)
                $0.height.equalTo(30)
                $0.trailing.equalToSuperview()
            }
            noneMaintenanceLabel.snp.makeConstraints {
                $0.top.equalTo(maintenanceLabel.snp.bottom).offset(5)
                $0.leading.equalToSuperview()
                $0.width.equalTo(38)
                $0.bottom.equalTo(mainView.snp.bottom).offset(-15)
            }
            noneMaintenanceImagesStackView.snp.makeConstraints {
                $0.centerY.equalTo(noneMaintenanceLabel.snp.centerY)
                $0.leading.equalTo(noneMaintenanceLabel.snp.trailing).offset(10)
                $0.height.equalTo(36)
                $0.width.equalTo(27*6 + 5*5)
            }
        } else if (selectedHouse?.관리비?.isEmpty ?? true == false) && (selectedHouse?.관리비미포함목록?.isEmpty ?? true) { //관리비는 있고 미포함은 없는
            mainView.addSubviews(maintenanceLabel, maintenanceCostLabel)
            maintenanceLabel.snp.makeConstraints {
                $0.top.equalTo(secondContainView.snp.bottom).offset(5)
                $0.leading.equalToSuperview()
                $0.width.equalTo(38)
                $0.height.equalTo(30)
                $0.bottom.equalTo(mainView.snp.bottom).offset(-15)
            }
            maintenanceCostLabel.snp.makeConstraints {
                $0.top.equalTo(secondContainView.snp.bottom).offset(5)
                $0.leading.equalTo(maintenanceLabel.snp.trailing).offset(10)
                $0.height.equalTo(30)
                $0.trailing.equalToSuperview()
            }
        } else if (selectedHouse?.관리비?.isEmpty ?? true) && (selectedHouse?.관리비미포함목록?.isEmpty ?? true == false) { //관리비는 없고 미포함은 있는
            mainView.addSubviews(noneMaintenanceLabel, noneMaintenanceImagesStackView)
            noneMaintenanceLabel.snp.makeConstraints {
                $0.top.equalTo(secondContainView.snp.bottom).offset(5)
                $0.leading.equalToSuperview()
                $0.width.equalTo(38)
                $0.bottom.equalTo(mainView.snp.bottom).offset(-15)
            }
            noneMaintenanceImagesStackView.snp.makeConstraints {
                $0.centerY.equalTo(noneMaintenanceLabel.snp.centerY)
                $0.leading.equalTo(noneMaintenanceLabel.snp.trailing).offset(10)
                $0.height.equalTo(36)
                $0.width.equalTo(27*5 + 5*4)
            }
        } else if selectedHouse?.관리비?.isEmpty ?? true && selectedHouse?.관리비미포함목록?.isEmpty ?? true {
            print("all empty")
            mainView.snp.makeConstraints {
                $0.bottom.equalTo(priceLabel.snp.bottom).offset(20)
            }
        }
    }
}

// MARK: - UIScrollViewDelegate

extension MyHouseVC: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.y
        
        if offset <= 0 {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithTransparentBackground()
            appearance.backgroundColor = .clear
            navigationController?.navigationBar.standardAppearance = appearance
            navigationController?.navigationBar.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance
        } else {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithDefaultBackground()
            appearance.backgroundColor = .white
            navigationController?.navigationBar.standardAppearance = appearance
            navigationController?.navigationBar.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance
        }
    }
}
