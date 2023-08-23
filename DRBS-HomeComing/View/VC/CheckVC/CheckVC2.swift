import UIKit
import Then
import SnapKit

class CheckVC2: UIViewController {
    
    //MARK: - Properties
    private let houseViewModel = HouseViewModel()
    private let checkListUIView = CheckListUIView()
    private lazy var scrollView = UIScrollView(frame: self.view.frame).then {
        $0.backgroundColor = .white
        $0.showsVerticalScrollIndicator = false}
    private lazy var backView = UIView().then {$0.backgroundColor = .white}
    private let 보증금 = UILabel().then {
        $0.text = "보증금*"
        $0.font = UIFont(name: Constant.font, size: 16)}
    private let 보증금TextField = UITextField().then {
        $0.placeholder = "000 "
        $0.textAlignment = .right
        let label = UILabel()
        label.text = " 만원"
        label.sizeToFit()
        $0.rightView = label
        $0.rightViewMode = .always
        $0.onlyNumbers = true}
    private let 월세 = UILabel().then {
        $0.text = "월세*"
        $0.font = UIFont(name: Constant.font, size: 16)}
    private let 월세TextField = UITextField().then {
        $0.placeholder = "00"
        $0.textAlignment = .right
        let label = UILabel()
        label.text = " 만원"
        label.sizeToFit()
        $0.rightView = label
        $0.rightViewMode = .always
        $0.onlyNumbers = true}
    private let 관리비 = UILabel().then {$0.text = "관리비" }
    var 관리비TextField = UITextField().then {
        $0.placeholder = "0"
        $0.textAlignment = .right
        let label = UILabel()
        label.text = " 만원"
        label.sizeToFit()
        $0.rightView = label
        $0.rightViewMode = .always
        $0.onlyNumbers = true}
    private let 관리비미포함 = UILabel().then {$0.text = "관리비 미포함 목록"}
    private lazy var 전기버튼 = UIButton().then {
        $0.setTitle("전기", for: .normal)
        $0.setTitleColor(UIColor.darkGray, for: .normal)
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.systemGray4.cgColor
        $0.layer.cornerRadius = 20
        $0.addTarget(self, action: #selector(vc2buttonTapped(_:)), for: .touchUpInside)}
    private lazy var 가스버튼 = UIButton().then {
        $0.setTitle("가스", for: .normal)
        $0.setTitleColor(UIColor.darkGray, for: .normal)
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.systemGray4.cgColor
        $0.layer.cornerRadius = 20
        $0.addTarget(self, action: #selector(vc2buttonTapped(_:)), for: .touchUpInside)}
    private lazy var 수도버튼 = UIButton().then {
        $0.setTitle("수도", for: .normal)
        $0.setTitleColor(UIColor.darkGray, for: .normal)
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.systemGray4.cgColor
        $0.layer.cornerRadius = 20
        $0.addTarget(self, action: #selector(vc2buttonTapped(_:)), for: .touchUpInside)}
    private lazy var 인터넷버튼 = UIButton().then {
        $0.setTitle("인터넷", for: .normal)
        $0.setTitleColor(UIColor.darkGray, for: .normal)
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.systemGray4.cgColor
        $0.layer.cornerRadius = 20
        $0.addTarget(self, action: #selector(vc2buttonTapped(_:)), for: .touchUpInside)}
    private lazy var TV버튼 = UIButton().then {
        $0.setTitle("TV", for: .normal)
        $0.setTitleColor(UIColor.darkGray, for: .normal)
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.systemGray4.cgColor
        $0.layer.cornerRadius = 20
        $0.addTarget(self, action: #selector(vc2buttonTapped(_:)), for: .touchUpInside)}
    private lazy var 기타버튼 = UIButton().then {
        $0.setTitle("기타", for: .normal)
        $0.setTitleColor(UIColor.darkGray, for: .normal)
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.systemGray4.cgColor
        $0.layer.cornerRadius = 20
        $0.addTarget(self, action: #selector(vc2buttonTapped(_:)), for: .touchUpInside)}
    private lazy var 관리비버튼 = [전기버튼, 가스버튼, 수도버튼, 인터넷버튼, TV버튼, 기타버튼]
    private let separatorLine = UIView.createSeparatorLine()
    private let separatorLine2 = UIView.createSeparatorLine()
    private let 면적 = UILabel().then {$0.text = "면적"}
    private let 면적TextField = UITextField().then {
        $0.placeholder = "면적을 입력해주세요"
        let label = UILabel()
        label.text = "㎡"
        label.sizeToFit()
        $0.rightView = label
        $0.rightViewMode = .always
        $0.onlyNumbers = true}
    private let 입주가능일 = UILabel().then {
        $0.text = "입주 가능일"}
    private let 입주TextField = UITextField().then {$0.placeholder = ""}
    private let 계약기간 = UILabel().then {$0.text = "계약기간"}
    private let 계약기간TextField = UITextField().then {
        $0.placeholder = "0"
        let label = UILabel()
        label.text = " 년"
        label.sizeToFit()
        $0.rightView = label
        $0.rightViewMode = .always}
    private let checkListLabel = UILabel().then {
        $0.text = "체크 리스트"
        $0.font = UIFont(name: Constant.font, size: 18)}
    private let recodeLabel = UILabel().then {
        $0.text = "기록"
        $0.font = UIFont(name: Constant.font, size: 18)}
    private let picker = UIImagePickerController()
    private let galleryImageView = UIImageView().then {
        let cameraImage = UIImage(systemName: "camera")
        let size = CGSize(width: 20, height: 20)
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        cameraImage?.draw(in: CGRect(origin: .zero, size: size))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        $0.image = UIImage(systemName: "camera")
        $0.tintColor = .black
        $0.layer.cornerRadius = 10
        $0.backgroundColor = UIColor.systemGray6}
    private let memoTextView = UITextView().then {
        $0.textContainerInset = UIEdgeInsets(top: 5, left: 5, bottom: 0, right: 0)
        $0.font = UIFont.systemFont(ofSize: 13)
        $0.backgroundColor = UIColor.systemGray6
        $0.isScrollEnabled = true
        $0.isEditable = true
        $0.textColor = .black
        $0.layer.cornerRadius = 10}
    private let completionButton = UIButton().then {
        $0.setTitle("완료", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.layer.cornerRadius = 10
        $0.backgroundColor = Constant.appColor}
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        addScrollView()
        setupNavigationBar()
        configureUI()
        configureUI2()
        configureUI3()
        setUpLabel()
        initPicker()
        setupImageViewGesture()
    }
    override func viewDidLayoutSubviews() {
        보증금TextField.layer.addBottomLayer()
        월세TextField.layer.addBottomLayer()
        관리비TextField.layer.addBottomLayer()
        면적TextField.layer.addBottomLayer()
        입주TextField.layer.addBottomLayer()
        계약기간TextField.layer.addBottomLayer()
        let contentHeight = completionButton.frame.maxY + 20    //맨 밑이 어디까지인지 알 수 있게 해준다
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: contentHeight)}
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.backView.endEditing(true)
    }
    
    //MARK: - Helpers
    private func addScrollView() {
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()}
        scrollView.addSubviews(backView, 보증금TextField, 월세TextField, 관리비TextField, 면적TextField, 입주TextField, 계약기간TextField, memoTextView)
        backView.snp.makeConstraints {
            $0.top.equalTo(scrollView)
            $0.left.right.bottom.equalTo(view) // 가로 방향에 대해 화면 너비와 동일하게 설정
            $0.width.equalTo(view) // backView의 너비를 화면 너비와 동일하게 설정
        }}
    private func setupNavigationBar() {
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationItem.title = "추가하기"
        self.navigationController?.navigationBar.tintColor = .black
    }
    private func configureUI() {
        view.backgroundColor = .white
        backView.addSubviews(보증금, 월세, 관리비, 관리비미포함, 전기버튼, 가스버튼, 수도버튼, 인터넷버튼, TV버튼, 기타버튼, separatorLine)
        보증금.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.leading.equalToSuperview().offset(20)}
        보증금TextField.snp.makeConstraints {
            $0.top.equalTo(보증금.snp.bottom).offset(10)
            $0.leading.equalTo(self.view.safeAreaLayoutGuide.snp.leading).offset(23)
            $0.trailing.equalTo(self.view.safeAreaLayoutGuide.snp.trailing).offset(-23)
            $0.height.equalTo(30)}
        월세.snp.makeConstraints {
            $0.top.equalTo(보증금TextField.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(20)}
        월세TextField.snp.makeConstraints {
            $0.top.equalTo(월세.snp.bottom).offset(10)
            $0.leading.equalTo(self.view.safeAreaLayoutGuide.snp.leading).offset(23)
            $0.trailing.equalTo(self.view.safeAreaLayoutGuide.snp.trailing).offset(-23)
            $0.height.equalTo(30)}
        관리비.snp.makeConstraints {
            $0.top.equalTo(월세TextField.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(20)}
        관리비TextField.snp.makeConstraints {
            $0.top.equalTo(관리비.snp.bottom).offset(10)
            $0.leading.equalTo(self.view.safeAreaLayoutGuide.snp.leading).offset(23)
            $0.trailing.equalTo(self.view.safeAreaLayoutGuide.snp.trailing).offset(-23)
            $0.height.equalTo(30)}
        관리비미포함.snp.makeConstraints {
            $0.top.equalTo(관리비TextField.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(20)}
        전기버튼.snp.makeConstraints {
            $0.top.equalTo(관리비미포함.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(23)
            $0.width.equalTo(75)
            $0.height.equalTo(45)}
        가스버튼.snp.makeConstraints {
            $0.top.equalTo(전기버튼)
            $0.leading.equalTo(전기버튼.snp.trailing).offset(10)
            $0.width.equalTo(75)
            $0.height.equalTo(45)}
        수도버튼.snp.makeConstraints {
            $0.top.equalTo(전기버튼)
            $0.leading.equalTo(가스버튼.snp.trailing).offset(10)
            $0.width.equalTo(75)
            $0.height.equalTo(45)}
        인터넷버튼.snp.makeConstraints {
            $0.top.equalTo(전기버튼)
            $0.leading.equalTo(수도버튼.snp.trailing).offset(10)
            $0.width.equalTo(75)
            $0.height.equalTo(45)}
        TV버튼.snp.makeConstraints {
            $0.top.equalTo(전기버튼.snp.bottom).offset(10)
            $0.leading.equalTo(전기버튼)
            $0.width.equalTo(75)
            $0.height.equalTo(45)}
        기타버튼.snp.makeConstraints {
            $0.top.equalTo(TV버튼)
            $0.leading.equalTo(TV버튼.snp.trailing).offset(10)
            $0.width.equalTo(75)
            $0.height.equalTo(45)}
        separatorLine.snp.makeConstraints {
            $0.top.equalTo(기타버튼.snp.bottom).offset(30)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(8)}
    }
    private func configureUI2() {
        view.backgroundColor = .white
        backView.addSubviews(면적, 입주가능일, 계약기간, separatorLine2)
        면적.snp.makeConstraints {
            $0.top.equalTo(separatorLine.snp.bottom).offset(30)
            $0.leading.equalToSuperview().offset(20)}
        면적TextField.snp.makeConstraints {
            $0.top.equalTo(면적.snp.bottom).offset(10)
            $0.leading.equalTo(self.view.safeAreaLayoutGuide.snp.leading).offset(23)
            $0.trailing.equalTo(self.view.safeAreaLayoutGuide.snp.trailing).offset(-23)
            $0.height.equalTo(30)}
        입주가능일.snp.makeConstraints {
            $0.top.equalTo(면적TextField.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(20)}
        입주TextField.snp.makeConstraints {
            $0.top.equalTo(입주가능일.snp.bottom).offset(10)
            $0.leading.equalTo(self.view.safeAreaLayoutGuide.snp.leading).offset(23)
            $0.trailing.equalTo(self.view.safeAreaLayoutGuide.snp.trailing).offset(-23)
            $0.height.equalTo(30)}
        계약기간.snp.makeConstraints {
            $0.top.equalTo(입주TextField.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(20)}
        계약기간TextField.snp.makeConstraints {
            $0.top.equalTo(계약기간.snp.bottom).offset(10)
            $0.leading.equalTo(self.view.safeAreaLayoutGuide.snp.leading).offset(23)
            $0.trailing.equalTo(self.view.safeAreaLayoutGuide.snp.trailing).offset(-23)
            $0.height.equalTo(30)}
        separatorLine2.snp.makeConstraints {
            $0.top.equalTo(계약기간TextField.snp.bottom).offset(30)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(8)}
    }
    private func configureUI3() {
        view.backgroundColor = .white
        backView.addSubviews(checkListLabel, recodeLabel, completionButton, checkListUIView, galleryImageView)
        checkListLabel.snp.makeConstraints {
            $0.top.equalTo(separatorLine2.snp.bottom).offset(30)
            $0.leading.equalToSuperview().offset(20)}
        checkListUIView.snp.makeConstraints {
            $0.top.equalTo(checkListLabel.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(500)}
        recodeLabel.snp.makeConstraints {
            $0.top.equalTo(checkListLabel.snp.bottom).offset(550)
            $0.leading.equalTo(checkListLabel)}
        galleryImageView.snp.makeConstraints {
            $0.top.equalTo(recodeLabel.snp.bottom).offset(20)
            $0.leading.equalTo(checkListLabel)
            $0.height.equalTo(140)
            $0.width.equalTo(140)}
        memoTextView.snp.makeConstraints {
            $0.top.equalTo(galleryImageView.snp.bottom).offset(20)
            $0.leading.equalTo(self.view.safeAreaLayoutGuide.snp.leading).offset(20)
            $0.trailing.equalTo(self.view.safeAreaLayoutGuide.snp.trailing).offset(-20)
            $0.height.equalTo(200)}
        completionButton.snp.makeConstraints {
            $0.top.equalTo(memoTextView.snp.bottom).offset(30)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(56)}
    }
    private func setUpLabel() {
        //*만 빨갛게 바꾸는 콛
        let labels = [보증금, 월세]
        for texts in labels {
            let fullText = texts.text ?? ""
            let attribtuedString = NSMutableAttributedString(string: fullText)
            let range = (fullText as NSString).range(of: "*")
            attribtuedString.addAttribute(.foregroundColor, value: UIColor.systemRed, range: range)
            texts.attributedText = attribtuedString}}
    private func initPicker() {
        self.picker.delegate = self
        self.picker.sourceType = .photoLibrary
        self.picker.modalPresentationStyle = .fullScreen}
    private func setupImageViewGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(openLibrary))
        galleryImageView.addGestureRecognizer(tapGesture)
        galleryImageView.isUserInteractionEnabled = true}
    
    //MARK: - Actions
    @objc func vc2buttonTapped(_ sender: UIButton) {
        switch sender.currentTitle {
        case "전기", "가스", "수도", "인터넷", "TV", "기타":
//            self.houseViewModel.trade = sender.currentTitle
            sender.setTitleColor(.white, for: .normal)
            sender.backgroundColor = Constant.appColor
            for 버튼 in 관리비버튼 {
                guard 버튼.currentTitle == sender.currentTitle else {
                    버튼.setTitleColor(.darkGray, for: .normal)
                    버튼.backgroundColor = .white
                    continue
                }
            }
        default:
            print("디버깅: 디폴트")
        }
    }
    @objc func openLibrary() {self.present(picker, animated: true, completion: nil)}
}

//MARK: - Extensions
extension UIView {
    static func createSeparatorLine() -> UIView {
        let separator = UIView()
        separator.backgroundColor = .systemGray5
        return separator}
}
extension CheckVC2: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.delegate = self}
}
extension CheckVC2: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.dismiss(animated: false, completion: {
                DispatchQueue.main.async {
                    self.galleryImageView.image = image}
            })
        }
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)}
    

}

extension UITextField: UITextFieldDelegate {
    
    @IBInspectable var onlyNumbers: Bool {
        get {
            return delegate is UITextField
        }
        set {
            if newValue {
                delegate = self}
        }
    }
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard onlyNumbers else { return true }
        let allowedCharacters = CharacterSet.decimalDigits.union(CharacterSet(charactersIn: "\u{8}"))
        let characterSet = CharacterSet(charactersIn: string)
        if !allowedCharacters.isSuperset(of: characterSet) {return false}
        let newString = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        return newString.count <= 6 // 새로운 문자열의 길이가 6자리 이하인지 확인
    }
}
