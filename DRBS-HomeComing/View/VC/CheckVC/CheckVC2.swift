import UIKit
import Then
import SnapKit
import PhotosUI

protocol CalendarDelegate: AnyObject {
    func dateSelected(date: Date)
}

final class CheckVC2: UIViewController {
    
    //MARK: - Properties
    var houseViewModel = HouseViewModel()
    private let checkListUIView = CheckListUIView()
    private lazy var scrollView = UIScrollView(frame: self.view.frame).then {
        $0.backgroundColor = .white
        $0.showsVerticalScrollIndicator = false}
    private lazy var backView = UIView().then {$0.backgroundColor = .white}
    private let 보증금 = UILabel().then {
        $0.text = "보증금*"
        $0.font = UIFont(name: Constant.font, size: 16)
    }
    private let 보증금TextField = UITextField().then {
        $0.placeholder = "000 "
        $0.textAlignment = .right
        let label = UILabel()
        label.text = " 만원"
        label.sizeToFit()
        $0.rightView = label
        $0.rightViewMode = .always
        $0.keyboardType = .numbersAndPunctuation
    }
    
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
        $0.keyboardType = .numbersAndPunctuation
    }
    private let 관리비 = UILabel().then {$0.text = "관리비" }
    var 관리비TextField = UITextField().then {
        $0.placeholder = "0"
        $0.textAlignment = .right
        let label = UILabel()
        label.text = " 만원"
        label.sizeToFit()
        $0.rightView = label
        $0.rightViewMode = .always
        $0.keyboardType = .numbersAndPunctuation
    }
    private let 관리비미포함 = UILabel().then {$0.text = "관리비 미포함 목록"}
    private lazy var 전기버튼 = UIButton().then {
        $0.setTitle("전기", for: .normal)
        $0.setTitleColor(UIColor.darkGray, for: .normal)
        $0.backgroundColor = .white
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.systemGray4.cgColor
        $0.layer.cornerRadius = 20
        $0.addTarget(self, action: #selector(vc2buttonTapped(_:)), for: .touchUpInside)}
    private lazy var 가스버튼 = UIButton().then {
        $0.setTitle("가스", for: .normal)
        $0.setTitleColor(UIColor.darkGray, for: .normal)
        $0.backgroundColor = .white
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.systemGray4.cgColor
        $0.layer.cornerRadius = 20
        $0.addTarget(self, action: #selector(vc2buttonTapped(_:)), for: .touchUpInside)}
    private lazy var 수도버튼 = UIButton().then {
        $0.setTitle("수도", for: .normal)
        $0.setTitleColor(UIColor.darkGray, for: .normal)
        $0.backgroundColor = .white
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.systemGray4.cgColor
        $0.layer.cornerRadius = 20
        $0.addTarget(self, action: #selector(vc2buttonTapped(_:)), for: .touchUpInside)}
    private lazy var 인터넷버튼 = UIButton().then {
        $0.setTitle("인터넷", for: .normal)
        $0.setTitleColor(UIColor.darkGray, for: .normal)
        $0.backgroundColor = .white
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.systemGray4.cgColor
        $0.layer.cornerRadius = 20
        $0.addTarget(self, action: #selector(vc2buttonTapped(_:)), for: .touchUpInside)}
    private lazy var TV버튼 = UIButton().then {
        $0.setTitle("TV", for: .normal)
        $0.setTitleColor(UIColor.darkGray, for: .normal)
        $0.backgroundColor = .white
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.systemGray4.cgColor
        $0.layer.cornerRadius = 20
        $0.addTarget(self, action: #selector(vc2buttonTapped(_:)), for: .touchUpInside)}
    private lazy var 기타버튼 = UIButton().then {
        $0.setTitle("기타", for: .normal)
        $0.setTitleColor(UIColor.darkGray, for: .normal)
        $0.backgroundColor = .white
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.systemGray4.cgColor
        $0.layer.cornerRadius = 20
        $0.addTarget(self, action: #selector(vc2buttonTapped(_:)), for: .touchUpInside)}
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
        $0.keyboardType = .numbersAndPunctuation
    }
    private let 입주가능일 = UILabel().then {
        $0.text = "입주 가능일"}
    private lazy var 입주가능일button = UIButton().then {
        $0.setTitle("e) 23.08.28", for: .normal)
        $0.setTitleColor(UIColor.systemGray4, for: .normal)
        $0.contentHorizontalAlignment = .left
        $0.addTarget(self, action: #selector(textFieldTapped), for: .touchUpInside)
    }
    private let 계약기간 = UILabel().then {$0.text = "계약기간"}
    private let 계약기간TextField = UITextField().then {
        $0.placeholder = "0"
        let label = UILabel()
        label.text = " 년"
        label.sizeToFit()
        $0.rightView = label
        $0.rightViewMode = .always
        $0.keyboardType = .numbersAndPunctuation
    }
    private let checkListLabel = UILabel().then {
        $0.text = "체크 리스트"
        $0.font = UIFont(name: Constant.font, size: 18)}
    private let recodeLabel = UILabel().then {
        $0.text = "기록"
        $0.font = UIFont(name: Constant.font, size: 18)}
    //이미지뷰를 담을 스크롤뷰를 생성
    private lazy var imageScrollView = UIScrollView(frame: self.view.frame).then {
        $0.isPagingEnabled = true
        $0.showsHorizontalScrollIndicator = false
        $0.isScrollEnabled = true
    }
    private var picker: PHPickerViewController!
    private let galleryImageView = UIImageView().then {
        $0.frame = CGRect(x: 0, y: 0, width: 85, height: 65)
        $0.image = UIImage(systemName: "camera")
        $0.tintColor = .black
        $0.contentMode = .scaleAspectFit
        $0.layer.cornerRadius = 10
        $0.clipsToBounds = true
        $0.backgroundColor = UIColor.systemGray6
    }
    private let secondGalleryImageView = UIImageView().then {
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 10}
    private let thirdGalleryImageView = UIImageView().then {
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 10}
    private let fourthGalleryImageView = UIImageView().then {
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 10}
    private let fifthGalleryImageView = UIImageView().then {
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 10}
    private lazy var imageViewArray: [UIImageView] = [galleryImageView, secondGalleryImageView, thirdGalleryImageView, fourthGalleryImageView, fifthGalleryImageView]     //이미지뷰가 초기화되기전에 초기화되면 에러가 발생할 수 있어 지연저장속성 사용
    private let memoTextView = UITextView().then {
        $0.textContainerInset = UIEdgeInsets(top: 5, left: 5, bottom: 0, right: 0)
        $0.font = UIFont.systemFont(ofSize: 13)
        $0.backgroundColor = UIColor.systemGray6
        $0.isScrollEnabled = true
        $0.isEditable = true
        $0.textColor = .black
        $0.layer.cornerRadius = 10}
    private lazy var completionButton = UIButton().then {
        $0.setTitle("완료", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.layer.cornerRadius = 10
        $0.backgroundColor = Constant.appColor
        $0.addTarget(self, action: #selector(completionButtonTapped), for: .touchUpInside)
    }
    
    private lazy var 관리비버튼 = [전기버튼, 가스버튼, 수도버튼, 인터넷버튼, TV버튼, 기타버튼]
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        addScrollView()
        configureUI()
        configureUI2()
        configureUI3()
        setUpKeyBoard()
        setUpLabel()
        setupNavigationBar()
        initPicker()
        setupImageViewGesture()
        보증금TextField.delegate = self
        월세TextField.delegate = self
        관리비TextField.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    override func viewDidLayoutSubviews() {
        보증금TextField.layer.addBottomLayer()
        월세TextField.layer.addBottomLayer()
        관리비TextField.layer.addBottomLayer()
        면적TextField.layer.addBottomLayer()
        입주가능일button.layer.addBottomLayer()
        계약기간TextField.layer.addBottomLayer()
        let contentHeight = completionButton.frame.maxY + 20
        let contentWidth = 140 * imageViewArray.count + 13 * (imageViewArray.count - 2)
        imageScrollView.contentSize = CGSize(width: contentWidth, height: 140)
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: contentHeight)
    }
    
    //MARK: - Helpers
    private func addScrollView() {
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()}
        scrollView.addSubviews(backView, 보증금TextField, 월세TextField, 관리비TextField, 면적TextField, 입주가능일button, 계약기간TextField, memoTextView, imageScrollView)
        backView.snp.makeConstraints {
            $0.top.equalTo(scrollView)
            $0.left.right.bottom.equalTo(view) // 가로 방향에 대해 화면 너비와 동일하게 설정
            $0.width.equalTo(view) // backView의 너비를 화면 너비와 동일하게 설정
        }}
    
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
        입주가능일button.snp.makeConstraints {
            $0.top.equalTo(입주가능일.snp.bottom).offset(10)
            $0.leading.equalTo(self.view.safeAreaLayoutGuide.snp.leading).offset(23)
            $0.trailing.equalTo(self.view.safeAreaLayoutGuide.snp.trailing).offset(-23)
            $0.height.equalTo(30)}
        계약기간.snp.makeConstraints {
            $0.top.equalTo(입주가능일button.snp.bottom).offset(10)
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
        backView.addSubviews(checkListLabel, checkListUIView,  recodeLabel, completionButton)
        imageScrollView.addSubviews(galleryImageView, secondGalleryImageView, thirdGalleryImageView, fourthGalleryImageView, fifthGalleryImageView)
        checkListLabel.snp.makeConstraints {
            $0.top.equalTo(separatorLine2.snp.bottom).offset(30)
            $0.leading.equalToSuperview().offset(20)}
        checkListUIView.snp.makeConstraints {
            $0.top.equalTo(checkListLabel.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(500)}
        recodeLabel.snp.makeConstraints {
            $0.top.equalTo(checkListUIView.snp.bottom).offset(30)
            $0.leading.equalTo(checkListLabel)}
        imageScrollView.snp.makeConstraints {
            $0.top.equalTo(recodeLabel.snp.bottom).offset(20)
            $0.leading.equalTo(checkListLabel)
            $0.trailing.equalTo(면적TextField)
            $0.height.equalTo(140)
        }
        galleryImageView.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
            $0.height.width.equalTo(140)}
        secondGalleryImageView.snp.makeConstraints {
            $0.top.equalTo(imageScrollView.snp.bottom).offset(0)
            $0.leading.equalTo(galleryImageView.snp.trailing).offset(10)
            $0.height.width.equalTo(140)}
        thirdGalleryImageView.snp.makeConstraints {
            $0.top.equalTo(imageScrollView.snp.bottom).offset(0)
            $0.leading.equalTo(secondGalleryImageView.snp.trailing).offset(10)
            $0.height.width.equalTo(140)}
        fourthGalleryImageView.snp.makeConstraints {
            $0.top.equalTo(imageScrollView.snp.bottom).offset(0)
            $0.leading.equalTo(thirdGalleryImageView.snp.trailing).offset(10)
            $0.height.width.equalTo(140)}
        fifthGalleryImageView.snp.makeConstraints {
            $0.top.equalTo(imageScrollView.snp.bottom).offset(0)
            $0.leading.equalTo(fourthGalleryImageView.snp.trailing).offset(10)
            $0.height.width.equalTo(140)
            $0.trailing.equalTo(imageScrollView.snp.trailing)}
        memoTextView.snp.makeConstraints {
            $0.top.equalTo(galleryImageView.snp.bottom).offset(20)
            $0.leading.equalTo(checkListLabel)
            $0.trailing.equalTo(checkListUIView)
            $0.height.equalTo(200)}
        completionButton.snp.makeConstraints {
            $0.top.equalTo(memoTextView.snp.bottom).offset(30)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(56)}
    }
    private func setUpKeyBoard() {
        // 다른 곳을 누르면 키보드가 내려가게 됨
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        view.addGestureRecognizer(tapGesture)
    }
    private func setUpLabel() {
        //*만 빨갛게 바꾸는 콛
        let labels = [보증금, 월세]
        for texts in labels {
            let fullText = texts.text ?? ""
            let attribtuedString = NSMutableAttributedString(string: fullText)
            let range = (fullText as NSString).range(of: "*")
            attribtuedString.addAttribute(.foregroundColor, value: UIColor.systemRed, range: range)
            texts.attributedText = attribtuedString}
    }
    private func setupNavigationBar() {
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationItem.title = "추가하기"
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationController?.navigationBar.backgroundColor = .white
    }
    private func initPicker() {
        var configuration = PHPickerConfiguration(photoLibrary: .shared())
        configuration.selectionLimit = 5
        configuration.filter = .images // 이미지만 선택할 수 있게 설정
        picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
    }
    private func setupImageViewGesture() {
        // 모든 이미지뷰에서 앨버으로 접근하려면 새로운 객체를 만들어야 한다.
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(openLibrary))
        galleryImageView.addGestureRecognizer(tapGesture)
        galleryImageView.isUserInteractionEnabled = true
        let tapGesture2 = UITapGestureRecognizer(target: self, action: #selector(openLibrary))
        secondGalleryImageView.addGestureRecognizer(tapGesture2)
        secondGalleryImageView.isUserInteractionEnabled = true
        let tapGesture3 = UITapGestureRecognizer(target: self, action: #selector(openLibrary))
        thirdGalleryImageView.addGestureRecognizer(tapGesture3)
        thirdGalleryImageView.isUserInteractionEnabled = true
        let tapGesture4 = UITapGestureRecognizer(target: self, action: #selector(openLibrary))
        thirdGalleryImageView.addGestureRecognizer(tapGesture4)
        thirdGalleryImageView.isUserInteractionEnabled = true
        let tapGesture5 = UITapGestureRecognizer(target: self, action: #selector(openLibrary))
        thirdGalleryImageView.addGestureRecognizer(tapGesture5)
        thirdGalleryImageView.isUserInteractionEnabled = true
    }
    
    //MARK: - Actions
    @objc func vc2buttonTapped(_ sender: UIButton) {
        print("--------\(sender.currentTitle!)버튼 눌림-------")
        switch sender.currentTitle {
        case "전기", "가스", "수도", "인터넷", "TV", "기타":
            guard sender.backgroundColor == Constant.appColor else {
                sender.setTitleColor(.white, for: .normal)
                sender.backgroundColor = Constant.appColor
                self.houseViewModel.관리비미포함목록.append(sender.currentTitle ?? "")
                return
            }
            sender.setTitleColor(.darkGray, for: .normal)
            sender.backgroundColor = .white
            self.houseViewModel.관리비미포함목록 = self.houseViewModel.관리비미포함목록.filter {
                $0 != sender.currentTitle ?? ""
            }
        default:
            print("디폴트")
        }
    }
    @objc func completionButtonTapped() {
        let rateVC = RateVC()
        rateVC.modalPresentationStyle = .pageSheet
        rateVC.houseViewModel = self.houseViewModel
        self.present(rateVC, animated: true)
    }
    @objc func textFieldTapped() {
        if #available(iOS 16.0, *) {
            let calendarVC = CalendarVC()
            calendarVC.calendarDelegate = self
            calendarVC.modalPresentationStyle = .pageSheet
            self.present(calendarVC, animated: true)
        } else {
            print("버전 낮음")
        }
    }
    // 앨범 권한설정(사진 다운로드때문에)
    @objc func openLibrary() {
        let status = PHPhotoLibrary.authorizationStatus()
        switch status {
        case .authorized:
            self.present(picker, animated: true, completion: nil)
        case .denied, .restricted:
            let alert = UIAlertController(title: "권한 필요", message: "앨범 접근 권한이 필요합니다. 설정에서 권한을 허용해주세요.", preferredStyle: .alert)
            let goSetting = UIAlertAction(title: "설정으로 이동", style: .default) { _ in
                if let url = URL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)}
            }
            let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
            alert.addAction(goSetting)
            alert.addAction(cancel)
            self.present(alert, animated: true, completion: nil)
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization { newStatus in
                if newStatus == .authorized {
                    DispatchQueue.main.async {
                        self.present(self.picker, animated: true, completion: nil)
                    }
                }
            }
        @unknown default:
            fatalError("Unknown authorization status.")
        }
    }
    @objc func handleTap() {
        self.view.endEditing(true)
    }
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let userInfo = notification.userInfo else { return }
        guard let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        let keyboardHeight = keyboardFrame.size.height
        let textViewFrameInSuperview = scrollView.convert(memoTextView.frame, from: memoTextView.superview)
        let offset = textViewFrameInSuperview.origin.y + textViewFrameInSuperview.size.height - (scrollView.frame.size.height - keyboardHeight)
        if offset > 0 {
            scrollView.setContentOffset(CGPoint(x: 0, y: offset), animated: true)
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        let contentInset: UIEdgeInsets = UIEdgeInsets.zero
        scrollView.contentInset = contentInset
    }
    
    //관찰자 제거
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

//MARK: - Extensions
extension CheckVC2: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.delegate = self
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard Double(string) != nil || string == "" else { return false }
        if textField == 보증금TextField {
            let maxLenght = 6
            let currentString: NSString = (textField.text ?? "") as NSString
            let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= maxLenght
        } else if textField == 월세TextField {
            let maxLenght = 3
            let currentString: NSString = (textField.text ?? "") as NSString
            let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= maxLenght
        } else if textField == 관리비TextField {
            let maxLenght = 2
            let currentString: NSString = (textField.text ?? "") as NSString
            let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= maxLenght
        }
        return true
    }
}

extension CheckVC2: CalendarDelegate {
    func dateSelected(date: Date) {
        let myFormatter = DateFormatter()
        myFormatter.dateFormat = "yy.MM.dd"
        self.입주가능일button.setTitle(myFormatter.string(from: date), for: .normal)
        self.입주가능일button.setTitleColor(.black, for: .normal)
        self.houseViewModel.입주가능일 = date}
}

extension CheckVC2: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        for (index, result) in results.enumerated() {
            result.itemProvider.loadObject(ofClass: UIImage.self) { (object, error) in
                if let image = object as? UIImage {
                    DispatchQueue.main.async {
                        if index < self.imageViewArray.count {
                            self.imageViewArray[index].image = image
                            self.imageViewArray[index].contentMode = .scaleAspectFill
                        }
                    }
                }
            }
        }
    }
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
