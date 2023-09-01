import UIKit
import SnapKit
import Then


final class ApartCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    var apartHouse: House? {
        didSet {
            guard let house = self.apartHouse else { return }
            
            if let 사진 = house.사진 {
                if !사진.isEmpty {
                    self.cellImage.image = 사진[0].toImage()
                } else {
                    //이미지가 없습니다!
                    let customImage = UIImage(named: "eye.slash")
                    let newWidth = 30
                    let newHeight = 30
                    let newImageRect = CGRect(x: 0, y: 0, width: newWidth, height: newHeight)
                    UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
                    customImage?.draw(in: newImageRect)
                    let newImage = UIGraphicsGetImageFromCurrentImageContext()?.withRenderingMode(.alwaysOriginal)
                    UIGraphicsEndImageContext()
                    self.cellImage.image = newImage
                    self.cellImage.tintColor = .darkGray
                    
                }
            }
            
            self.titleLabel.text = house.title!
            self.costLabel.text = house.보증금! + "/" + house.월세!
            self.ratingImage.image = UIImage(named: "star")
            self.ratingLabel.text = String(house.별점!)
        }
    }
    
    private let baseView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let cellImage = UIImageView().then {
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 6
        $0.translatesAutoresizingMaskIntoConstraints = false
//        $0.image = UIImage(named: "roomImage.png")
        $0.contentMode = .scaleAspectFill
    }
    
    private let titleLabel = UILabel().then {
        $0.font = UIFont(name: "Pretendard-Bold", size: 14)
        $0.textColor = UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1)
        $0.translatesAutoresizingMaskIntoConstraints = false

    }
    
    private let costLabel = UILabel().then {
        $0.font = UIFont(name: "Pretendard-Bold", size: 12)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textColor = UIColor(red: 0.36, green: 0.36, blue: 0.38, alpha: 1)
    }
    
    private let ratingImage = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.image = UIImage(named: "star_fill.png")
        $0.translatesAutoresizingMaskIntoConstraints = false

    }
    
    private let ratingLabel = UILabel().then {
        $0.font = UIFont(name: "Pretendard-Bold", size: 12)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textColor = UIColor(red: 0.36, green: 0.36, blue: 0.38, alpha: 1)
    }
    
    // MARK: - LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)

        self.contentView.addSubview(baseView)

        NSLayoutConstraint.activate([
            self.baseView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor),
            self.baseView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor),
            self.baseView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.baseView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
        ])
        setupViews()
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    private func configureCell(image: UIImage, title: String, cost: String, rating: Float) {
        guard let house = self.apartHouse else { return }
        
        DispatchQueue.main.async {
            self.cellImage.image = UIImage(named: "roomImage.png")
            self.titleLabel.text = house.title!
            self.costLabel.text = house.보증금! + "/" + house.월세!
            self.ratingImage.image = UIImage(named: "star")
            self.ratingLabel.text = String(house.별점!)
        }
        
    }
    
    private func setupViews() {
        baseView.addSubviews(cellImage, titleLabel, costLabel, ratingImage, ratingLabel)
        
        cellImage.snp.makeConstraints {
            $0.leading.trailing.top.equalToSuperview()
            $0.height.equalTo(120)
            $0.width.equalTo(160)
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(5)
            $0.trailing.equalToSuperview()
            $0.top.equalTo(cellImage.snp.bottom).offset(6)
        }
        
        costLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(5)
            $0.width.equalTo(100)
            $0.top.equalTo(titleLabel.snp.bottom).offset(6)
        }
        
        ratingLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-5)
            $0.centerY.equalTo(costLabel.snp.centerY)
        }
        
        ratingImage.snp.makeConstraints {
            $0.trailing.equalTo(ratingLabel.snp.leading).offset(2)
            $0.height.width.equalTo(20)
            $0.centerY.equalTo(ratingLabel)
        }

    }
    func makeStringToUIImage(string: String) -> UIImage? {
        if let data = Data(base64Encoded: string, options: .ignoreUnknownCharacters) {
            return UIImage(data: data)
        }
        return nil
    }
    
    //MARK: - Action
}
