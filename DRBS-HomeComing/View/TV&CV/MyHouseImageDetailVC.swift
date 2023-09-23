import UIKit
import SnapKit
import Then

class MyHouseImageDetailVC : UIViewController {
    
    // MARK: - Properties
    let totalImages:Int
    var currentIndex:Int
    var imageName:String
    let imageNames:[String]
    
    lazy var imageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
    }
    
    lazy var closeButton = UIButton().then {
        $0.setImage(UIImage(systemName: "xmark"), for: .normal)
        $0.tintColor = .white
        $0.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
    }
    
    // MARK: - LifeCycle
    init(totalImages:Int ,selectedIndex:Int ,imageName:String ,imageNames:[String]) {
        self.totalImages = totalImages
        self.currentIndex = selectedIndex
        self.imageName = imageName
        self.imageNames = imageNames
        
        super.init(nibName:nil,bundle:nil)
    }
    
    required init?(coder aDecoder:NSCoder){ fatalError("init(coder:) has not been implemented")}
    
    override func viewDidLoad(){
        super.viewDidLoad()
        configureUI()
        updateImage()
        view.backgroundColor = .black
    }
    
    //MARK: - Helpers
    private func configureUI() {
        view.addSubview(imageView)
        view.addSubview(closeButton)
        
        imageView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        closeButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.left.equalTo(view.safeAreaLayoutGuide.snp.left).offset(10)
            make.width.height.equalTo(50)
        }
        
        let swipeLeft = UISwipeGestureRecognizer(target:self, action:#selector(swiped)).then{
            $0.direction = .left
            view.addGestureRecognizer($0)
        }
        let swipeRight = UISwipeGestureRecognizer(target:self, action:#selector(swiped)).then{
            $0.direction = .right
            view.addGestureRecognizer($0)
        }
    }
    
    // MARK: - Action
    @objc func handleDismiss() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func swiped(gesture:UIGestureRecognizer){
        
        if let swipeGesture=gesture as? UISwipeGestureRecognizer{
            switch swipeGesture.direction{
            case UISwipeGestureRecognizer.Direction.right:
                currentIndex = (currentIndex - 1 + totalImages) % totalImages
                
            case UISwipeGestureRecognizer.Direction.left:
                currentIndex = (currentIndex + 1 + totalImages) % totalImages
                
            default:
                break
            }
            imageName = imageNames[currentIndex]
            updateImage()
        }
    }
    
    private func updateImage() {
        DispatchQueue.main.async { [weak self] in
            if let imageUrlString = self?.imageName,
               let imageUrl = URL(string:imageUrlString){
                self?.imageView.sd_setImage(with:imageUrl)
            } else {
                print("Failed to load image named \(self?.imageName ?? "")")
            }
        }
    }
}
