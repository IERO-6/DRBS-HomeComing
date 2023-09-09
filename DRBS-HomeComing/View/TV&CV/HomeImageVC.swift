import UIKit

class HomeImageVC : UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    // MARK: - Properties
    
    var collectionView : UICollectionView!
    
    let imageNames = ["home-example-1", "home-example-2"]
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    //MARK: - Helpers
    private func configureUI() {
        let layout : UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom:
                                            10, right:
                                            10)
        layout.itemSize = CGSize(width: (self.view.frame.size.width-60)/3,
                                height: (self.view.frame.size.width-60)/3)
        
        collectionView = UICollectionView(frame:self.view.frame, collectionViewLayout: layout)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(UICollectionViewCell.self,forCellWithReuseIdentifier:"Cell")
    }
    
    //MARK: - Actions
    func collectionView(_ collectionView:
                        UICollectionView,
                        numberOfItemsInSection section:Int) -> Int {
        return self.imageNames.count
    }
    
    func collectionView(_ _collectionView:
                        UICollectionView,
                        cellForItemAt indexPath:
                        IndexPath) -> UICollectionViewCell {
        let cell = _collectionView.dequeueReusableCell(withReuseIdentifier:"Cell", for:indexPath as IndexPath)
        let componentView = HomeImagesCell(imageName:imageNames[indexPath.row])
        cell.addSubview(componentView)
        
        return cell
    }
}
