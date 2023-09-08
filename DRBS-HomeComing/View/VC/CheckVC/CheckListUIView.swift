import UIKit
import Then
import SnapKit

final class CheckListUIView: UIView {
    //MARK: - Properties
    
    var checkViewModel = CheckViewModel()
    
    let checkListUIView = UIView().then {
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 10
        $0.layer.borderColor = UIColor.systemGray4.cgColor}
    private let directionLabel = UILabel().then {$0.text = "방향"}
    private let checkBoxImg = UIImage(named: "unCheckedBox")
    
    private lazy var 동향button = KeyedButton().then {
        $0.key = "동향"
        $0.setTitle("동향", for: .normal)
      
    }
    private lazy var 서향button = KeyedButton().then {
        $0.key = "서향"
        $0.setTitle("서향", for: .normal)
    }
    
    private lazy var 남향button = KeyedButton().then {
        $0.key = "남향"
        $0.setTitle("남향", for: .normal)
    }
    
    private lazy var 북향button = KeyedButton().then {
        $0.key = "북향"
        $0.setTitle("북향", for: .normal)
        
    }
    private let underlineView = UIView().then {$0.backgroundColor = UIColor.systemGray4}
    private let soundproofingLabel = UILabel().then {$0.text = "방음"}
    private lazy var 방음우수button = KeyedButton().then {
        $0.key = "방음우수"
        $0.setTitle("우수", for: .normal)
    }
    private lazy var 방음보통button = KeyedButton().then {
        $0.key = "방음보통"
        $0.setTitle("보통", for: .normal)
    }
    private lazy var 방음미흡button = KeyedButton().then {
        $0.key = "방음미흡"
        $0.setTitle("미흡", for: .normal)
        
    }
    
    private let waterLabel = UILabel().then {$0.text = "수압"}
    private lazy var 수압우수button = KeyedButton().then {
        $0.key = "수압우수"
        $0.setTitle("우수", for: .normal)
    }
    private lazy var 수압보통button = KeyedButton().then {
        $0.key = "수압보통"
        $0.setTitle("보통", for: .normal)

    }
    private lazy var 수압미흡button = KeyedButton().then {
        $0.key = "수압미흡"
        $0.setTitle("미흡", for: .normal)
    }
    private let bugLabel = UILabel().then {$0.text = "벌레"}
    private lazy var 벌레있음button = KeyedButton().then {
        $0.key = "벌레있음"
        $0.setTitle("있음", for: .normal)
    }
    private lazy var 벌레모름button = KeyedButton().then {
        $0.key = "벌레모름"
        $0.setTitle("모름", for: .normal)
    }
    private lazy var 벌레없음button = KeyedButton().then {
        $0.key = "벌레없음"
        $0.setTitle("없음", for: .normal)
    }
    private let 통풍 = UILabel().then {$0.text = "통풍"}
    private lazy var 통풍쾌적button = KeyedButton().then {
        $0.key = "통풍쾌적"
        $0.setTitle("쾌적", for: .normal)
    }
    private lazy var 통풍보통button = KeyedButton().then {
        $0.key = "통풍보통"
        $0.setTitle("보통", for: .normal)
    }
    private lazy var 통풍불쾌button = KeyedButton().then {
        $0.key = "통풍불쾌"
        $0.setTitle("불쾌", for: .normal)
    }
    private let securityLabel = UILabel().then {$0.text = "보안"}
    private lazy var 보안철저button = KeyedButton().then {
        $0.key = "보안철저"
        $0.setTitle("철저", for: .normal)
    }
    private lazy var 보안보통button = KeyedButton().then {
        $0.key = "보안보통"
        $0.setTitle("보통", for: .normal)
    }
    private lazy var 보안미흡button = KeyedButton().then {
        $0.key = "보안미흡"
        $0.setTitle("미흡", for: .normal)
    }
    private let moldLabel = UILabel().then {$0.text = "곰팡이"}
    private lazy var 곰팡이있음button = KeyedButton().then {
        $0.key = "곰팡이있음"
        $0.setTitle("있음", for: .normal)
    }
    private lazy var 곰팡이없음button = KeyedButton().then {
        $0.key = "곰팡이없음"
        $0.setTitle("없음", for: .normal)
    }


    //MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        setupSubviews()
        configureUI()
        configureUIWithData()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
}

    //MARK: - Helpers
    private func setupSubviews() {
        self.addSubview(checkListUIView)
        checkListUIView.addSubviews(directionLabel, 동향button
                                    , 서향button, 남향button, 북향button, underlineView, soundproofingLabel, 방음우수button, 방음보통button, 방음미흡button, waterLabel, 수압우수button, 수압보통button, 수압미흡button, bugLabel, 벌레있음button, 벌레모름button, 벌레없음button, 통풍, 통풍쾌적button, 통풍보통button, 통풍불쾌button, securityLabel, 보안철저button, 보안보통button, 보안미흡button, moldLabel, 곰팡이있음button, 곰팡이없음button)}

    func configureUI() {
        checkListUIView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(0)
            $0.leading.equalToSuperview().offset(0)
            $0.trailing.equalToSuperview().offset(0)
            $0.height.equalTo(500)}

        directionLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(30)
            $0.leading.equalToSuperview().offset(18)
        }
        동향button.snp.makeConstraints {
            $0.centerY.equalTo(directionLabel.snp.centerY)
            $0.leading.equalTo(directionLabel.snp.trailing).offset(12)
        }
        서향button.snp.makeConstraints {
            $0.centerY.equalTo(directionLabel.snp.centerY)
            $0.leading.equalTo(동향button.snp.trailing).offset(12)
        }
        남향button.snp.makeConstraints {
            $0.centerY.equalTo(directionLabel.snp.centerY)
            $0.leading.equalTo(서향button.snp.trailing).offset(12)
        }
        북향button.snp.makeConstraints {
            $0.centerY.equalTo(directionLabel.snp.centerY)
            $0.leading.equalTo(남향button.snp.trailing).offset(12)
        }
        addUnderlineView(below: directionLabel, to: checkListUIView, withOffset: 5, width: 260, height: 1)

        soundproofingLabel.snp.makeConstraints {
            $0.top.equalTo(directionLabel.snp.bottom).offset(50)
            $0.leading.equalToSuperview().offset(18)}
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
        addUnderlineView(below: soundproofingLabel, to: checkListUIView, withOffset: 5, width: 260, height: 1)

        waterLabel.snp.makeConstraints {
            $0.top.equalTo(soundproofingLabel.snp.bottom).offset(50)
            $0.leading.equalToSuperview().offset(18)}
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
        addUnderlineView(below: waterLabel, to: checkListUIView, withOffset: 5, width: 260, height: 1)

        bugLabel.snp.makeConstraints {
            $0.top.equalTo(waterLabel.snp.bottom).offset(50)
            $0.leading.equalToSuperview().offset(18)
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
        addUnderlineView(below: bugLabel, to: checkListUIView, withOffset: 5, width: 260, height: 1)

        통풍.snp.makeConstraints {
            $0.top.equalTo(bugLabel.snp.bottom).offset(50)
            $0.leading.equalToSuperview().offset(18)
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
        addUnderlineView(below: 통풍, to: checkListUIView, withOffset: 5, width: 260, height: 1)

        securityLabel.snp.makeConstraints {
            $0.top.equalTo(통풍.snp.bottom).offset(50)
            $0.leading.equalToSuperview().offset(18)
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
        addUnderlineView(below: securityLabel, to: checkListUIView, withOffset: 5, width: 260, height: 1)

        moldLabel.snp.makeConstraints {
            $0.top.equalTo(securityLabel.snp.bottom).offset(50)
            $0.leading.equalToSuperview().offset(18)}
        곰팡이있음button.snp.makeConstraints {
            $0.centerY.equalTo(moldLabel.snp.centerY)
            $0.leading.equalTo(moldLabel.snp.trailing).offset(45)
        }
        곰팡이없음button.snp.makeConstraints {
            $0.centerY.equalTo(moldLabel.snp.centerY)
            $0.leading.equalTo(곰팡이있음button.snp.trailing).offset(75)
        }
        
        [동향button, 북향button, 서향button, 남향button, 방음미흡button, 방음보통button, 방음우수button,
         수압미흡button, 수압보통button, 수압우수button, 통풍보통button, 통풍쾌적button, 통풍불쾌button, 곰팡이없음button, 곰팡이있음button, 보안철저button, 보안보통button, 보안미흡button, 벌레모름button, 벌레있음button, 벌레없음button].forEach { button in
            settingButtons(button: button)
        }
        
    }

    func addUnderlineView(below startView: UIView, to parentView: UIView, withOffset offset: CGFloat, width: CGFloat, height: CGFloat) {
        let underlineView = UIView().then {$0.backgroundColor = UIColor.systemGray4}
        parentView.addSubview(underlineView)
        underlineView.snp.makeConstraints {
            $0.top.equalTo(startView.snp.bottom).offset(25)
            $0.leading.equalToSuperview().offset(48)
            $0.width.equalTo(width)
            $0.height.equalTo(height)}
    }

    func addCheckBox(toLeftOf label: UILabel, key: String, tag: Int) {
        let checkBox = KeyedButton().then {
            $0.key = key
            $0.tag = tag
            $0.setImage(UIImage(named: "checkBox-off"), for: .normal)
            $0.setImage(UIImage(named: "checkBox-on"), for: .selected)
            $0.addTarget(self, action: #selector(toggleCheckBox(_:)), for: .touchUpInside)
        }
        checkListUIView.addSubview(checkBox)
        checkBox.snp.makeConstraints {
            $0.centerY.equalTo(label)
            $0.trailing.equalTo(label.snp.leading).offset(-10)
            $0.width.height.equalTo(22)}
    }
    
    func configureUIWithData() {

    }

    private func settingButtons(button: UIButton) {
        button.setImage(UIImage(named: "checkBox-off"), for: .normal)// 이미지 넣기
        button.setTitleColor(UIColor.lightGray, for: .normal)
        button.imageView?.contentMode = .scaleAspectFill
        button.titleLabel?.font = UIFont(name: "Pretendard", size: 18)
        button.contentHorizontalAlignment = .center
        button.semanticContentAttribute = .forceLeftToRight //<- 중요
//        $0.imageEdgeInsets = .init(top: 0, left: 0, bottom: 0, right: 15) //<- 중요
    }
    //MARK: - Actions
    @objc func toggleCheckBox(_ sender: KeyedButton) {
            sender.isSelected.toggle()
            self.checkViewModel.checkListButton(sender)
    }
}
