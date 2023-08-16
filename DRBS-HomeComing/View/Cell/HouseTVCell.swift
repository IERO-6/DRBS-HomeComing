import UIKit

class HouseTVCell: UITableViewCell {
    //MARK: - Properties

    var indexPath: Int?
    
    private let collectionViewFlowLayout: UICollectionViewFlowLayout = {
       let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 8.0
        layout.minimumInteritemSpacing = 0
        layout.itemSize = .init(width: 200, height: 180)
        
        return layout
    }()
    
    lazy var collectionView: UICollectionView = {
      let view = UICollectionView(frame: .zero, collectionViewLayout: self.collectionViewFlowLayout)
      view.isScrollEnabled = true
      view.showsHorizontalScrollIndicator = false
      view.showsVerticalScrollIndicator = true
      view.contentInset = .zero
      view.backgroundColor = .clear
      view.clipsToBounds = true
        view.register(ApartCell.self, forCellWithReuseIdentifier: Constant.Identifier.houseCell.rawValue)
        view.register(OneroomCell.self, forCellWithReuseIdentifier: Constant.Identifier.oneroomCell.rawValue)
        view.register(OfficeCell.self, forCellWithReuseIdentifier: Constant.Identifier.officeCell.rawValue)
      view.translatesAutoresizingMaskIntoConstraints = false
      return view
    }()
    
    
    //MARK: - LifeCycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        self.collectionView.dataSource = self
        self.contentView.addSubview(self.collectionView)
        NSLayoutConstraint.activate([
            self.collectionView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor),
            self.collectionView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor),
            self.collectionView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            self.collectionView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
          ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helpers

    
    
}


//MARK: - UICollectionViewDataSource

extension HouseTVCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch self.indexPath {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.Identifier.houseCell.rawValue, for: indexPath) as! ApartCell
                return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.Identifier.oneroomCell.rawValue, for: indexPath) as! OneroomCell
                return cell
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.Identifier.officeCell.rawValue, for: indexPath) as! OfficeCell
                return cell
        default:
            return UICollectionViewCell()
        }
        
    }
}
