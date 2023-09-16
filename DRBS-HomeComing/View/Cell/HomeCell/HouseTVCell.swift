import UIKit

final class HouseTVCell: UITableViewCell {
    
    //MARK: - Properties
    
    var indexPath: Int?
    weak var cellselectedDelegate: CellSelectedDelegate?
    private lazy var apartCell: [House] = []
    private lazy var oneRoomCell: [House] = []
    private lazy var villaCell: [House] = []
    private lazy var bookmarkCell: [House] = []
    private let noDataView = NoDataView(message: "+ 버튼으로 체크리스트를 추가해보세요!")
    var houses: [House] = [] {
        didSet {
            self.oneRoomCell = houses.filter{$0.livingType! == "원룸/투룸+"}
            self.villaCell = houses.filter{$0.livingType! == "빌라/주택"}
            self.apartCell = houses.filter{$0.livingType! == "아파트/오피스텔"}
            self.bookmarkCell = houses.filter{$0.isBookMarked! == true}
            DispatchQueue.main.async {
                self.collectionView.reloadData()
                self.updatePlaceholderView()
            }
        }
    }
    
    private let collectionViewFlowLayout = UICollectionViewFlowLayout().then {
        $0.scrollDirection = .horizontal
        $0.minimumLineSpacing = 8.0
        $0.minimumInteritemSpacing = 0
        $0.itemSize = .init(width: 160, height: 170)
    }
    
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.collectionViewFlowLayout) .then {
        $0.isScrollEnabled = true
        $0.showsHorizontalScrollIndicator = false
        $0.showsVerticalScrollIndicator = true
        $0.contentInset = .zero
        $0.backgroundColor = .clear
        $0.clipsToBounds = true
        $0.register(ApartCell.self, forCellWithReuseIdentifier: Constant.Identifier.apartCell.rawValue)
        $0.register(OneroomCell.self, forCellWithReuseIdentifier: Constant.Identifier.oneroomCell.rawValue)
        $0.register(VillaCell.self, forCellWithReuseIdentifier: Constant.Identifier.villaCell.rawValue)
        $0.register(BookMarkCell.self, forCellWithReuseIdentifier: Constant.Identifier.bookmarkCell.rawValue)
    }
    
    
    //MARK: - LifeCycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.contentView.addSubviews(self.collectionView, self.noDataView)
        NotificationCenter.default.addObserver(self, selector: #selector(handleHouseDeleted), name: Notification.Name("houseDeleted"), object: nil)
        
        NSLayoutConstraint.activate([
            self.noDataView.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor, constant: -10),
            self.noDataView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
        ])
        collectionView.snp.makeConstraints { $0.edges.equalToSuperview() }
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    deinit {
        // NotificationCenter에서 관찰자 제거
        NotificationCenter.default.removeObserver(self, name: Notification.Name("houseDeleted"), object: nil)
    }
    
    //MARK: - Helpers
    
    private func updatePlaceholderView() {
        switch self.indexPath {
            case 0:
            self.noDataView.isHidden = (self.apartCell.count) > 0
            case 1:
            self.noDataView.isHidden = (self.villaCell.count) > 0
            case 2:
            self.noDataView.isHidden = (self.oneRoomCell.count) > 0
            case 3:
            self.noDataView.isHidden = (self.bookmarkCell.count) > 0
            default:
                self.noDataView.isHidden = true
        }
    }
}


//MARK: - UICollectionViewDataSource

extension HouseTVCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch self.indexPath {
        case 0:
            return self.apartCell.count
        case 1:
            return self.villaCell.count
        case 2:
            return self.oneRoomCell.count
        case 3:
            return self.bookmarkCell.count
        default:
            return 10
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch self.indexPath {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.Identifier.apartCell.rawValue, for: indexPath) as! ApartCell
            cell.apartHouse = self.apartCell[indexPath.row]
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.Identifier.villaCell.rawValue, for: indexPath) as! VillaCell
            cell.villaHouse = self.villaCell[indexPath.row]
            return cell
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.Identifier.oneroomCell.rawValue, for: indexPath) as! OneroomCell
            cell.oneRoomHouse = self.oneRoomCell[indexPath.row]
            return cell
        case 3:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.Identifier.bookmarkCell.rawValue, for: indexPath) as! BookMarkCell
            cell.bookmarkHouse = self.bookmarkCell[indexPath.row]
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    @objc func handleHouseDeleted(notification: Notification) {
        if let userInfo = notification.userInfo, let deletedHouseId = userInfo["deletedHouseId"] as? String {
            if let index = self.houses.firstIndex(where: { $0.houseId == deletedHouseId }) {
                self.houses.remove(at: index)
            }
        }
    }
}

//MARK: - UICollectionViewDelegate

extension HouseTVCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch self.indexPath {
            case 0:
                self.cellselectedDelegate?.cellselected(houseTVCell: self, house: self.houses.filter{ $0.livingType! == "아파트/오피스텔" }[indexPath.row])
            case 1:
                self.cellselectedDelegate?.cellselected(houseTVCell: self, house: self.houses.filter{ $0.livingType! == "빌라/주택" }[indexPath.row])
            case 2:
                self.cellselectedDelegate?.cellselected(houseTVCell: self, house: self.houses.filter{ $0.livingType! == "원룸/투룸+" }[indexPath.row])
            case 3:
                self.cellselectedDelegate?.cellselected(houseTVCell: self, house: self.houses.filter{ $0.isBookMarked! == true }[indexPath.row])
            default:
                break
        }
    }
}
