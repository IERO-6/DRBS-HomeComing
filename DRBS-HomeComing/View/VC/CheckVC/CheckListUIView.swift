import UIKit
import Then
import SnapKit

final class CheckListUIView: UIView {
    //MARK: - Properties
    var checkViewModel = CheckViewModel()
    
    let backView = UIView().then {
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 10
        $0.layer.borderColor = UIColor.systemGray4.cgColor
    }
    private let checkBoxImg = UIImage(named: "unCheckedBox")
//    private let underlineView = UIView().then {$0.backgroundColor = UIColor.systemGray4}
    private let directionLabel = UILabel().then {
        $0.text = "방향"
        $0.font = UIFont(name: "Pretendard-Medium", size: 18.0)
    }
    private let soundproofingLabel = UILabel().then {
        $0.text = "방음"
        $0.font = UIFont(name: "Pretendard-Medium", size: 18.0)
    }
    private let waterPressureLabel = UILabel().then {
        $0.text = "수압"
        $0.font = UIFont(name: "Pretendard-Medium", size: 18.0)
    }
    private let moldLabel = UILabel().then {
        $0.text = "곰팡이"
        $0.font = UIFont(name: "Pretendard-Medium", size: 18.0)
    }
    private let bugLabel = UILabel().then {
        $0.text = "벌레"
        $0.font = UIFont(name: "Pretendard-Medium", size: 18.0)
    }
    private let securityLabel = UILabel().then {
        $0.text = "보안"
        $0.font = UIFont(name: "Pretendard-Medium", size: 18.0)
    }
    private let ventilationLabel = UILabel().then {
        $0.text = "통풍"
        $0.font = UIFont(name: "Pretendard-Medium", size: 18.0)
    }
    
    private lazy var 동향button = KeyedButton().then {
        $0.tag = 1
        $0.key = "동향"
        $0.setTitle("동향", for: .normal)
    }
    private lazy var 서향button = KeyedButton().then {
        $0.tag = 1
        $0.key = "서향"
        $0.setTitle("서향", for: .normal)
    }
    private lazy var 남향button = KeyedButton().then {
        $0.tag = 1
        $0.key = "남향"
        $0.setTitle("남향", for: .normal)
    }
    private lazy var 북향button = KeyedButton().then {
        $0.tag = 1
        $0.key = "북향"
        $0.setTitle("북향", for: .normal)
    }
    private lazy var 방음우수button = KeyedButton().then {
        $0.tag = 2
        $0.key = "우수"
        $0.setTitle("우수", for: .normal)
    }
    private lazy var 방음보통button = KeyedButton().then {
        $0.tag = 2
        $0.key = "보통"
        $0.setTitle("보통", for: .normal)
    }
    private lazy var 방음미흡button = KeyedButton().then {
        $0.tag = 2
        $0.key = "미흡"
        $0.setTitle("미흡", for: .normal)
    }
    private lazy var 수압우수button = KeyedButton().then {
        $0.tag = 3
        $0.key = "우수"
        $0.setTitle("우수", for: .normal)
    }
    private lazy var 수압보통button = KeyedButton().then {
        $0.tag = 3
        $0.key = "보통"
        $0.setTitle("보통", for: .normal)
    }
    private lazy var 수압미흡button = KeyedButton().then {
        $0.tag = 3
        $0.key = "미흡"
        $0.setTitle("미흡", for: .normal)
    }
    private lazy var 벌레있음button = KeyedButton().then {
        $0.tag = 4
        $0.key = "있음"
        $0.setTitle("있음", for: .normal)
    }
    private lazy var 벌레모름button = KeyedButton().then {
        $0.tag = 4
        $0.key = "모름"
        $0.setTitle("모름", for: .normal)
    }
    private lazy var 벌레없음button = KeyedButton().then {
        $0.tag = 4
        $0.key = "없음"
        $0.setTitle("없음", for: .normal)
    }
    private lazy var 통풍쾌적button = KeyedButton().then {
        $0.tag = 5
        $0.key = "쾌적"
        $0.setTitle("쾌적", for: .normal)
    }
    private lazy var 통풍보통button = KeyedButton().then {
        $0.tag = 5
        $0.key = "보통"
        $0.setTitle("보통", for: .normal)
    }
    private lazy var 통풍불쾌button = KeyedButton().then {
        $0.tag = 5
        $0.key = "불쾌"
        $0.setTitle("불쾌", for: .normal)
    }
    private lazy var 보안철저button = KeyedButton().then {
        $0.tag = 6
        $0.key = "철저"
        $0.setTitle("철저", for: .normal)
    }
    private lazy var 보안보통button = KeyedButton().then {
        $0.tag = 6
        $0.key = "보통"
        $0.setTitle("보통", for: .normal)
    }
    private lazy var 보안미흡button = KeyedButton().then {
        $0.tag = 6
        $0.key = "미흡"
        $0.setTitle("미흡", for: .normal)
    }
    private lazy var 곰팡이있음button = KeyedButton().then {
        $0.tag = 7
        $0.key = "있음"
        $0.setTitle("있음", for: .normal)
    }
    private lazy var 곰팡이없음button = KeyedButton().then {
        $0.tag = 7
        $0.key = "없음"
        $0.setTitle("없음", for: .normal)
    }
    
    //MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        configureUIWithData()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    //MARK: - Helpers
    
    private func configureUI() {
        self.backgroundColor = .white
        self.addSubview(backView)
        
        let directionStack = UIStackView(arrangedSubviews: [directionLabel, 동향button, 서향button, 남향button, 북향button])
        directionStack.axis = .horizontal
        directionStack.spacing = 8
        directionStack.distribution = .fillEqually
        
        let soundproofingStack = UIStackView(arrangedSubviews: [soundproofingLabel, 방음우수button, 방음보통button, 방음미흡button])
        soundproofingStack.axis = .horizontal
        soundproofingStack.spacing = 12
        soundproofingStack.distribution = .fillEqually
        
        let waterPressureStack = UIStackView(arrangedSubviews: [waterPressureLabel, 수압우수button, 수압보통button, 수압미흡button])
        waterPressureStack.axis = .horizontal
        waterPressureStack.spacing = 12
        waterPressureStack.distribution = .fillEqually
        
        let bugStack = UIStackView(arrangedSubviews: [bugLabel, 벌레있음button, 벌레모름button, 벌레없음button])
        bugStack.axis = .horizontal
        bugStack.spacing = 12
        bugStack.distribution = .fillEqually
        
        let ventilationStack = UIStackView(arrangedSubviews: [ventilationLabel, 통풍쾌적button, 통풍보통button, 통풍불쾌button])
        ventilationStack.axis = .horizontal
        ventilationStack.spacing = 12
        ventilationStack.distribution = .fillEqually
        
        let securityStack = UIStackView(arrangedSubviews: [securityLabel, 보안철저button, 보안보통button, 보안미흡button])
        securityStack.axis = .horizontal
        securityStack.spacing = 12
        securityStack.distribution = .fillEqually
        
        let moldStack = UIStackView(arrangedSubviews: [moldLabel, 곰팡이있음button, 곰팡이없음button])
        moldStack.axis = .horizontal
        moldStack.spacing = 12
        moldStack.distribution = .fillEqually
        
        let checkListVstack = UIStackView(arrangedSubviews: [directionStack,
                                                             soundproofingStack,
                                                             waterPressureStack,
                                                             bugStack,
                                                             ventilationStack,
                                                             securityStack,
                                                             moldStack])
        checkListVstack.axis = .vertical
        checkListVstack.spacing = 12
        
        backView.addSubview(checkListVstack)
        
        backView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(checkListVstack)
        }
        
        checkListVstack.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(17)
            $0.trailing.equalToSuperview().offset(-15)
            $0.top.equalToSuperview().offset(30)
            
            $0.bottom.lessThanOrEqualToSuperview().offset(-30)
            distributeEvenly(for: [동향button, 서향button ,남향button ,북향button])
            addUnderlineView(to: backView, below: directionStack)
            distributeEvenly(for: [방음우수button ,방음보통button ,방음미흡button])
            addUnderlineView(to: backView, below: soundproofingStack)
            distributeEvenly(for: [수압우수button, 수압보통button, 수압미흡button])
            addUnderlineView(to: backView, below: waterPressureStack)
            distributeEvenly(for: [벌레있음button, 벌레모름button, 벌레없음button])
            addUnderlineView(to: backView, below: bugStack)
            distributeEvenly(for: [통풍쾌적button, 통풍보통button, 통풍불쾌button])
            addUnderlineView(to: backView, below: ventilationStack)
            distributeEvenly(for: [보안철저button, 보안보통button, 보안미흡button])
            addUnderlineView(to: backView, below: securityStack)
            distributeEvenly(for: [곰팡이있음button, 곰팡이없음button])
        }
        
        [동향button, 북향button, 서향button, 남향button, 방음미흡button, 방음보통button, 방음우수button,
         수압미흡button, 수압보통button, 수압우수button, 통풍보통button, 통풍쾌적button, 통풍불쾌button, 곰팡이없음button, 곰팡이있음button, 보안철저button, 보안보통button, 보안미흡button, 벌레모름button, 벌레있음button, 벌레없음button].forEach { settingButtons(button: $0) }
    }
    
    private func addUnderlineView(to parent: UIView, below stack: UIStackView){
        let underline = UIView().then {
            $0.backgroundColor = UIColor.systemGray4
        }
        
        parent.addSubview(underline)
        
        underline.snp.makeConstraints { make in
            make.top.equalTo(stack.snp.bottom).offset(10)
            make.centerX.equalTo(parent)
            make.width.equalTo(parent).multipliedBy(3.8 / 5.0)
            make.height.equalTo(1)
        }
    }
    
    private func createSectionView(with stackView: UIStackView) -> UIView {
        let sectionView = UIView()
        sectionView.addSubview(stackView)
        addUnderlineView(to: sectionView, below: stackView)
        
        stackView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
        }
        
        return sectionView
    }
    
    func configureUIWithData() {
        self.checkViewModel.onCompleted = { checkList in
            guard let checkList = checkList else { return }
            guard let 방음array = checkList.방음,
                  let 방향array = checkList.방향,
                  let 수압array = checkList.수압,
                  let 통풍array = checkList.통풍,
                  let 벌레array = checkList.벌레,
                  let 보안array = checkList.보안,
                  let 곰팡이array = checkList.곰팡이 else { return }
            for 방음 in 방음array {
                [self.방음우수button, self.방음보통button, self.방음미흡button].forEach { 버튼 in
                    if 방음 == 버튼.currentTitle ?? "" {
                        버튼.isSelected = true
                    }
                }
            }
            방향array.forEach { 방향 in
                [self.남향button, self.동향button, self.서향button, self.북향button].forEach { 버튼 in
                    if 방향 == 버튼.currentTitle ?? "" {
                        버튼.isSelected = true
                    }
                }
            }
            수압array.forEach { 수압 in
                [self.수압우수button, self.수압보통button, self.수압미흡button].forEach { 버튼 in
                    if 수압 == 버튼.currentTitle ?? "" {
                        버튼.isSelected = true
                    }
                }
            }
            통풍array.forEach { 통풍 in
                [self.통풍쾌적button, self.통풍보통button, self.통풍불쾌button].forEach { 버튼 in
                    if 통풍 == 버튼.currentTitle ?? "" {
                        버튼.isSelected = true
                    }
                }
            }
            벌레array.forEach { 벌레 in
                [self.벌레있음button, self.벌레모름button, self.벌레없음button].forEach { 버튼 in
                    if 벌레 == 버튼.currentTitle ?? "" {
                        버튼.isSelected = true
                    }
                }
            }
            보안array.forEach { 보안 in
                [self.보안철저button, self.보안보통button, self.보안미흡button].forEach { 버튼 in
                    if 보안 == 버튼.currentTitle ?? "" {
                        버튼.isSelected = true
                    }
                }
            }
            곰팡이array.forEach { 곰팡이 in
                [self.곰팡이있음button, self.곰팡이없음button].forEach { 버튼 in
                    if 곰팡이 == 버튼.currentTitle ?? "" {
                        버튼.isSelected = true
                    }
                }
            }
        }
    }
    
    private func settingButtons(button: UIButton) {
        let newSize = CGSize(width: 24, height: 26)
        button.setImage(UIImage(named: "checkBox-off")?.resized(to: newSize), for: .normal)
        button.setImage(UIImage(named: "checkBox-on")?.resized(to: newSize), for: .selected)
        
        button.setTitleColor(UIColor(red: 0.36, green: 0.36, blue: 0.38, alpha: 1.00), for: .normal)
        button.imageView?.contentMode = .scaleAspectFill
        button.titleLabel?.font = UIFont(name: "Pretendard-Regular", size: 18)
        button.contentHorizontalAlignment = .center
        button.semanticContentAttribute = .forceLeftToRight //<- 중요
        button.addTarget(self, action: #selector(toggleCheckBox(_:)), for: .touchUpInside)
        //        $0.imageEdgeInsets = .init(top: 0, left: 0, bottom: 0, right: 15) //<- 중요
    }
    
    //MARK: - Actions
    @objc func toggleCheckBox(_ sender: KeyedButton) {
        sender.isSelected.toggle()
        //        sender.setImage(UIImage(named: "checkBox-on"), for: .normal)
        self.checkViewModel.checkListButton(sender)
    }
    
    func distributeEvenly(for buttons: [UIButton]) {
        guard let firstButton = buttons.first else { return }
        for button in buttons.dropFirst() {
            button.snp.makeConstraints { make in
                make.width.equalTo(firstButton)
            }
        }
    }
}
