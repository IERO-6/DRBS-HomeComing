import UIKit

final class HouseTVCell: UITableViewCell {
    //MARK: - Properties

    var indexPath: Int?
    
    weak var cellselectedDelegate: CellSelectedDelegate?
    
    var oneRoomCellCount: Int?
    
    var houses: [House] = [] {
        didSet {
            self.oneRoomCellCount = houses.filter{$0.livingType! == "아파트"}.count
        }
    }
    
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
        self.collectionView.delegate = self
        self.contentView.addSubview(self.collectionView)
        NSLayoutConstraint.activate([
            self.collectionView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor),
            self.collectionView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor),
            self.collectionView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            self.collectionView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
          ])
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    //MARK: - Helpers
    private func fetchHousesFromFireStore() {
        DispatchQueue.global().async {
            NetworkingManager.shared.fetchHouses { houses in
                self.houses = houses
            }
        }
    }
}


//MARK: - UICollectionViewDataSource

extension HouseTVCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch self.indexPath {
        case 0:
            return 1
        case 1:
            guard let count = oneRoomCellCount else { return 5 }
            return count
        case 2:
            return 2
        default:
            return 2
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch self.indexPath {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.Identifier.houseCell.rawValue, for: indexPath) as! ApartCell
                return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.Identifier.oneroomCell.rawValue, for: indexPath) as! OneroomCell
            let oneRoomHouses = self.houses.filter{ $0.livingType! == "아파트" }
            print("현재 카운트는\(oneRoomHouses.count)")
            print(indexPath.row)
            cell.oneRoomHouse = oneRoomHouses[indexPath.row]
                return cell
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.Identifier.officeCell.rawValue, for: indexPath) as! OfficeCell
                return cell
        default:
            return UICollectionViewCell()
        }
    }
}

extension HouseTVCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //셀 선택 됐을 때 해당 셀의 Id를 통해 파이어베이스에서 받아온 데이터로 디테일VC를 띄움
        self.cellselectedDelegate?.cellselected(indexPath: indexPath)
        
    }
}
