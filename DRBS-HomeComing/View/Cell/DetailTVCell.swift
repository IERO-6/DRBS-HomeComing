//
//  DetailTVCell.swift
//  DRBS-HomeComing
//
//  Created by 김성호 on 2023/08/14.
//

import UIKit
import Then
import SnapKit

final class DetailTVCell: UITableViewCell {
    //MARK: - Properties

    static let identifier = "DetailTVCell"
    
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
        $0.text = "5.0"
        $0.font = UIFont(name: "Pretendard-Regular", size: 13)
        $0.textColor = .darkGray
        $0.textAlignment = .center
    }
    
    private let bookMarkButton = UIButton().then {
        $0.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
        $0.tintColor = Constant.appColor
    }
    
    private let addressLabel = UILabel().then {
        $0.text = "서울특별시 관악구 신림동 617-14"
        $0.textColor = .darkGray
        $0.font = UIFont(name: "Pretendard-Regular", size: 16)
        $0.textAlignment = .left
    }
    
    private let livingTypeLabel = UILabel().then {
        $0.text = "원룸"
        $0.textAlignment = .center
        $0.textColor = Constant.appColor
        $0.font = UIFont(name: "Pretendard-Regular", size: 14)
        $0.layer.cornerRadius = 5
        $0.clipsToBounds = true
        $0.layer.borderColor = Constant.appColor.cgColor
        $0.layer.borderWidth = 1
    }
    private let tradingTypeLabel = UILabel().then {
        $0.text = "월세"
        $0.textAlignment = .center
        $0.textColor = Constant.appColor
        $0.font = UIFont(name: "Pretendard-Regular", size: 14)
        $0.layer.cornerRadius = 5
        $0.clipsToBounds = true
        $0.layer.borderColor = Constant.appColor.cgColor
        $0.layer.borderWidth = 1
    }
    
    private let priceLabel = UILabel().then {
        $0.text = "1000/60"
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
        $0.image = UIImage(named: "roomImage")
        $0.layer.cornerRadius = 5
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
    }
    private let thirdImageView = UIImageView().then {
        $0.image = UIImage(named: "roomImage")
        $0.contentMode = .scaleAspectFill
        $0.layer.cornerRadius = 5
        $0.clipsToBounds = true
    }
    private let fourthImageView = UIImageView().then {
        $0.image = UIImage(named: "roomImage")
        $0.contentMode = .scaleAspectFill
        $0.layer.cornerRadius = 5
        $0.clipsToBounds = true
    }
    
    private let memoTextView = UITextView().then {
        $0.backgroundColor = .systemGray6
        $0.isScrollEnabled = false
        $0.font = UIFont.systemFont(ofSize: 16)
        $0.textContainer.maximumNumberOfLines = 2
        $0.textContainer.lineBreakMode = .byTruncatingTail
    }
    //MARK: - LifeCycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
            
        configureUI()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    //MARK: - Helpers
    private func configureUI() {
        contentView.backgroundColor = .white
        self.addSubview(contentView)
        contentView.addSubviews(backView)
        backView.addSubviews(nameLabel, starImageView, rateLabel, bookMarkButton,
                            addressLabel, livingTypeLabel, tradingTypeLabel, priceLabel, firstImageView, secondImageView, thirdImageView, fourthImageView,
                                memoTextView)
        backView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.leading.equalToSuperview().offset(15)
            $0.trailing.equalToSuperview().offset(-15)
            $0.bottom.equalToSuperview()
        }
        nameLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.height.equalTo(30)
            $0.width.equalTo(self.contentView.frame.width/2)
        }
        
        bookMarkButton.snp.makeConstraints {
            $0.centerY.equalTo(nameLabel.snp.centerY)
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
            $0.centerY.equalTo(nameLabel.snp.centerY)
            $0.width.equalTo(15)
            $0.height.equalTo(15)
            $0.trailing.equalTo(rateLabel.snp.leading).offset(-5)
        }
        
        addressLabel.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.top.equalTo(nameLabel.snp.bottom).offset(10)
            $0.height.equalTo(30)
            $0.width.equalTo(self.contentView.frame.width*0.66)
        }
        
        tradingTypeLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview()
            $0.top.equalTo(addressLabel)
            $0.bottom.equalTo(addressLabel)
            $0.width.equalTo(40)
        }
        
        livingTypeLabel.snp.makeConstraints {
            $0.trailing.equalTo(tradingTypeLabel.snp.leading).offset(-8)
            $0.top.equalTo(addressLabel)
            $0.bottom.equalTo(addressLabel)
            $0.width.equalTo(40)
        }
        
        priceLabel.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.top.equalTo(addressLabel.snp.bottom).offset(5)
            $0.height.equalTo(30)
            $0.width.equalToSuperview()
        }
        
        firstImageView.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.top.equalTo(priceLabel.snp.bottom).offset(12)
            $0.height.width.equalTo((self.contentView.frame.size.width)/4)
        }
        secondImageView.snp.makeConstraints {
            $0.leading.equalTo(firstImageView.snp.trailing).offset(10)
            $0.top.equalTo(priceLabel.snp.bottom).offset(12)
            $0.height.width.equalTo((self.contentView.frame.size.width)/4)
        }
        thirdImageView.snp.makeConstraints {
            $0.leading.equalTo(secondImageView.snp.trailing).offset(10)
            $0.top.equalTo(priceLabel.snp.bottom).offset(12)
            $0.height.width.equalTo((self.contentView.frame.size.width)/4)
        }
        fourthImageView.snp.makeConstraints {
            $0.leading.equalTo(thirdImageView.snp.trailing).offset(10)
            $0.top.equalTo(priceLabel.snp.bottom).offset(12)
            $0.height.width.equalTo((self.contentView.frame.size.width)/4)
        }
        memoTextView.snp.makeConstraints {
            $0.top.equalTo(firstImageView.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(62)
        }
       
        
    }
    
    
    
    

}
