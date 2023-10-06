import UIKit
import Then
import SnapKit
import FirebaseFirestore
import JGProgressHUD

final class RateVC: UIViewController {
    //MARK: - Properties
    
    lazy var houseViewModel = HouseViewModel()
    
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
    
    private lazy var hud = JGProgressHUD(style: .dark)
    
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        settingModal()
        
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
        DispatchQueue.main.async { self.hud.show(in: self.view, animated: true) }
        self.houseViewModel.rate = self.houseViewModel.calculateRates(value: Double(self.rateSlider.value))
        guard self.houseViewModel.house != nil else {
            DispatchQueue.global().async {
                self.houseViewModel.makeHouseModel()
                NetworkingManager.shared.addHouses(houseModel: self.houseViewModel.house!, images: self.houseViewModel.uiImages) { isCompleted in
                    if isCompleted {
                        DispatchQueue.main.async {
                            let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
                            sceneDelegate?.changeRootViewController(Tabbar(), animated: true)
                            DispatchQueue.main.async {
                                self.hud.dismiss()
                            }
                        }
                    } else {
                        //올리는데 실패한 경우
                        DispatchQueue.main.async {
                            self.hud.dismiss()
                            self.presentAlert(alertTitle: "올리는 데 실패했습니다.", message: "다시 시도해보세요", confirmMessage: "확인")
                        }
                    }
                }
                
            }
            return
        }
        DispatchQueue.global().async {
            self.houseViewModel.houseId = self.houseViewModel.house?.houseId
            self.houseViewModel.makeHouseModel()
            NetworkingManager.shared.updateHouseInFirebase(houseModel: self.houseViewModel.house!, images: self.houseViewModel.uiImages) { isCompleted in
                if isCompleted {
                    DispatchQueue.main.async {
                        let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
                        sceneDelegate?.changeRootViewController(Tabbar(), animated: true)
                        DispatchQueue.main.async { self.hud.dismiss() }
                    }
                } else {
                    //올리는데 실패한 경우
                    DispatchQueue.main.async {
                        self.hud.dismiss()
                        self.presentAlert(alertTitle: "올리는 데 실패했습니다.", message: "다시 시도해보세요", confirmMessage: "확인")
                    }
                }
            }
            
        }
    }
}


