//
//  DetailTVCell.swift
//  DRBS-HomeComing
//
//  Created by 김성호 on 2023/08/14.
//

import UIKit
import Then
import SnapKit

class DetailTVCell: UITableViewCell {
    
    static let identifier = "DetailTVCell"
    
    let nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.text = "신대방역 근처 원룸"
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        if let currentFont = nameLabel.font {
            nameLabel.font = currentFont.withSize(18)
        }
       return nameLabel
    }()
    
    let priceLabel: UILabel = {
        let priceLabel = UILabel()
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.font = UIFont.boldSystemFont(ofSize: 16)
        
        return priceLabel
    }()
    
    let roomImageView: UIImageView = {
        let roomImageView = UIImageView()
        roomImageView.image = UIImage(named: "roomImage")
        roomImageView.translatesAutoresizingMaskIntoConstraints = false
        return roomImageView
    }()
    
    let starsNumber: UILabel = {
        let starsNumber = UILabel()
        starsNumber.translatesAutoresizingMaskIntoConstraints = false
        return starsNumber
    }()
    
    let starImageView: UIImageView = {
        let starImageView = UIImageView()
        starImageView.image = UIImage(named: "star")
        starImageView.translatesAutoresizingMaskIntoConstraints = false
        return starImageView
    }()
    
    let bookMarkButton: UIButton = {
        let bookMarkButton = UIButton()
        
        if let bookMarkImage = UIImage(systemName: "bookmark") {
            bookMarkButton.setImage(bookMarkImage, for: .normal)
            bookMarkButton.tintColor = .mainColor
        }
        
        bookMarkButton.translatesAutoresizingMaskIntoConstraints = false
        return bookMarkButton
    }()
    
    let memoTextField: UITextView = {
        let memoTextField = UITextView()
        memoTextField.translatesAutoresizingMaskIntoConstraints = false
        memoTextField.backgroundColor = .systemGray6
        memoTextField.isScrollEnabled = false
        memoTextField.font = UIFont.systemFont(ofSize: 16)
        memoTextField.textContainer.maximumNumberOfLines = 2
        memoTextField.textContainer.lineBreakMode = .byTruncatingTail
        return memoTextField
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
            
    addContentView()
    autoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addContentView() {
        contentView.addSubviews(nameLabel, priceLabel, roomImageView, starsNumber, starImageView, memoTextField, bookMarkButton)
    }
    
    private func autoLayout() {
        
        roomImageView.snp.makeConstraints {
            //왼쪽으로부터 5
            $0.top.equalTo(priceLabel.snp.bottom).offset(10)
            $0.leading.equalTo(0)
            $0.size.width.height.equalTo(100)
        }
        
        nameLabel.snp.makeConstraints {
            $0.leading.equalTo(0)
            $0.top.equalTo(0)
        }
        
        priceLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).inset(-10)
            $0.leading.equalTo(0)
        }
        
        starsNumber.snp.makeConstraints {
            $0.top.equalTo(0)
            $0.trailing.equalTo(-35)
        }
        
        starImageView.snp.makeConstraints {
            $0.top.equalTo(0)
            $0.trailing.equalTo(-60)
            $0.size.width.height.equalTo(20)
        }
        memoTextField.snp.makeConstraints {
            $0.bottom.equalTo(-15)
            $0.trailing.leading.equalTo(0)
            $0.height.equalTo(60)
        }
        bookMarkButton.snp.makeConstraints {
            $0.top.trailing.equalTo(0)
            $0.size.height.width.equalTo(20)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
        
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
