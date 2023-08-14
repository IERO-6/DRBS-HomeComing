import UIKit
import SnapKit
import Then

//+버튼 눌렀을 때 나오는 화면
class CheckVC1: UIViewController {
    
    //MARK: - Properties
    
    var nameIndex: Int = 0
    
    private let setName = UILabel().then {
        $0.text = "이름*"
    }
    private let setTransactionMethod = UILabel()
    private let setDwellingType = UILabel()
    private let setAddress = UILabel().then {
        $0.text = "주소*"
    }
    private let bottomBorder = UIView().then {
        $0.backgroundColor = .gray
    }
    
    private let nameTextField = UITextField().then {
        $0.placeholder = "이름을 입력해주세요"
        $0.borderStyle = .none
    }
    
    private let monthlyButton = UIButton().then {
        $0.setTitle("월세", for: .normal)
        $0.setTitleColor(.darkGray, for: .normal)
        $0.layer.borderWidth = 1
        $0.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        $0.layer.cornerRadius = 20
    }
    
    private let jeonseButton = UIButton().then {
        $0.setTitle("전세", for: .normal)
        $0.setTitleColor(.darkGray, for: .normal)
        $0.layer.borderWidth = 1
        $0.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        $0.layer.cornerRadius = 20
    }
    
    private let bargainButton = UIButton().then {
        $0.setTitle("매매", for: .normal)
        $0.setTitleColor(.darkGray, for: .normal)
        $0.layer.borderWidth = 1
        $0.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        $0.layer.cornerRadius = 20
    }
    
    private let apartButton = UIButton().then {
        $0.setTitle("아파트", for: .normal)
        $0.setTitleColor(.darkGray, for: .normal)
        $0.layer.borderWidth = 1
        $0.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        $0.layer.cornerRadius = 20
    }
    
    private let twoRoomButton = UIButton().then {
        $0.setTitle("빌라/투룸+", for: .normal)
        $0.setTitleColor(.darkGray, for: .normal)
        $0.layer.borderWidth = 1
        $0.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        $0.layer.cornerRadius = 20
    }
    
    private let officeButton = UIButton().then {
        $0.setTitle("오피스텔", for: .normal)
        $0.setTitleColor(.darkGray, for: .normal)
        $0.layer.borderWidth = 1
        $0.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        $0.layer.cornerRadius = 20
    }
    
    private let oneroomButton = UIButton().then {
        $0.setTitle("원룸", for: .normal)
        $0.setTitleColor(.darkGray, for: .normal)
        $0.layer.borderWidth = 1
        $0.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        $0.layer.cornerRadius = 20
    }
    
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
    
    //viewmodel과 소통
    var viewModel = CheckViewModel()
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupNavigationBar()
        setUpLabel()
        setUpTextField()
        setUpButton()
    }
    
    //MARK: - SetupNavigationBar
    
    func setupNavigationBar() {
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationItem.title = "추가하기"
        self.navigationController?.navigationBar.backItem?.title = ""
    }
    
    //MARK: - SetUpLabel
    
    func setUpLabel() {
        //*만 빨갛게 바꾸는 콛
        let fullText = setName.text ?? ""
        let attribtuedString = NSMutableAttributedString(string: fullText)
        let range = (fullText as NSString).range(of: "*")
        attribtuedString.addAttribute(.foregroundColor, value: UIColor.systemRed, range: range)
        setName.attributedText = attribtuedString
        setTransactionMethod.text = "거래 방식"
        
        setDwellingType.text = "주거 형태*"
        let fullText2 = setDwellingType.text ?? ""
        let attribtuedString2 = NSMutableAttributedString(string: fullText2)
        let range2 = (fullText2 as NSString).range(of: "*")
        attribtuedString2.addAttribute(.foregroundColor, value: UIColor.systemRed, range: range2)
        setDwellingType.attributedText = attribtuedString2
        
        let fullText3 = setAddress.text ?? ""
        let attribtuedString3 = NSMutableAttributedString(string: fullText3)
        let range3 = (fullText3 as NSString).range(of: "*")
        attribtuedString3.addAttribute(.foregroundColor, value: UIColor.systemRed, range: range3)
        setAddress.attributedText = attribtuedString3
        
        view.addSubviews(setName, setTransactionMethod, setDwellingType, setAddress)
        
        setName.snp.makeConstraints {
            $0.top.equalToSuperview().inset(100)
            $0.leading.equalToSuperview().offset(23)
        }
        
        setTransactionMethod.snp.makeConstraints {
            $0.top.equalTo(setName).inset(105)
            $0.leading.equalToSuperview().offset(23)
        }
        
        setDwellingType.snp.makeConstraints {
            $0.top.equalTo(setTransactionMethod).inset(110)
            $0.leading.equalToSuperview().offset(23)
        }
        
        setAddress.snp.makeConstraints {
            $0.top.equalTo(setDwellingType).inset(160)
            $0.leading.equalToSuperview().offset(23)
        }
    }
    
    //MARK: - SetUpTextField
    
    func setUpTextField() {
        view.addSubviews(nameTextField, addressTextField)
        nameTextField.addSubview(bottomBorder)
        
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
        
        addressTextField.addSubview(addressBottomBorder)
        
        addressTextField.snp.makeConstraints {
            $0.top.equalTo(setAddress).inset(42)
            $0.leading.equalToSuperview().offset(23)
        }
        
        //텍스트필드 밑의 줄
        addressBottomBorder.leadingAnchor.constraint(equalTo: addressTextField.leadingAnchor).isActive = true
        addressBottomBorder.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -23).isActive = true
        addressBottomBorder.bottomAnchor.constraint(equalTo: addressTextField.bottomAnchor, constant: 10).isActive = true
        addressBottomBorder.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        addressBottomBorder.translatesAutoresizingMaskIntoConstraints = false
    }
    
    //MARK: - SetUpButton
    
    func setUpButton() {
        view.addSubviews(monthlyButton, jeonseButton, bargainButton, apartButton, twoRoomButton, officeButton, oneroomButton, nextButton)
        
        //월세버튼
        monthlyButton.snp.makeConstraints {
            $0.top.equalTo(setTransactionMethod).inset(42)
            $0.leading.equalToSuperview().offset(23)
            $0.width.equalTo(75)
            $0.height.equalTo(45)
        }
        monthlyButton.addTarget(self, action: #selector(monthlyButtonAction), for: .touchUpInside)
        
        //전세버튼
        jeonseButton.snp.makeConstraints {
            $0.top.equalTo(setTransactionMethod).inset(42)
            $0.leading.equalTo(monthlyButton).offset(95)
            $0.width.equalTo(75)
            $0.height.equalTo(45)
        }
        jeonseButton.addTarget(self, action: #selector(jeonseButtonAction), for: .touchUpInside)
        
        
        //매매버튼
        bargainButton.snp.makeConstraints {
            $0.top.equalTo(setTransactionMethod).inset(42)
            $0.leading.equalTo(jeonseButton).offset(95)
            $0.width.equalTo(75)
            $0.height.equalTo(45)
        }
        bargainButton.addTarget(self, action: #selector(bargainButtonAction), for: .touchUpInside)
        
        
        //아파트버튼
        apartButton.snp.makeConstraints {
            $0.top.equalTo(setDwellingType).inset(42)
            $0.leading.equalToSuperview().offset(23)
            $0.width.equalTo(75)
            $0.height.equalTo(45)
        }
        apartButton.addTarget(self, action: #selector(apartButtonAction), for: .touchUpInside)
        
        //빌라/투룸+
        twoRoomButton.snp.makeConstraints {
            $0.top.equalTo(setDwellingType).inset(42)
            $0.leading.equalTo(apartButton).offset(95)
            $0.width.equalTo(120)
            $0.height.equalTo(45)
        }
        twoRoomButton.addTarget(self, action: #selector(twoRoomButtonAction), for: .touchUpInside)
        
        //오피스텔
        officeButton.snp.makeConstraints {
            $0.top.equalTo(setDwellingType).inset(42)
            $0.leading.equalTo(twoRoomButton).offset(140)
            $0.width.equalTo(100)
            $0.height.equalTo(45)
        }
        officeButton.addTarget(self, action: #selector(officeButtonAction), for: .touchUpInside)
        
        //원룸
        oneroomButton.snp.makeConstraints {
            $0.top.equalTo(apartButton).inset(55)
            $0.leading.equalToSuperview().offset(23)
            $0.width.equalTo(75)
            $0.height.equalTo(45)
        }
        oneroomButton.addTarget(self, action: #selector(oneRoomButtonAction), for: .touchUpInside)
        
        //다음버튼
        nextButton.snp.makeConstraints {
//            make.bottom.equalToSuperview().inset(40)
            $0.bottom.equalToSuperview().multipliedBy(0.97)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(343)
            $0.height.equalTo(56)
        }
        nextButton.addTarget(self, action: #selector(newxtButtonTapped), for: .touchUpInside)
        
    }
    @objc func monthlyButtonAction(sender: UIButton!) {
        viewModel.updateTransactionMethod(.monthly)
        
        sender.backgroundColor = .mainColor
        sender.setTitleColor(.white, for: .normal)
        
        jeonseButton.setTitleColor(.darkGray, for: .normal)
        jeonseButton.backgroundColor = .white
        bargainButton.setTitleColor(.darkGray, for: .normal)
        bargainButton.backgroundColor = .white
    }
    @objc func jeonseButtonAction(sender: UIButton!) {
        viewModel.updateTransactionMethod(.jeonse)
        
        sender.backgroundColor = .mainColor
        sender.setTitleColor(.white, for: .normal)
        
        monthlyButton.setTitleColor(.darkGray, for: .normal)
        monthlyButton.backgroundColor = .white
        bargainButton.setTitleColor(.darkGray, for: .normal)
        bargainButton.backgroundColor = .white
    }
    @objc func bargainButtonAction(sender: UIButton!) {
        viewModel.updateTransactionMethod(.bargain)

        sender.backgroundColor = .mainColor
        sender.setTitleColor(.white, for: .normal)
        
        monthlyButton.setTitleColor(.darkGray, for: .normal)
        monthlyButton.backgroundColor = .white
        jeonseButton.setTitleColor(.darkGray, for: .normal)
        jeonseButton.backgroundColor = .white
    }
    @objc func apartButtonAction(sender: UIButton!) {
        viewModel.updateDwellingType(.apartment)
        
        sender.backgroundColor = .mainColor
        sender.setTitleColor(.white, for: .normal)
        
        twoRoomButton.setTitleColor(.darkGray, for: .normal)
        twoRoomButton.backgroundColor = .white
        officeButton.setTitleColor(.darkGray, for: .normal)
        officeButton.backgroundColor = .white
        oneroomButton.setTitleColor(.darkGray, for: .normal)
        oneroomButton.backgroundColor = .white
        
        nameIndex = 4
    }
    @objc func twoRoomButtonAction(sender: UIButton!) {
        viewModel.updateDwellingType(.twoRoom)

        sender.backgroundColor = .mainColor
        sender.setTitleColor(.white, for: .normal)
        
        apartButton.setTitleColor(.darkGray, for: .normal)
        apartButton.backgroundColor = .white
        officeButton.setTitleColor(.darkGray, for: .normal)
        officeButton.backgroundColor = .white
        oneroomButton.setTitleColor(.darkGray, for: .normal)
        oneroomButton.backgroundColor = .white
        
        nameIndex = 5
    }
    @objc func officeButtonAction(sender: UIButton!) {
        viewModel.updateDwellingType(.office)

        sender.backgroundColor = .mainColor
        sender.setTitleColor(.white, for: .normal)
        
        twoRoomButton.setTitleColor(.darkGray, for: .normal)
        twoRoomButton.backgroundColor = .white
        apartButton.setTitleColor(.darkGray, for: .normal)
        apartButton.backgroundColor = .white
        oneroomButton.setTitleColor(.darkGray, for: .normal)
        oneroomButton.backgroundColor = .white
        
        nameIndex = 6
        print(nameIndex)
    }
    @objc func oneRoomButtonAction(sender: UIButton!) {
        viewModel.updateDwellingType(.oneroom)

        sender.backgroundColor = .mainColor
        sender.setTitleColor(.white, for: .normal)
        
        twoRoomButton.setTitleColor(.darkGray, for: .normal)
        twoRoomButton.backgroundColor = .white
        apartButton.setTitleColor(.darkGray, for: .normal)
        apartButton.backgroundColor = .white
        officeButton.setTitleColor(.darkGray, for: .normal)
        officeButton.backgroundColor = .white
        
        nameIndex = 7
        print(nameIndex)
    }
    @objc public func newxtButtonTapped() {
        let detailTV = DetailTV()
        detailTV.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(detailTV, animated: true)
    }
}
