import UIKit
import SnapKit
import Then

final class ModalVC: UIViewController {
    //MARK: - Properties
    
    var houseViewModel: HouseViewModel = HouseViewModel()
    
    private let backView = UIView().then {
        $0.backgroundColor = .white
    }
    
    private let nameLabel = UILabel().then {
        $0.text = "신대방역 근처 원룸"
        $0.textColor = .black
        $0.font = UIFont(name: "Pretendard-Bold", size: 22)
        $0.textAlignment = .left
    }
    
    private let starImageView = UIImageView().then {
        $0.image = UIImage(named: "star_fill.png")
        $0.contentMode = .scaleAspectFill
    }
    private let rateLabel = UILabel().then {
        $0.font = UIFont(name: "Pretendard-Regular", size: 13)
        $0.textColor = .darkGray
        $0.textAlignment = .center
    }
    
    private let bookMarkButton = UIButton().then {
        $0.tintColor = Constant.appColor
    }
    
    private let addressLabel = UILabel().then {
        $0.text = "서울특별시 관악구 신림동 617-14"
        $0.textColor = .darkGray
        $0.font = UIFont(name: "Pretendard-Regular", size: 16)
        $0.textAlignment = .left
    }
    
    private let livingTypeLabel = UILabel().then {
        $0.textAlignment = .center
        $0.textColor = Constant.appColor
        $0.font = UIFont(name: "Pretendard-Regular", size: 14)
        $0.layer.cornerRadius = 5
        $0.clipsToBounds = true
        $0.sizeToFit()
        $0.layer.borderColor = Constant.appColor.cgColor
        $0.layer.borderWidth = 1
    }
    private let tradingTypeLabel = UILabel().then {
        $0.textAlignment = .center
        $0.textColor = Constant.appColor
        $0.font = UIFont(name: "Pretendard-Regular", size: 14)
        $0.layer.cornerRadius = 5
        $0.clipsToBounds = true
        $0.sizeToFit()
        $0.layer.borderColor = Constant.appColor.cgColor
        $0.layer.borderWidth = 1
    }
    
    private let priceLabel = UILabel().then {
        $0.font = UIFont(name: "Pretendard-Bold", size: 18)
        $0.textColor = .black
        $0.textAlignment = .left
    }
    
    private let firstImageView = UIImageView().then {
        $0.image = UIImage(named: "roomImage")
        $0.layer.cornerRadius = 5
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
    }
    private let secondImageView = UIImageView().then {
        $0.layer.cornerRadius = 5
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
    }
    private let thirdImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.layer.cornerRadius = 5
        $0.clipsToBounds = true
    }
    private let fourthImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.layer.cornerRadius = 5
        $0.clipsToBounds = true
    }
    
    private let imageContainView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 10
        $0.distribution = .fillEqually
        $0.alignment = .fill
    }
    
    
    private let memoTextView = UITextView().then {
        $0.backgroundColor = .systemGray6
        $0.isScrollEnabled = false
        $0.font = UIFont.systemFont(ofSize: 16)
        $0.textContainer.maximumNumberOfLines = 2
        $0.textContainer.lineBreakMode = .byTruncatingTail
    }
    
    private lazy var goButton = UIButton().then {
        $0.backgroundColor = Constant.appColor
        $0.setTitle("바로가기", for: .normal)
        $0.setTitleColor(UIColor.white, for: .normal)
        $0.layer.cornerRadius = 8
    }
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureUIWithData()
    }
    
    //MARK: - Helpers

    private func configureUI() {
        view.backgroundColor = .white
        view.addSubviews(backView)
        imageContainView.addArrangedSubviews(firstImageView, secondImageView, thirdImageView, fourthImageView)
        backView.addSubviews(nameLabel, starImageView, rateLabel, bookMarkButton,
                            addressLabel, livingTypeLabel, tradingTypeLabel, priceLabel,
                             imageContainView,
//                             firstImageView,
//                             secondImageView, thirdImageView, fourthImageView,
                                memoTextView, goButton)
        backView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(50)
            $0.leading.equalToSuperview().offset(20)
            $0.bottom.trailing.equalToSuperview().inset(20)
        }
      
        bookMarkButton.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.width.height.equalTo(30)
        }
        rateLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.width.equalTo(30)
            $0.height.equalTo(30)
            $0.trailing.equalTo(bookMarkButton.snp.leading).inset(5)
        }
        starImageView.snp.makeConstraints {
            $0.centerY.equalTo(bookMarkButton.snp.centerY)
            $0.width.equalTo(15)
            $0.height.equalTo(15)
            $0.trailing.equalTo(rateLabel.snp.leading).offset(-5)
        }
        
        nameLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.height.equalTo(30)
            $0.trailing.equalTo(starImageView.snp.leading).offset(-10)
        }
        
        tradingTypeLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview()
            $0.top.equalTo(nameLabel.snp.bottom).offset(10)
            $0.height.equalTo(30)
            $0.width.equalTo(40)
        }
        
        
        livingTypeLabel.snp.makeConstraints {
            $0.trailing.equalTo(tradingTypeLabel.snp.leading).offset(-8)
            $0.top.equalTo(tradingTypeLabel)
            $0.bottom.equalTo(tradingTypeLabel)
            $0.width.equalTo(80)
        }
        addressLabel.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.top.equalTo(tradingTypeLabel)
            $0.bottom.equalTo(tradingTypeLabel)
            $0.trailing.equalTo(livingTypeLabel.snp.leading).offset(-10)
        }
        
        priceLabel.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.top.equalTo(addressLabel.snp.bottom).offset(10)
            $0.height.equalTo(30)
            $0.width.equalToSuperview()
        }
        
        imageContainView.snp.makeConstraints {
            $0.top.equalTo(priceLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo((self.view.frame.width-70)/4)
        }
        
        memoTextView.snp.makeConstraints {
            $0.top.equalTo(imageContainView.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(150)
        }
        goButton.snp.makeConstraints {
            $0.top.equalTo(memoTextView.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(50)
        }
        
    }
    
    private func configureUIWithData() {
        guard let house = houseViewModel.house else { return }
        self.nameLabel.text = house.title!
        self.rateLabel.text = String(house.별점!)
        self.addressLabel.text = house.address!
        self.memoTextView.text = house.기록 ?? ""
        self.priceLabel.text = house.보증금! + "/" + house.월세!
        self.livingTypeLabel.text = house.livingType!
        self.tradingTypeLabel.text = house.tradingType!
        guard let isBookmarked = house.isBookMarked else { return }
        switch isBookmarked {
        case true:
            self.bookMarkButton.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
        case false:
            self.bookMarkButton.setImage(UIImage(systemName: "bookmark"), for: .normal)
        }
        guard let houseImages = house.사진 else { return }
        let images = houseImages.map{$0.toImage()}
        switch images.count {
        case 1:
            self.firstImageView.image = images[0]
        case 2:
            self.firstImageView.image = images[0]
            self.secondImageView.image = images[1]
        case 3:
            self.firstImageView.image = images[0]
            self.secondImageView.image = images[1]
            self.thirdImageView.image = images[2]
        case 4:
            self.firstImageView.image = images[0]
            self.secondImageView.image = images[1]
            self.thirdImageView.image = images[2]
            self.fourthImageView.image = images[3]
        case 5:
            print("한개 더 있음")
            self.firstImageView.image = images[0]
            self.secondImageView.image = images[1]
            self.thirdImageView.image = images[2]
            self.fourthImageView.image = images[3]
        default:
            return
        }
    }
    
  
    //MARK: - Actions


}

//MARK: - Extensions

