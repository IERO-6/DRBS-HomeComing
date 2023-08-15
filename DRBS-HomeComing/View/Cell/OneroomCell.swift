import UIKit
import SnapKit
import Then


class OneroomCell: UICollectionViewCell {
    
    // MARK: - Properties
    private let baseView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let cellImage = UIImageView().then {
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 4
        $0.translatesAutoresizingMaskIntoConstraints = false

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

        self.contentView.addSubview(self.baseView)
        setupViews()

        NSLayoutConstraint.activate([
            self.baseView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor),
            self.baseView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor),
            self.baseView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.baseView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    func configureCell(image: UIImage, title: String, cost: String, rating: Float) {
        cellImage.image = image
        titleLabel.text = title
        costLabel.text = cost
        ratingImage.image = UIImage(named: "star")
        ratingLabel.text = "\(rating)"
    }
    
    private func setupViews() {
        baseView.addSubviews(cellImage, titleLabel, costLabel, ratingImage, ratingLabel)
        
        cellImage.snp.makeConstraints {
            $0.leading.trailing.top.equalToSuperview()
            $0.height.equalTo(90)
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(cellImage.snp.bottom).offset(6)
        }
        
        costLabel.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.top.equalTo(titleLabel.snp.bottom).offset(6)
        }
        
        ratingImage.snp.makeConstraints {
            $0.trailing.equalToSuperview()
            $0.top.equalTo(titleLabel.snp.bottom).offset(4)
        }
        
        ratingLabel.snp.makeConstraints {
            $0.leading.equalTo(ratingImage.snp.trailing).offset(2)
            $0.centerY.equalTo(ratingImage)
        }
        
        contentView.snp.makeConstraints {
            $0.bottom.equalTo(costLabel.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview()
        }
    }
    
    //MARK: - Action
}
