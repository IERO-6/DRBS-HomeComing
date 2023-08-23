import UIKit
import Then
import SnapKit

class CheckListUIView: UIView {
    //MARK: - Properties
    let checkListUIView = UIView().then {
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 10
        $0.layer.borderColor = UIColor.systemGray4.cgColor}
    private let directionLabel = UILabel().then {$0.text = "방향"}
    private let checkBoxImg = UIImage(named: "unCheckedBox")
    private let eastWindLabel = UILabel().then {
        $0.text = "동향"
        $0.textColor = UIColor.lightGray}
    private let westWindLabel = UILabel().then {
        $0.text = "서향"
        $0.textColor = UIColor.lightGray}
    private let southWindLabel = UILabel().then {
        $0.text = "남향"
        $0.textColor = UIColor.lightGray}
    private let northWindLabel = UILabel().then {
        $0.text = "북향"
        $0.textColor = UIColor.lightGray}
    private let underlineView = UIView().then {$0.backgroundColor = UIColor.systemGray4}
    private let soundproofingLabel = UILabel().then {$0.text = "방음"}
    private let excellentLabel = UILabel().then {
        $0.text = "우수"
        $0.textColor = UIColor.lightGray}
    private let moderateLabel = UILabel().then {
        $0.text = "보통"
        $0.textColor = UIColor.lightGray}
    private let insufficientLabel = UILabel().then {
        $0.text = "미흡"
        $0.textColor = UIColor.lightGray}
    private let waterLabel = UILabel().then {$0.text = "수압"}
    private let excellentwaterLabel = UILabel().then {
        $0.text = "우수"
        $0.textColor = UIColor.lightGray}
    private let moderatewaterLabel = UILabel().then {
        $0.text = "보통"
        $0.textColor = UIColor.lightGray}
    private let insufficientwaterLabel = UILabel().then {
        $0.text = "미흡"
        $0.textColor = UIColor.lightGray}
    private let bugLabel = UILabel().then {$0.text = "벌레"}
    private let yesLabel = UILabel().then {
        $0.text = "있음"
        $0.textColor = UIColor.lightGray}
    private let mysteryLabel = UILabel().then {
        $0.text = "모름"
        $0.textColor = UIColor.lightGray}
    private let noLabel = UILabel().then {
        $0.text = "없음"
        $0.textColor = UIColor.lightGray}
    private let 통풍 = UILabel().then {$0.text = "통풍"}
    private let 쾌적 = UILabel().then {
        $0.text = "쾌적"
        $0.textColor = UIColor.lightGray}
    private let moderateWindLabel = UILabel().then {
        $0.text = "보통"
        $0.textColor = UIColor.lightGray}
    private let 불쾌 = UILabel().then {
        $0.text = "불쾌"
        $0.textColor = UIColor.lightGray}
    private let securityLabel = UILabel().then {$0.text = "보안"}
    private let 철저 = UILabel().then {
        $0.text = "철저"
        $0.textColor = UIColor.lightGray}
    private let moderateSecurityLabel = UILabel().then {
        $0.text = "보통"
        $0.textColor = UIColor.lightGray}
    private let 미흡 = UILabel().then {
        $0.text = "미흡"
        $0.textColor = UIColor.lightGray}
    private let moldLabel = UILabel().then {$0.text = "곰팡이"}
    private let yesMoldLabel = UILabel().then {
        $0.text = "있음"
        $0.textColor = UIColor.lightGray}
    private let noMoldLabel = UILabel().then {
        $0.text = "없음"
        $0.textColor = UIColor.lightGray}

    //MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        setupSubviews()
        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
}

    //MARK: - Helpers
    private func setupSubviews() {
        self.addSubview(checkListUIView)
        checkListUIView.addSubviews(directionLabel, eastWindLabel, westWindLabel, southWindLabel, northWindLabel, underlineView, soundproofingLabel, excellentLabel, moderateLabel, insufficientLabel, waterLabel, excellentwaterLabel, moderatewaterLabel, insufficientwaterLabel, bugLabel, yesLabel, mysteryLabel, noLabel, 통풍, 쾌적, moderateWindLabel, 불쾌, securityLabel, 철저, moderateSecurityLabel, 미흡, moldLabel, yesMoldLabel, noMoldLabel)}

    func configureUI() {
        checkListUIView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(0)
            $0.leading.equalToSuperview().offset(0)
            $0.trailing.equalToSuperview().offset(0)
            $0.height.equalTo(500)}

        directionLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(30)
            $0.leading.equalToSuperview().offset(18)}
        eastWindLabel.snp.makeConstraints {
            $0.top.equalTo(directionLabel)
            $0.leading.equalTo(directionLabel.snp.trailing).offset(42)
            addCheckBox(toLeftOf: eastWindLabel)}
        westWindLabel.snp.makeConstraints {
            $0.top.equalTo(directionLabel)
            $0.leading.equalTo(eastWindLabel.snp.trailing).offset(42)
            addCheckBox(toLeftOf: westWindLabel)}
        southWindLabel.snp.makeConstraints {
            $0.top.equalTo(directionLabel)
            $0.leading.equalTo(westWindLabel.snp.trailing).offset(42)
            addCheckBox(toLeftOf: southWindLabel)}
        northWindLabel.snp.makeConstraints {
            $0.top.equalTo(directionLabel)
            $0.leading.equalTo(southWindLabel.snp.trailing).offset(42)
            addCheckBox(toLeftOf: northWindLabel)}
        addUnderlineView(below: directionLabel, to: checkListUIView, withOffset: 5, width: 260, height: 1)

        soundproofingLabel.snp.makeConstraints {
            $0.top.equalTo(directionLabel.snp.bottom).offset(50)
            $0.leading.equalToSuperview().offset(18)}
        excellentLabel.snp.makeConstraints {
            $0.top.equalTo(soundproofingLabel)
            $0.leading.equalTo(directionLabel.snp.trailing).offset(42)
            addCheckBox(toLeftOf: excellentLabel)}
        moderateLabel.snp.makeConstraints {
            $0.top.equalTo(soundproofingLabel)
            $0.leading.equalTo(excellentLabel.snp.trailing).offset(78)
            addCheckBox(toLeftOf: moderateLabel)}
        insufficientLabel.snp.makeConstraints {
            $0.top.equalTo(soundproofingLabel)
            $0.leading.equalTo(moderateLabel.snp.trailing).offset(78)
            addCheckBox(toLeftOf: insufficientLabel)}
        addUnderlineView(below: soundproofingLabel, to: checkListUIView, withOffset: 5, width: 260, height: 1)

        waterLabel.snp.makeConstraints {
            $0.top.equalTo(soundproofingLabel.snp.bottom).offset(50)
            $0.leading.equalToSuperview().offset(18)}
        excellentwaterLabel.snp.makeConstraints {
            $0.top.equalTo(waterLabel)
            $0.leading.equalTo(waterLabel.snp.trailing).offset(42)
            addCheckBox(toLeftOf: excellentwaterLabel)}
        moderatewaterLabel.snp.makeConstraints {
            $0.top.equalTo(waterLabel)
            $0.leading.equalTo(excellentwaterLabel.snp.trailing).offset(78)
            addCheckBox(toLeftOf: moderatewaterLabel)}
        insufficientwaterLabel.snp.makeConstraints {
            $0.top.equalTo(waterLabel)
            $0.leading.equalTo(moderatewaterLabel.snp.trailing).offset(78)
            addCheckBox(toLeftOf: insufficientwaterLabel)}
        addUnderlineView(below: waterLabel, to: checkListUIView, withOffset: 5, width: 260, height: 1)

        bugLabel.snp.makeConstraints {
            $0.top.equalTo(waterLabel.snp.bottom).offset(50)
            $0.leading.equalToSuperview().offset(18)}
        yesLabel.snp.makeConstraints {
            $0.top.equalTo(bugLabel)
            $0.leading.equalTo(bugLabel.snp.trailing).offset(42)
            addCheckBox(toLeftOf: yesLabel)}
        mysteryLabel.snp.makeConstraints {
            $0.top.equalTo(bugLabel)
            $0.leading.equalTo(yesLabel.snp.trailing).offset(78)
            addCheckBox(toLeftOf: mysteryLabel)}
        noLabel.snp.makeConstraints {
            $0.top.equalTo(bugLabel)
            $0.leading.equalTo(mysteryLabel.snp.trailing).offset(78)
            addCheckBox(toLeftOf: noLabel)}
        addUnderlineView(below: bugLabel, to: checkListUIView, withOffset: 5, width: 260, height: 1)

        통풍.snp.makeConstraints {
            $0.top.equalTo(bugLabel.snp.bottom).offset(50)
            $0.leading.equalToSuperview().offset(18)}
        쾌적.snp.makeConstraints {
            $0.top.equalTo(통풍)
            $0.leading.equalTo(통풍.snp.trailing).offset(42)
            addCheckBox(toLeftOf: 쾌적)}
        moderateWindLabel.snp.makeConstraints {
            $0.top.equalTo(통풍)
            $0.leading.equalTo(쾌적.snp.trailing).offset(78)
            addCheckBox(toLeftOf: moderateWindLabel)}
        불쾌.snp.makeConstraints {
            $0.top.equalTo(통풍)
            $0.leading.equalTo(moderateWindLabel.snp.trailing).offset(78)
            addCheckBox(toLeftOf: 불쾌)}
        addUnderlineView(below: 통풍, to: checkListUIView, withOffset: 5, width: 260, height: 1)

        securityLabel.snp.makeConstraints {
            $0.top.equalTo(통풍.snp.bottom).offset(50)
            $0.leading.equalToSuperview().offset(18)}
        철저.snp.makeConstraints {
            $0.top.equalTo(securityLabel)
            $0.leading.equalTo(securityLabel.snp.trailing).offset(42)
            addCheckBox(toLeftOf: 철저)}
        moderateSecurityLabel.snp.makeConstraints {
            $0.top.equalTo(securityLabel)
            $0.leading.equalTo(철저.snp.trailing).offset(78)
            addCheckBox(toLeftOf: moderateSecurityLabel)}
        미흡.snp.makeConstraints {
            $0.top.equalTo(securityLabel)
            $0.leading.equalTo(moderateSecurityLabel.snp.trailing).offset(78)
            addCheckBox(toLeftOf: 미흡)}
        addUnderlineView(below: securityLabel, to: checkListUIView, withOffset: 5, width: 260, height: 1)

        moldLabel.snp.makeConstraints {
            $0.top.equalTo(securityLabel.snp.bottom).offset(50)
            $0.leading.equalToSuperview().offset(18)}
        yesMoldLabel.snp.makeConstraints {
            $0.top.equalTo(moldLabel)
            $0.leading.equalTo(moldLabel.snp.trailing).offset(85)
            addCheckBox(toLeftOf: yesMoldLabel)}
        noMoldLabel.snp.makeConstraints {
            $0.top.equalTo(moldLabel)
            $0.leading.equalTo(yesMoldLabel.snp.trailing).offset(85)
            addCheckBox(toLeftOf: noMoldLabel)}
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

    func addCheckBox(toLeftOf label: UILabel) {
        let checkBox = UIButton().then {
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

    //MARK: - Actions
    @objc func toggleCheckBox(_ sender: UIButton) {
        sender.isSelected.toggle()}
}
