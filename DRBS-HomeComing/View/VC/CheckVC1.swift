import UIKit
import SnapKit
import Then

//+버튼 눌렀을 때 나오는 화면
class CheckVC1: UIViewController {
    
    //MARK: - Properties
    
    //viewmodel과 소통
    private let viewModel = CheckViewModel()
    
    private let setName = UILabel().then {
        $0.text = "이름*"
    }
    private let 거래방식 = UILabel()
    private let 주거형태 = UILabel()
    private let 주소 = UILabel().then {
        $0.text = "주소*"
    }
    private let bottomBorder = UIView().then {
        $0.backgroundColor = .gray
    }
    
    private let nameTextField = UITextField().then {
        $0.placeholder = "이름을 입력해주세요"
        $0.borderStyle = .none
    }
    
    private let 월세버튼 = UIButton()
    private let 전세버튼 = UIButton()
    private let 매매버튼 = UIButton()
    private let 아파트버튼 = UIButton()
    private let 투룸버튼 = UIButton()
    private let 오피스텔버튼 = UIButton()
    private let 원룸버튼 = UIButton()
    
    private let addressTextField = UITextField().then {
        $0.placeholder = "경기도 수원시 권선구 매실로 70"
        $0.borderStyle = .none
    }
    
    private let addressBottomBorder = UIView().then {
        $0.backgroundColor = .gray
    }
    
    private let nextButton = UIButton().then {
        $0.backgroundColor = .systemBlue
        $0.setTitle("다음", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.layer.cornerRadius = 10
    }
        
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupNavigationBar()
        setUpLabel()
        setUplabelConstraints()
        setUpTextField()
        setUpButton()
        setUpButtonConstraints()
        setupButtonActions()
    }
    
    //MARK: - Helpers
    
    func setupNavigationBar() {
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationItem.title = "추가하기"
        self.navigationController?.navigationBar.backItem?.title = ""
    }
    
    func setUpLabel() {
        //*만 빨갛게 바꾸는 콛
        let fullText = setName.text ?? ""
        let attribtuedString = NSMutableAttributedString(string: fullText)
        let range = (fullText as NSString).range(of: "*")
        attribtuedString.addAttribute(.foregroundColor, value: UIColor.systemRed, range: range)
        setName.attributedText = attribtuedString
        거래방식.text = "거래 방식"
        
        주거형태.text = "주거 형태*"
        let fullText2 = 주거형태.text ?? ""
        let attribtuedString2 = NSMutableAttributedString(string: fullText2)
        let range2 = (fullText2 as NSString).range(of: "*")
        attribtuedString2.addAttribute(.foregroundColor, value: UIColor.systemRed, range: range2)
        주거형태.attributedText = attribtuedString2
        
        let fullText3 = 주소.text ?? ""
        let attribtuedString3 = NSMutableAttributedString(string: fullText3)
        let range3 = (fullText3 as NSString).range(of: "*")
        attribtuedString3.addAttribute(.foregroundColor, value: UIColor.systemRed, range: range3)
        주소.attributedText = attribtuedString3
    }
    
    func setUplabelConstraints() {
        view.addSubviews(setName, 거래방식, 주거형태, 주소)
        
        setName.snp.makeConstraints {
            $0.top.equalToSuperview().inset(100)
            $0.leading.equalToSuperview().offset(23)
        }
        
        거래방식.snp.makeConstraints {
            $0.top.equalTo(setName).inset(105)
            $0.leading.equalToSuperview().offset(23)
        }
        
        주거형태.snp.makeConstraints {
            $0.top.equalTo(거래방식).inset(110)
            $0.leading.equalToSuperview().offset(23)
        }
        
        주소.snp.makeConstraints {
            $0.top.equalTo(주거형태).inset(160)
            $0.leading.equalToSuperview().offset(23)
        }
    }
    
    func setUpTextField() {
        view.addSubviews(nameTextField, addressTextField)
        nameTextField.addSubviews(bottomBorder, addressBottomBorder)
        
        nameTextField.snp.makeConstraints {
            $0.top.equalToSuperview().inset(138)
            $0.leading.equalToSuperview().offset(23)
            
            //텍스트필드 밑의 줄
            bottomBorder.leadingAnchor.constraint(equalTo: nameTextField.leadingAnchor).isActive = true
            bottomBorder.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -23).isActive = true
            bottomBorder.bottomAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 10).isActive = true
            bottomBorder.heightAnchor.constraint(equalToConstant: 1).isActive = true
            bottomBorder.translatesAutoresizingMaskIntoConstraints = false
        }
        
        addressTextField.snp.makeConstraints {
            $0.top.equalTo(주소).inset(42)
            $0.leading.equalToSuperview().offset(23)
        }
        
        //텍스트필드 밑의 줄
        addressBottomBorder.leadingAnchor.constraint(equalTo: addressTextField.leadingAnchor).isActive = true
        addressBottomBorder.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -23).isActive = true
        addressBottomBorder.bottomAnchor.constraint(equalTo: addressTextField.bottomAnchor, constant: 10).isActive = true
        addressBottomBorder.heightAnchor.constraint(equalToConstant: 1).isActive = true
        addressBottomBorder.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setUpButton() {
        configureButton(월세버튼, title: "월세")
        configureButton(아파트버튼, title: "아파트")
        configureButton(전세버튼, title: "전세")
        configureButton(오피스텔버튼, title: "오피스텔")
        configureButton(매매버튼, title: "매매")
        configureButton(원룸버튼, title: "원룸")
        configureButton(투룸버튼, title: "투룸")
    }
    
    func setUpButtonConstraints() {
        
        view.addSubviews(월세버튼, 전세버튼, 매매버튼, 아파트버튼, 투룸버튼, 오피스텔버튼, 원룸버튼, nextButton)
        
        월세버튼.snp.makeConstraints {
            $0.top.equalTo(거래방식).inset(42)
            $0.leading.equalToSuperview().offset(23)
            $0.width.equalTo(75)
            $0.height.equalTo(45)
        }
        
        전세버튼.snp.makeConstraints {
            $0.top.equalTo(거래방식).inset(42)
            $0.leading.equalTo(월세버튼).offset(95)
            $0.width.equalTo(75)
            $0.height.equalTo(45)
        }
        
        매매버튼.snp.makeConstraints {
            $0.top.equalTo(거래방식).inset(42)
            $0.leading.equalTo(전세버튼).offset(95)
            $0.width.equalTo(75)
            $0.height.equalTo(45)
        }
        
        아파트버튼.snp.makeConstraints {
            $0.top.equalTo(주거형태).inset(42)
            $0.leading.equalToSuperview().offset(23)
            $0.width.equalTo(75)
            $0.height.equalTo(45)
        }
        
        투룸버튼.snp.makeConstraints {
            $0.top.equalTo(주거형태).inset(42)
            $0.leading.equalTo(아파트버튼).offset(95)
            $0.width.equalTo(120)
            $0.height.equalTo(45)
        }
        
        오피스텔버튼.snp.makeConstraints {
            $0.top.equalTo(주거형태).inset(42)
            $0.leading.equalTo(투룸버튼).offset(140)
            $0.width.equalTo(100)
            $0.height.equalTo(45)
        }
        
        원룸버튼.snp.makeConstraints {
            $0.top.equalTo(아파트버튼).inset(55)
            $0.leading.equalToSuperview().offset(23)
            $0.width.equalTo(75)
            $0.height.equalTo(45)
        }
        
        nextButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().multipliedBy(0.97)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(343)
            $0.height.equalTo(56)
        }
    }
    
    func configureButton(_ button: UIButton, title: String) {
        button.setTitle(title, for: .normal)
        button.setTitleColor(.darkGray, for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        button.layer.cornerRadius = 20
    }
    
    //MARK: - Actions
    
    private func setupButtonActions() {
        월세버튼.addTarget(self, action: #selector(월세ButtonAction(sender:)), for: .touchUpInside)
        전세버튼.addTarget(self, action: #selector(전세ButtonAction(sender:)), for: .touchUpInside)
        매매버튼.addTarget(self, action: #selector(매매ButtonAction(sender:)), for: .touchUpInside)
        아파트버튼.addTarget(self, action: #selector(아파트ButtonAction(sender:)), for: .touchUpInside)
        투룸버튼.addTarget(self, action: #selector(투룸ButtonAction(sender:)), for: .touchUpInside)
        오피스텔버튼.addTarget(self, action: #selector(오피스텔ButtonAction(sender:)), for: .touchUpInside)
        원룸버튼.addTarget(self, action: #selector(원룸ButtonAction(sender:)), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
    }
    
    @objc func 월세ButtonAction(sender: UIButton!) {
        viewModel.handleTransactionButtonAction(sender, method: .월세)
    }
    @objc func 전세ButtonAction(sender: UIButton!) {
        viewModel.handleTransactionButtonAction(sender, method: .전세)
    }
    @objc func 매매ButtonAction(sender: UIButton!) {
        viewModel.handleTransactionButtonAction(sender, method: .매매)
    }
    @objc func 아파트ButtonAction(sender: UIButton!) {
        viewModel.handleDwellingTypeButtonAction(sender, type: .아파트)
    }
    @objc func 투룸ButtonAction(sender: UIButton!) {
        viewModel.handleDwellingTypeButtonAction(sender, type: .투룸)
    }
    @objc func 오피스텔ButtonAction(sender: UIButton!) {
        viewModel.handleDwellingTypeButtonAction(sender, type: .오피스텔)
    }
    @objc func 원룸ButtonAction(sender: UIButton!) {
        viewModel.handleDwellingTypeButtonAction(sender, type: .원룸)
    }
    
    @objc public func nextButtonTapped() {
        let checkVC2 = CheckVC2()
        checkVC2.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(checkVC2, animated: true)
    }
}
