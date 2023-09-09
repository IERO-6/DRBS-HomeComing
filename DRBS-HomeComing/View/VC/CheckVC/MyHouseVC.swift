import UIKit
import KakaoSDKAuth
import Then
import SnapKit
import MapKit
import FirebaseFirestore

final class MyHouseVC: UIViewController {
    //MARK: - Properties
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private lazy var mainImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
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
//        $0.sizeToFit()
    }
    private lazy var starImage = UIImageView().then {
        $0.image = UIImage(named: "star.png")
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
                             maintenanceCostLabel,
                             noneMaintenanceLabel,
                             noneMaintenanceImagesStackView)
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
        rateLabel.snp.makeConstraints {
            $0.trailing.bottom.top.equalToSuperview()
            $0.width.equalTo(30)
        }
        starImage.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.trailing.equalTo(rateLabel.snp.leading).offset(-5)
            $0.width.equalTo(30)
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
        maintenanceLabel.snp.makeConstraints {
            $0.top.equalTo(secondContainView.snp.bottom).offset(5)
            $0.leading.equalToSuperview()
            $0.height.equalTo(30)
            $0.bottom.equalToSuperview().offset(-60)
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
            $0.bottom.equalToSuperview().offset(-15)
        }
        noneMaintenanceImagesStackView.snp.makeConstraints {
            $0.centerY.equalTo(noneMaintenanceLabel.snp.centerY)
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
            let checkVC1 = CheckVC1()
            checkVC1.house = self.selectedHouse
            self.navigationController?.pushViewController(checkVC1, animated: true)
        })
        
        let delete = UIAction(title: "삭제", image: UIImage(systemName: "trash.fill"), handler: { _ in
            print("삭제하기")
            func deleteButtonTapped() {
                let homeVC = HomeVC()
                if let selectedHouse = self.selectedHouse, let houseId = selectedHouse.houseId {
                    print("Deleting house with ID: \(houseId)")  // houseId를 출력
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
            }
            deleteButtonTapped()
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
        self.checkListView.isUserInteractionEnabled = false
        DispatchQueue.main.async {
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
        
//        let images = houseImages.map{$0.toImage()}
        
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
        // 왜 이미지가 5개여야하는지..?
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
        if !houseImages.isEmpty {
            self.mainImageView.sd_setImage(with: URL(string: houseImages[0]))
        } else {
            self.mainImageView.image = UIImage(named: "emptyImage")
        }
        
        self.imageCount.text = "+" + String(houseImages.count - 1)
        
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
        
        self.면적ValueLabel.text = "\(house.면적 ?? "0") ㎡"
  
        self.입주가능일ValueLabel.text = "(입주가능일)" + (house.입주가능일 ?? "")

        self.계약기간ValueLabel.text = (house.계약기간 ?? "") + "년"

        
    }
    
    private func fetchSelectedHouseData() {
        guard let house = selectedHouse else { return }
        
    }
    
    
    //MARK: - Actions
    
    @objc func bookmarkButtonTapped(sender: UIButton) {
        // 해당 House 객체의 인덱스를 가져옵니다.
        print("bookmark tapped")
        guard let houseViewModel = houseViewModel,
              sender.tag < houseViewModel.houses.count else { return }
        
        let houseIndex = sender.tag
        var selectedHouse = houseViewModel.houses[houseIndex]
        print(selectedHouse)

        // 북마크 상태를 토글합니다.
        selectedHouse.isBookMarked = !(selectedHouse.isBookMarked ?? false)

        // Firestore에 변경 사항을 업데이트합니다.
        if let houseId = selectedHouse.houseId {
            let houseRef = Firestore.firestore().collection("Homes").document(houseId)
            houseRef.updateData(["isBookMarked": selectedHouse.isBookMarked]) { error in
                if let error = error {
                    print("Failed to update bookmark status: \(error.localizedDescription)")
                    return
                }
                // 성공적으로 업데이트되었을 경우, 북마크 버튼의 이미지를 업데이트합니다.
                let imageName = selectedHouse.isBookMarked! ? "bookmark.fill" : "bookmark"
                sender.setImage(UIImage(systemName: imageName), for: .normal)
            }
        }
    }
    
    @objc func ellipsisButtonTapped() {
        print("e")
        
    }
    
}
