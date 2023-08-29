import UIKit

class SearchCell: UITableViewCell {
    //MARK: - Properties
    var locationLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = .black
        return label
    }()
    
    
    //MARK: - LifeCycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        configureUI()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helpers
    func configureUI() {
        self.contentView.addSubview(locationLabel)
        NSLayoutConstraint.activate([
            locationLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10),
            locationLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10),
            locationLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -10),
            locationLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -10),
        ])
    }
    
    //MARK: - Actions


}
