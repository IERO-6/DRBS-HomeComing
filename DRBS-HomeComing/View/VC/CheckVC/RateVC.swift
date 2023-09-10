import UIKit
import Then
import SnapKit
import FirebaseFirestore

final class RateVC: UIViewController {
    //MARK: - Properties
    
    lazy var houseViewModel = HouseViewModel()
    
    var house: House?
    
    private let mainTitleLabel = UILabel().then {
        $0.text = "체크리스트 평가"
        $0.font = UIFont(name: "Pretendard-Bold", size: 18)
        $0.textAlignment = .center
        $0.textColor = .black
    }
    
    private let subTitleLabel = UILabel().then {
        $0.text = "해당 공간은 몇 점짜리 공간이였나요?"
        $0.font = UIFont(name: "Pretendard-Regular", size: 14)
        $0.textColor = .darkGray
        $0.textAlignment = .left
    }
    
    private lazy var rateSlider = CustomSlider().then {
        $0.minimumValue = 0.0
        $0.maximumValue = 5.0
        $0.minimumTrackTintColor = .clear
        $0.maximumTrackTintColor = .clear
        $0.thumbTintColor = .clear
        $0.addTarget(self, action: #selector(valueChanged(_:)), for: .valueChanged)
    }
    
    private lazy var saveButton = UIButton().then {
        $0.setTitle("저장", for: .normal)
        $0.backgroundColor = Constant.appColor
        $0.layer.cornerRadius = 5
        $0.clipsToBounds = true
        $0.setTitleColor(UIColor.white, for: .normal)
        $0.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
    }
    
    private lazy var firstImageView = UIImageView().then {
        $0.image = UIImage(named: "star_unfill.png")
        $0.tag = 1
    }
    private lazy var secondImageView = UIImageView().then {
        $0.image = UIImage(named: "star_unfill.png")
        $0.tag = 2
        
    }
    private lazy var thirdImageView = UIImageView().then {
        $0.image = UIImage(named: "star_unfill.png")
        $0.tag = 3
        
    }
    private lazy var fourthImageView = UIImageView().then {
        $0.image = UIImage(named: "star_unfill.png")
        $0.tag = 4
    }
    private lazy var fiveImageView = UIImageView().then {
        $0.image = UIImage(named: "star_unfill.png")
        $0.tag = 5
    }
    
    private lazy var imageStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .fillEqually
        $0.spacing = 0
        $0.alignment = .fill
    }
    
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        settingModal()
        print("houseID = \(house?.houseId)")
        
    }
    //MARK: - Helpers
    private func configureUI() {
        self.view.backgroundColor = .white
        view.addSubviews(mainTitleLabel, subTitleLabel,
                         imageStackView, saveButton)
        imageStackView.addArrangedSubviews(firstImageView, secondImageView,
                                           thirdImageView, fourthImageView, fiveImageView)
        imageStackView.addSubview(rateSlider)
        mainTitleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(50)
            $0.width.equalToSuperview()
            $0.height.equalTo(50)}
        
        subTitleLabel.snp.makeConstraints {
            $0.top.equalTo(mainTitleLabel.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(23)
            $0.width.equalTo(self.view.frame.width - 46)
            $0.height.equalTo(30)}
        
        imageStackView.snp.makeConstraints {
            $0.centerX.equalTo(mainTitleLabel)
            $0.width.equalTo(subTitleLabel)
            $0.height.equalTo((view.frame.width - 46)/5)
            $0.top.equalTo(subTitleLabel.snp.bottom).offset(40)}
        
        rateSlider.snp.makeConstraints {$0.top.leading.trailing.bottom.equalToSuperview()}
        
        saveButton.snp.makeConstraints {
            $0.centerX.equalTo(mainTitleLabel)
            $0.width.equalTo(subTitleLabel)
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(-20)
            $0.height.equalTo(56)}
    }
    
    private func settingModal() {
        if let sheetPresentationController = sheetPresentationController {
            sheetPresentationController.detents = [.medium()]
            sheetPresentationController.prefersGrabberVisible = true
            sheetPresentationController.preferredCornerRadius = 25
        }
    }
    
    private func removeNavStack() {
        //처음화면으로 돌아가는 메서드
        //쌓인 네비게이션 스택을 제거하고 돌아가기...?쉽지 않다.
        //        self.dismiss(animated: true, completion: <#T##(() -> Void)?##(() -> Void)?##() -> Void#>)
        //여기서 completion을 통해 뭔갈 할 수 있을 것 같기도 하고..?
    }
    
    
    
    //MARK: - Actions
    @objc func valueChanged(_ sender: UISlider) {
        let floatValue = Double(sender.value)
        for index in 1...5 { // 여기서 index는 우리가 설정한 'Tag'로 매치시킬 것이다.
            if let starImage = view.viewWithTag(index) as? UIImageView {
                if Double(index) <= floatValue {
                    starImage.image = UIImage(named: "star_fill.png")
                } else {
                    if (Double(index) - floatValue) <= 0.5 {
                        starImage.image = UIImage(named: "half_star.png")
                    } else {
                        starImage.image = UIImage(named: "star_unfill.png")
                    }
                }
            }
        }
    }
    
    @objc func saveButtonTapped() {
        guard let houseId = house?.houseId else {
            self.houseViewModel.rate = houseViewModel.calculateRates(value: Double(rateSlider.value))
            self.houseViewModel.makeHouseModel()
            NetworkingManager.shared.addHouses(houseModel: self.houseViewModel.house!, images: self.houseViewModel.uiImages)
            let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
            sceneDelegate?.changeRootViewController(Tabbar(), animated: true)
            return
        }
        let houseRef = Firestore.firestore().collection("Homes").document(houseId)
        
        var dataToUpdate: [String: Any] = [:]
        if let name = houseViewModel.name { dataToUpdate["title"] = name }
        if let address = houseViewModel.address { dataToUpdate["address"] = address }
        
        if let tradingType = houseViewModel.tradingType { dataToUpdate["tradingType"] = tradingType }
        if let livingType = houseViewModel.livingType { dataToUpdate["livingType"] = livingType }
        
        if let 보증금 = houseViewModel.보증금 { dataToUpdate["deposit"] = 보증금 }
        if let 월세 = houseViewModel.월세or전세금 { dataToUpdate["rent_payment"] = 월세 }
        if let 관리비 = houseViewModel.관리비 { dataToUpdate["maintenance_fee"] = 관리비 }
        dataToUpdate["maintenance_non_list"] = houseViewModel.관리비미포함목록
        if let 면적 = houseViewModel.면적 { dataToUpdate["area"] = 면적 }
        if let 입주가능일 = houseViewModel.입주가능일 { dataToUpdate["movingDay"] = 입주가능일 }
        if let 계약기간 = houseViewModel.계약기간 { dataToUpdate["contractTerm"] = 계약기간 }
        if let 메모 = houseViewModel.memo { dataToUpdate["memo"] = 메모 }
        
        self.houseViewModel.rate = houseViewModel.calculateRates(value: Double(rateSlider.value))
        if let rate = houseViewModel.rate { dataToUpdate["rate"] = rate }
        if let checkList = houseViewModel.checkList {
            let checkListDict = try? checkList.asDictionary
            dataToUpdate["checkList"] = checkListDict
        }
        houseRef.updateData(dataToUpdate) { (error) in
            if let error = error {
                print("Failed to update house: \(error.localizedDescription)")
                return
            }
            print("Successfully updated house!")
            let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
            sceneDelegate?.changeRootViewController(Tabbar(), animated: true)
        }
    }
}
