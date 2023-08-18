import UIKit
import Then
import SnapKit

//+버튼 눌렀을 때 나오는 화면
final class CheckVC1: UIViewController {
    //MARK: - Properties
    var nameIndex: Int?
    private let houseViewModel = HouseViewModel()
    private let nameLabel = UILabel().then {
        $0.text = "이름*"
        $0.font = UIFont(name: Constant.font, size: 16)}
    private let nameTextField = UITextField().then {$0.placeholder = "이름을 입력해주세요"}
    private let tradeLabel = UILabel().then {
        $0.text = "거래 방식*"
        $0.font = UIFont(name: Constant.font, size: 16)
        $0.textColor = .darkGray}
    
    
    private lazy var 월세버튼 = UIButton().then {
        $0.setTitle("월세", for: .normal)
        $0.setTitleColor(UIColor.darkGray, for: .normal)
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.systemGray4.cgColor
        $0.layer.cornerRadius = 20
        $0.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        
    }
    private lazy var 전세버튼 = UIButton().then {
        $0.setTitle("전세", for: .normal)
        $0.setTitleColor(UIColor.darkGray, for: .normal)
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.systemGray4.cgColor
        $0.layer.cornerRadius = 20
        $0.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)}
    private lazy var 매매버튼 = UIButton().then {
        $0.setTitle("매매", for: .normal)
        $0.setTitleColor(UIColor.darkGray, for: .normal)
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.systemGray4.cgColor
        $0.layer.cornerRadius = 20
        $0.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)}
    private lazy var tradeButtons = [월세버튼, 전세버튼, 매매버튼]
    private let livingLabel = UILabel().then {
        $0.text = "주거 형태*"
        $0.font = UIFont(name: Constant.font, size: 16)
        $0.textColor = .darkGray}
    private lazy var 아파트버튼 = UIButton().then {
        $0.setTitle("아파트", for: .normal)
        $0.setTitleColor(UIColor.darkGray, for: .normal)
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.systemGray4.cgColor
        $0.layer.cornerRadius = 20
        $0.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)}
    private lazy var 투룸버튼 = UIButton().then {
        $0.setTitle("빌라/투룸+", for: .normal)
        $0.setTitleColor(UIColor.darkGray, for: .normal)
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.systemGray4.cgColor
        $0.layer.cornerRadius = 20
        $0.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)}
    private lazy var 오피스텔버튼 = UIButton().then {
        $0.setTitle("오피스텔", for: .normal)
        $0.setTitleColor(UIColor.darkGray, for: .normal)
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.systemGray4.cgColor
        $0.layer.cornerRadius = 20
        $0.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)}
    private lazy var 원룸버튼 = UIButton().then {
        $0.setTitle("원룸", for: .normal)
        $0.setTitleColor(UIColor.darkGray, for: .normal)
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.systemGray4.cgColor
        $0.layer.cornerRadius = 20
        $0.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)}
    private lazy var livingButtons = [아파트버튼, 투룸버튼, 오피스텔버튼, 원룸버튼]
    private let addressLabel = UILabel().then {$0.text = "주소*"}
    private let addressTextField = UITextField().then {$0.placeholder = "경기도 수원시 권선구 매실로 70"}
    private lazy var nextButton = UIButton().then {
        $0.backgroundColor = Constant.appColor
        $0.setTitle("다음", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.layer.cornerRadius = 10
        $0.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)}
        
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setupNavigationBar()
        setUpLabel()
    }
    override func viewDidLayoutSubviews() {
        addressTextField.layer.addBottomLayer()
        nameTextField.layer.addBottomLayer()
    }
    
    //MARK: - Helpers
    
    private func configureUI() {
        view.backgroundColor = .white
        view.addSubviews(nameLabel, nameTextField, tradeLabel,
                         월세버튼, 전세버튼, 매매버튼, livingLabel,
                         아파트버튼, 투룸버튼, 오피스텔버튼, 원룸버튼,
                        addressLabel, addressTextField, nextButton)
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(20)
            $0.leading.equalTo(self.view.safeAreaLayoutGuide.snp.leading).offset(23)}
        nameTextField.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(10)
            $0.height.equalTo(30)
            $0.leading.equalTo(self.view.safeAreaLayoutGuide.snp.leading).offset(23)
            $0.trailing.equalTo(self.view.safeAreaLayoutGuide.snp.trailing).offset(-23)
        }
        tradeLabel.snp.makeConstraints {
            $0.top.equalTo(nameTextField.snp.bottom).offset(20)
            $0.leading.equalTo(self.view.safeAreaLayoutGuide.snp.leading).offset(23)}
        월세버튼.snp.makeConstraints {
            $0.top.equalTo(tradeLabel.snp.bottom).offset(20)
            $0.leading.equalTo(self.view.safeAreaLayoutGuide.snp.leading).offset(23)
            $0.width.equalTo(75)
            $0.height.equalTo(45)}
        전세버튼.snp.makeConstraints {
            $0.top.equalTo(월세버튼)
            $0.leading.equalTo(월세버튼.snp.trailing).offset(20)
            $0.width.equalTo(월세버튼)
            $0.height.equalTo(월세버튼)}
        매매버튼.snp.makeConstraints {
            $0.top.equalTo(월세버튼)
            $0.leading.equalTo(전세버튼.snp.trailing).offset(20)
            $0.width.equalTo(월세버튼)
            $0.height.equalTo(월세버튼)}
        livingLabel.snp.makeConstraints {
            $0.top.equalTo(월세버튼.snp.bottom).offset(20)
            $0.leading.equalTo(self.view.safeAreaLayoutGuide.snp.leading).offset(23)}
        아파트버튼.snp.makeConstraints {
            $0.top.equalTo(livingLabel.snp.bottom).offset(20)
            $0.leading.equalTo(self.view.safeAreaLayoutGuide.snp.leading).offset(23)
            $0.width.equalTo(75)
            $0.height.equalTo(45)}
        투룸버튼.snp.makeConstraints {
            $0.top.equalTo(아파트버튼)
            $0.leading.equalTo(아파트버튼.snp.trailing).offset(20)
            $0.width.equalTo(120)
            $0.height.equalTo(45)}
        오피스텔버튼.snp.makeConstraints {
            $0.top.equalTo(아파트버튼)
            $0.leading.equalTo(투룸버튼.snp.trailing).offset(20)
            $0.width.equalTo(100)
            $0.height.equalTo(45)}
        원룸버튼.snp.makeConstraints {
            $0.top.equalTo(아파트버튼.snp.bottom).offset(10)
            $0.leading.equalTo(아파트버튼)
            $0.width.equalTo(75)
            $0.height.equalTo(45)}
        addressLabel.snp.makeConstraints {
            $0.top.equalTo(원룸버튼.snp.bottom).offset(20)
            $0.leading.equalTo(self.view.safeAreaLayoutGuide.snp.leading).offset(23)}
        addressTextField.snp.makeConstraints {
            $0.top.equalTo(addressLabel.snp.bottom).offset(20)
            $0.height.equalTo(30)
            $0.leading.equalTo(self.view.safeAreaLayoutGuide.snp.leading).offset(23)
            $0.trailing.equalTo(self.view.safeAreaLayoutGuide.snp.trailing).offset(-23)
        }
        nextButton.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(-70)
            $0.centerX.equalTo(self.view.snp.centerX)
            $0.width.equalTo(343)
            $0.height.equalTo(56)}
    }
    
    private func setupNavigationBar() {
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationItem.title = "추가하기"
        self.navigationController?.navigationBar.backItem?.title = ""
    }
    
    private func setUpLabel() {
        //*만 빨갛게 바꾸는 콛
        let labels = [nameLabel, tradeLabel,
                      livingLabel, addressLabel]
        for texts in labels {
            let fullText = texts.text ?? ""
            let attribtuedString = NSMutableAttributedString(string: fullText)
            let range = (fullText as NSString).range(of: "*")
            attribtuedString.addAttribute(.foregroundColor, value: UIColor.systemRed, range: range)
            texts.attributedText = attribtuedString}
    }
    
    //MARK: - Actions
    @objc func buttonTapped(_ sender: UIButton) {
        switch sender.currentTitle {
        case "월세", "전세", "매매":
            self.houseViewModel.trade = sender.currentTitle
            sender.setTitleColor(.white, for: .normal)
            sender.backgroundColor = Constant.appColor
            for tradeButton in tradeButtons {
                guard tradeButton.currentTitle == sender.currentTitle else {
                    tradeButton.setTitleColor(.darkGray, for: .normal)
                    tradeButton.backgroundColor = .white
                    continue
                }
            }
        case "아파트", "빌라/투룸+", "오피스텔", "원룸":
            self.houseViewModel.living = sender.currentTitle
            sender.setTitleColor(.white, for: .normal)
            sender.backgroundColor = Constant.appColor
            for livingButton in livingButtons {
                guard livingButton.currentTitle == sender.currentTitle else {
                    livingButton.setTitleColor(.darkGray, for: .normal)
                    livingButton.backgroundColor = .white
                    continue
                }
            }
        default:
            print("디버깅: 디폴트")
        }
    }

    @objc public func nextButtonTapped() {
        let checkVC2 = CheckVC2()
        self.houseViewModel.name = self.nameLabel.text
//        self.houseViewModel.address = 좌표로 변환하는 코드(self.addressTextField.text)
//        checkVC2.viewModel = self.houseViewModel
        checkVC2.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(checkVC2, animated: true)
    }
}
