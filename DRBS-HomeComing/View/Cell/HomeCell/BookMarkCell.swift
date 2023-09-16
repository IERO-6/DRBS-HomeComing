import UIKit
import SnapKit
import Then
import SDWebImage

final class BookMarkCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    var bookmarkHouse: House? {
        didSet {
            guard let house = self.bookmarkHouse else { return }
            guard let images = house.사진 else { return }
            guard !images.isEmpty else {
                cellImage.image = UIImage(named: "defaultImageBackground.png")
                let emptyImageView = UIImageView().then {
                    $0.image = UIImage(named: "default-empty-Image")
                    $0.tintColor = .darkGray
                    $0.contentMode = .scaleAspectFit
                }
                self.cellImage.addSubview(emptyImageView)
                emptyImageView.snp.makeConstraints {
                    $0.centerX.centerY.equalToSuperview()
                    $0.width.height.equalTo(30)
                }
                return
            }
            self.cellImage.sd_setImage(with: URL(string: images[0]))
            self.cellImage.contentMode = .scaleAspectFill
            self.titleLabel.text = house.title!
            self.costLabel.text = house.보증금! + "/" + house.월세!
            self.ratingLabel.text = String(house.별점!)
        }
    }
    
    private let baseView = UIView().then { $0.backgroundColor = .white }
    
    private let cellImage = UIImageView().then {
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 6
    }
    private let titleLabel = UILabel().then {
        $0.font = UIFont(name: "Pretendard-Bold", size: 14)
        $0.textColor = UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1)
    }
    
    private let costLabel = UILabel().then {
        $0.font = UIFont(name: "Pretendard-Bold", size: 12)
        $0.textColor = UIColor(red: 0.36, green: 0.36, blue: 0.38, alpha: 1)
    }
    
    private let ratingImage = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.image = UIImage(named: "star_fill.png")
    }
    
    private let ratingLabel = UILabel().then {
        $0.font = UIFont(name: "Pretendard-Bold", size: 12)
        $0.textColor = UIColor(red: 0.36, green: 0.36, blue: 0.38, alpha: 1)
    }
    // MARK: - LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    private func setupViews() {
        self.contentView.addSubview(baseView)
        self.baseView.addSubviews(cellImage, titleLabel,
                                  costLabel, ratingImage,
                                  ratingLabel)
        baseView.snp.makeConstraints { $0.edges.equalToSuperview() }
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
            $0.trailing.equalTo(ratingLabel.snp.leading).offset(-3)
            $0.height.width.equalTo(15)
            $0.centerY.equalTo(ratingLabel)
        }
    }
}
