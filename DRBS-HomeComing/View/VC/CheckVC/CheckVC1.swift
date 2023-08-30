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
        $0.font = UIFont(name: Constant.font, size: 16)
    }
    
    private lazy var nameTextField = UITextField().then {
        $0.placeholder = "이름을 입력해주세요"
        $0.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)
    }
    
    private let tradeLabel = UILabel().then {
        $0.text = "거래 방식*"
        $0.font = UIFont(name: Constant.font, size: 16)
        $0.textColor = .darkGray
    }
    
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
        $0.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
    }
    
    private lazy var 매매버튼 = UIButton().then {
        $0.setTitle("매매", for: .normal)
        $0.setTitleColor(UIColor.darkGray, for: .normal)
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.systemGray4.cgColor
        $0.layer.cornerRadius = 20
        $0.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
    }
    
    private lazy var tradeButtons = [월세버튼, 전세버튼, 매매버튼]
    
    private let livingLabel = UILabel().then {
        $0.text = "주거 형태*"
        $0.font = UIFont(name: Constant.font, size: 16)
        $0.textColor = .darkGray
    }
    
    private lazy var 아파트버튼 = UIButton().then {
        $0.setTitle("아파트", for: .normal)
        $0.setTitleColor(UIColor.darkGray, for: .normal)
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.systemGray4.cgColor
        $0.layer.cornerRadius = 20
        $0.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
    }
    
    private lazy var 투룸버튼 = UIButton().then {
        $0.setTitle("빌라/투룸+", for: .normal)
        $0.setTitleColor(UIColor.darkGray, for: .normal)
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.systemGray4.cgColor
        $0.layer.cornerRadius = 20
        $0.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
    }
    
    private lazy var 오피스텔버튼 = UIButton().then {
        $0.setTitle("오피스텔", for: .normal)
        $0.setTitleColor(UIColor.darkGray, for: .normal)
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.systemGray4.cgColor
        $0.layer.cornerRadius = 20
        $0.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
    }
    
    private lazy var 원룸버튼 = UIButton().then {
        $0.setTitle("원룸", for: .normal)
        $0.setTitleColor(UIColor.darkGray, for: .normal)
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.systemGray4.cgColor
        $0.layer.cornerRadius = 20
        $0.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
    }
    
    private lazy var livingButtons = [아파트버튼, 투룸버튼, 오피스텔버튼, 원룸버튼]
    private let addressLabel = UILabel().then { $0.text = "주소*" }
    private lazy var addressTextField = UITextField().then {
        $0.placeholder = "경기도 수원시 권선구 매실로 70"
        $0.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)
    }
    
    private lazy var nextButton = UIButton().then {
        $0.backgroundColor = Constant.appColor
        $0.setTitle("다음", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.layer.cornerRadius = 10
        $0.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
    }
        
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        setUpLabel()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNav()
        nameTextField.becomeFirstResponder()
    }
    
    override func viewDidLayoutSubviews() {
        addressTextField.layer.addBottomLayer()
        nameTextField.layer.addBottomLayer()
    }
    
    //MARK: - Helpers
    
    private func configureUI() {
        nameTextField.delegate = self
        addressTextField.delegate = self
        view.backgroundColor = .white
        view.addSubviews(nameLabel, nameTextField, tradeLabel,
                         월세버튼, 전세버튼, 매매버튼, livingLabel,
                         아파트버튼, 투룸버튼, 오피스텔버튼, 원룸버튼,
                        addressLabel, addressTextField, nextButton)
        
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(20)
            $0.leading.equalTo(self.view.safeAreaLayoutGuide.snp.leading).offset(23)
        }
        
        nameTextField.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(10)
            $0.height.equalTo(30)
            $0.leading.equalTo(self.view.safeAreaLayoutGuide.snp.leading).offset(23)
            $0.trailing.equalTo(self.view.safeAreaLayoutGuide.snp.trailing).offset(-23)
        }
        
        tradeLabel.snp.makeConstraints {
            $0.top.equalTo(nameTextField.snp.bottom).offset(20)
            $0.leading.equalTo(self.view.safeAreaLayoutGuide.snp.leading).offset(23)
        }
        
        월세버튼.snp.makeConstraints {
            $0.top.equalTo(tradeLabel.snp.bottom).offset(20)
            $0.leading.equalTo(self.view.safeAreaLayoutGuide.snp.leading).offset(23)
            $0.width.equalTo(75)
            $0.height.equalTo(45)
        }
        
        전세버튼.snp.makeConstraints {
            $0.top.equalTo(월세버튼)
            $0.leading.equalTo(월세버튼.snp.trailing).offset(20)
            $0.width.equalTo(월세버튼)
            $0.height.equalTo(월세버튼)
        }
        
        매매버튼.snp.makeConstraints {
            $0.top.equalTo(월세버튼)
            $0.leading.equalTo(전세버튼.snp.trailing).offset(20)
            $0.width.equalTo(월세버튼)
            $0.height.equalTo(월세버튼)
        }
        
        livingLabel.snp.makeConstraints {
            $0.top.equalTo(월세버튼.snp.bottom).offset(20)
            $0.leading.equalTo(self.view.safeAreaLayoutGuide.snp.leading).offset(23)
        }
        
        아파트버튼.snp.makeConstraints {
            $0.top.equalTo(livingLabel.snp.bottom).offset(20)
            $0.leading.equalTo(self.view.safeAreaLayoutGuide.snp.leading).offset(23)
            $0.width.equalTo(75)
            $0.height.equalTo(45)
        }
        
        투룸버튼.snp.makeConstraints {
            $0.top.equalTo(아파트버튼)
            $0.leading.equalTo(아파트버튼.snp.trailing).offset(20)
            $0.width.equalTo(120)
            $0.height.equalTo(45)
        }
        
        오피스텔버튼.snp.makeConstraints {
            $0.top.equalTo(아파트버튼)
            $0.leading.equalTo(투룸버튼.snp.trailing).offset(20)
            $0.width.equalTo(100)
            $0.height.equalTo(45)
        }
        
        원룸버튼.snp.makeConstraints {
            $0.top.equalTo(아파트버튼.snp.bottom).offset(10)
            $0.leading.equalTo(아파트버튼)
            $0.width.equalTo(75)
            $0.height.equalTo(45)
        }
        
        addressLabel.snp.makeConstraints {
            $0.top.equalTo(원룸버튼.snp.bottom).offset(20)
            $0.leading.equalTo(self.view.safeAreaLayoutGuide.snp.leading).offset(23)
        }
        
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
            $0.height.equalTo(56)
        }
    }
    
    private func configureNav() {
        navigationItem.title = "추가하기"
        
        let appearance = UINavigationBarAppearance().then {
            $0.configureWithOpaqueBackground()
            $0.backgroundColor = .white
            $0.shadowColor = nil
        }
        
        navigationController?.navigationBar.topItem?.title = ""
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    private func setUpLabel() {
        //*만 빨갛게 바꾸는 코드
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
            self.houseViewModel.tradingType = sender.currentTitle
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
            self.houseViewModel.livingType = sender.currentTitle
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
        guard let name = self.nameTextField.text,
              let address = self.addressTextField.text,
            !name.isEmpty && !address.isEmpty && self.houseViewModel.tradingType != nil && self.houseViewModel.livingType != nil else {
            DispatchQueue.main.async {
                let alert = UIAlertController(title: "항목 입력을 완료해주세요.", message: "모든 항목이 입력되지 않았습니다.", preferredStyle: .alert)
                let confirm = UIAlertAction(title: "확인", style: .default) { _ in
                }
                alert.addAction(confirm)
                self.present(alert, animated: true)
            }
            return
        }
        
        self.houseViewModel.switchAddressToCLCoordinate2D(address: self.addressTextField.text ?? "") { coordinate, error in
            if let error = error {
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "주소 형식이 맞지 않습니다.", message: "주소를 다시 입력해주세요.", preferredStyle: .alert)
                    let confirm = UIAlertAction(title: "확인", style: .default) { _ in
                    }
                    alert.addAction(confirm)
                    self.present(alert, animated: true)
                }
                print("Error geocoding address: \(error.localizedDescription)")
            } else if let coordinate = coordinate {
//                self.houseViewModel.address = coordinate
                self.houseViewModel.address = self.addressTextField.text
                self.houseViewModel.latitude = coordinate.latitude
                self.houseViewModel.longitude = coordinate.longitude
                self.houseViewModel.name = self.nameTextField.text
                let checkVC2 = CheckVC2()
                checkVC2.houseViewModel = self.houseViewModel
                self.navigationController?.pushViewController(checkVC2, animated: true)
            }
        }
        
    }
    
    @objc func textFieldEditingChanged(_ textField: UITextField) {
        if textField.text?.count == 1 {
            if textField.text?.first == " " {
                textField.text = ""
                return
            }
        }
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if addressTextField.isFirstResponder {
            if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
                if self.view.frame.origin.y == 0 {
                    self.view.frame.origin.y -= keyboardSize.height / 5
                }
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if addressTextField.isFirstResponder {
            if self.view.frame.origin.y != 0 {
                self.view.frame.origin.y = 0
            }
        }
    }

    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}

//MARK: - UITextFieldDelegate

extension CheckVC1: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == nameTextField {
            let currentText = textField.text ?? ""
            guard let stringRange = Range(range, in: currentText) else { return false }
            let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
            return updatedText.count <= 10
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == nameTextField {
            textField.resignFirstResponder()
        } else if textField == addressTextField {
            textField.resignFirstResponder()
        }
        return true
    }
}
