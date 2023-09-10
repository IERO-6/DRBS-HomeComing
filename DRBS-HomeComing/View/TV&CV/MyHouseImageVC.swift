import UIKit
import SnapKit
import Then

class MyHouseImageVC : UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    // MARK: - Properties
    var collectionView : UICollectionView!
    
    var houseImages: [String] = []
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    //MARK: - Helpers
    private func configureUI() {
        let layout = UICollectionViewFlowLayout().then {
            $0.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
            $0.itemSize = CGSize(width: (self.view.frame.size.width-60)/3,
                                 height: (self.view.frame.size.width-60)/3)
        }
        
        collectionView = UICollectionView(frame:self.view.frame, collectionViewLayout: layout)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.backgroundColor = .white
        
        collectionView.register(UICollectionViewCell.self,forCellWithReuseIdentifier:"Cell")
        
        self.view.addSubview(collectionView)
    }
    
    //MARK: - Actions
    func collectionView(_ collectionView:
                        UICollectionView,
                        numberOfItemsInSection section:Int) -> Int {
        return self.houseImages.count
    } /// 좀 더 활용 예정...?
    
    /// - note : cell 그리기
    func collectionView(_ _collectionView:
                        UICollectionView,
                        cellForItemAt indexPath:
                        IndexPath) -> UICollectionViewCell {

        let cell = _collectionView.dequeueReusableCell(withReuseIdentifier:"Cell", for:indexPath as IndexPath)
        let componentView = HomeImagesCell(imageName: houseImages[indexPath.row])

        componentView.frame = cell.contentView.bounds

        cell.addSubview(componentView)

        return cell
    }
    
    /// - note : cell 클릭시 화면 전환
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let imageName = houseImages[indexPath.row]
        let detailVC = MyHouseImageDetailVC(totalImages: houseImages.count, selectedIndex: indexPath.row ,imageName: imageName ,imageNames: houseImages)
//        detailVC.hidesBottomBarWhenPushed = true
        detailVC.modalPresentationStyle = UIModalPresentationStyle.fullScreen
        self.present(detailVC, animated: true)
    }
}
