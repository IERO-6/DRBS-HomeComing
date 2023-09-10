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
    private let directionLabel = UILabel().then {$0.text = "방향"}
    private let checkBoxImg = UIImage(named: "unCheckedBox")
    private let underlineView = UIView().then {$0.backgroundColor = UIColor.systemGray4}
    private let soundproofingLabel = UILabel().then {$0.text = "방음"}
    private let waterLabel = UILabel().then {$0.text = "수압"}
    private let moldLabel = UILabel().then {$0.text = "곰팡이"}
    private let bugLabel = UILabel().then {$0.text = "벌레"}
    private let securityLabel = UILabel().then {$0.text = "보안"}
    private let 통풍 = UILabel().then {$0.text = "통풍"}
    
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
    
    override func layoutSubviews() {
        [동향button, 북향button, 서향button, 남향button, 방음미흡button, 방음보통button, 방음우수button,
         수압미흡button, 수압보통button, 수압우수button, 통풍보통button, 통풍쾌적button, 통풍불쾌button, 곰팡이없음button, 곰팡이있음button, 보안철저button, 보안보통button, 보안미흡button, 벌레모름button, 벌레있음button, 벌레없음button].forEach { setSpacingImageViewAndTitleLabel(spacing: 5, button: $0) }
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    //MARK: - Helpers
    
    private func configureUI() {
        self.backgroundColor = .white
        self.addSubview(backView)
        backView.addSubviews(directionLabel, 동향button, 서향button, 남향button, 북향button, underlineView, soundproofingLabel, 방음우수button, 방음보통button, 방음미흡button, waterLabel, 수압우수button, 수압보통button, 수압미흡button, bugLabel, 벌레있음button, 벌레모름button, 벌레없음button, 통풍, 통풍쾌적button, 통풍보통button, 통풍불쾌button, securityLabel, 보안철저button, 보안보통button, 보안미흡button, moldLabel, 곰팡이있음button, 곰팡이없음button)
        
        backView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(500)
        }
        
        directionLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(30)
            $0.leading.equalToSuperview().offset(12)
        }
        동향button.snp.makeConstraints {
            $0.centerY.equalTo(directionLabel.snp.centerY)
            $0.leading.equalTo(directionLabel.snp.trailing).offset(10)
        }
        서향button.snp.makeConstraints {
            $0.centerY.equalTo(directionLabel.snp.centerY)
            $0.leading.equalTo(동향button.snp.trailing).offset(10)
        }
        남향button.snp.makeConstraints {
            $0.centerY.equalTo(directionLabel.snp.centerY)
            $0.leading.equalTo(서향button.snp.trailing).offset(10)
        }
        북향button.snp.makeConstraints {
            $0.centerY.equalTo(directionLabel.snp.centerY)
            $0.leading.equalTo(남향button.snp.trailing).offset(10)
        }
        addUnderlineView(below: directionLabel, to: backView, withOffset: 5, width: 260, height: 1)
        
        soundproofingLabel.snp.makeConstraints {
            $0.top.equalTo(directionLabel.snp.bottom).offset(50)
            $0.leading.equalToSuperview().offset(12)}
        방음우수button.snp.makeConstraints {
            $0.centerY.equalTo(soundproofingLabel.snp.centerY)
            $0.leading.equalTo(directionLabel.snp.trailing).offset(12)
        }
        방음보통button.snp.makeConstraints {
            $0.centerY.equalTo(soundproofingLabel.snp.centerY)
            $0.leading.equalTo(방음우수button.snp.trailing).offset(48)
        }
        방음미흡button.snp.makeConstraints {
            $0.centerY.equalTo(soundproofingLabel.snp.centerY)
            $0.leading.equalTo(방음보통button.snp.trailing).offset(48)
        }
        addUnderlineView(below: soundproofingLabel, to: backView, withOffset: 5, width: 260, height: 1)
        
        waterLabel.snp.makeConstraints {
            $0.top.equalTo(soundproofingLabel.snp.bottom).offset(50)
            $0.leading.equalToSuperview().offset(12)
        }
        수압우수button.snp.makeConstraints {
            $0.centerY.equalTo(waterLabel.snp.centerY)
            $0.leading.equalTo(waterLabel.snp.trailing).offset(12)
        }
        수압보통button.snp.makeConstraints {
            $0.centerY.equalTo(waterLabel.snp.centerY)
            $0.leading.equalTo(수압우수button.snp.trailing).offset(48)
        }
        수압미흡button.snp.makeConstraints {
            $0.centerY.equalTo(waterLabel.snp.centerY)
            $0.leading.equalTo(수압보통button.snp.trailing).offset(48)
        }
        addUnderlineView(below: waterLabel, to: backView, withOffset: 5, width: 260, height: 1)
        
        bugLabel.snp.makeConstraints {
            $0.top.equalTo(waterLabel.snp.bottom).offset(50)
            $0.leading.equalToSuperview().offset(12)
        }
        벌레있음button.snp.makeConstraints {
            $0.centerY.equalTo(bugLabel.snp.centerY)
            $0.leading.equalTo(bugLabel.snp.trailing).offset(12)
        }
        벌레모름button.snp.makeConstraints {
            $0.centerY.equalTo(bugLabel.snp.centerY)
            $0.leading.equalTo(벌레있음button.snp.trailing).offset(48)
        }
        벌레없음button.snp.makeConstraints {
            $0.centerY.equalTo(bugLabel.snp.centerY)
            $0.leading.equalTo(벌레모름button.snp.trailing).offset(48)
        }
        addUnderlineView(below: bugLabel, to: backView, withOffset: 5, width: 260, height: 1)
        
        통풍.snp.makeConstraints {
            $0.top.equalTo(bugLabel.snp.bottom).offset(50)
            $0.leading.equalToSuperview().offset(12)
        }
        통풍쾌적button.snp.makeConstraints {
            $0.centerY.equalTo(통풍.snp.centerY)
            $0.leading.equalTo(통풍.snp.trailing).offset(12)
        }
        통풍보통button.snp.makeConstraints {
            $0.centerY.equalTo(통풍.snp.centerY)
            $0.leading.equalTo(통풍쾌적button.snp.trailing).offset(48)
        }
        통풍불쾌button.snp.makeConstraints {
            $0.centerY.equalTo(통풍.snp.centerY)
            $0.leading.equalTo(통풍보통button.snp.trailing).offset(48)
        }
        addUnderlineView(below: 통풍, to: backView, withOffset: 5, width: 260, height: 1)
        
        securityLabel.snp.makeConstraints {
            $0.top.equalTo(통풍.snp.bottom).offset(50)
            $0.leading.equalToSuperview().offset(12)
        }
        보안철저button.snp.makeConstraints {
            $0.centerY.equalTo(securityLabel.snp.centerY)
            $0.leading.equalTo(securityLabel.snp.trailing).offset(12)
        }
        보안보통button.snp.makeConstraints {
            $0.centerY.equalTo(securityLabel.snp.centerY)
            $0.leading.equalTo(보안철저button.snp.trailing).offset(48)
        }
        보안미흡button.snp.makeConstraints {
            $0.centerY.equalTo(securityLabel.snp.centerY)
            $0.leading.equalTo(보안보통button.snp.trailing).offset(48)
        }
        addUnderlineView(below: securityLabel, to: backView, withOffset: 5, width: 260, height: 1)
        
        moldLabel.snp.makeConstraints {
            $0.top.equalTo(securityLabel.snp.bottom).offset(50)
            $0.leading.equalToSuperview().offset(12)}
        곰팡이있음button.snp.makeConstraints {
            $0.centerY.equalTo(moldLabel.snp.centerY)
            $0.leading.equalTo(moldLabel.snp.trailing).offset(45)
        }
        곰팡이없음button.snp.makeConstraints {
            $0.centerY.equalTo(moldLabel.snp.centerY)
            $0.leading.equalTo(곰팡이있음button.snp.trailing).offset(75)
        }
        
        [동향button, 북향button, 서향button, 남향button, 방음미흡button, 방음보통button, 방음우수button,
         수압미흡button, 수압보통button, 수압우수button, 통풍보통button, 통풍쾌적button, 통풍불쾌button, 곰팡이없음button, 곰팡이있음button, 보안철저button, 보안보통button, 보안미흡button, 벌레모름button, 벌레있음button, 벌레없음button].forEach { settingButtons(button: $0) }
        
    }
    
    private func addUnderlineView(below startView: UIView, to parentView: UIView, withOffset offset: CGFloat, width: CGFloat, height: CGFloat) {
        let underlineView = UIView().then {$0.backgroundColor = UIColor.systemGray4}
        parentView.addSubview(underlineView)
        underlineView.snp.makeConstraints {
            $0.top.equalTo(startView.snp.bottom).offset(25)
            $0.leading.equalToSuperview().offset(48)
            $0.width.equalTo(width)
            $0.height.equalTo(height)}
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
                print(방음)
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
        button.setImage(UIImage(named: "checkBox-off"), for: .normal)// 이미지 넣기
        button.setImage(UIImage(named: "checkBox-on"), for: .selected)// 이미지 넣기
        
        button.setPreferredSymbolConfiguration(.init(pointSize: 22, weight: .regular, scale: .default), forImageIn: .normal)
        button.setTitleColor(UIColor.lightGray, for: .normal)
        button.imageView?.contentMode = .scaleAspectFill
        button.titleLabel?.font = UIFont(name: "Pretendard", size: 18)
        button.contentHorizontalAlignment = .center
        button.semanticContentAttribute = .forceLeftToRight //<- 중요
        button.addTarget(self, action: #selector(toggleCheckBox(_:)), for: .touchUpInside)
        //        $0.imageEdgeInsets = .init(top: 0, left: 0, bottom: 0, right: 15) //<- 중요
    }
    
    private func setSpacingImageViewAndTitleLabel(spacing: CGFloat, button: UIButton) {
        let titleLabelWidth = button.titleLabel?.frame.width ?? 0
        guard titleLabelWidth > 0 else { return }
        button.imageEdgeInsets = .init(top: 0, left: 0, bottom: 0, right: titleLabelWidth + spacing)
        button.titleEdgeInsets = .init(top: 0, left: spacing, bottom: 0, right: 0)
    }
    //MARK: - Actions
    @objc func toggleCheckBox(_ sender: KeyedButton) {
        sender.isSelected.toggle()
        //        sender.setImage(UIImage(named: "checkBox-on"), for: .normal)
        self.checkViewModel.checkListButton(sender)
    }
}
