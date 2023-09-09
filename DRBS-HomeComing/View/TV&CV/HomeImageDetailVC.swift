import UIKit

class HomeImageDetailVC : UIViewController {
    
    // MARK: - Properties
    
    let totalImages:Int
    var currentIndex:Int
    var imageName:String
    let imageNames:[String]
    
    // MARK: - LifeCycle
    init(totalImages:Int ,selectedIndex:Int ,imageName:String ,imageNames:[String]) {
        self.totalImages=totalImages
        self.currentIndex=selectedIndex
        self.imageName=imageName
        self.imageNames=imageNames
        
        super.init(nibName:nil,bundle:nil)
    }
    required init?(coder aDecoder:NSCoder){ fatalError("init(coder:) has not been implemented")}
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        let swipeRight=UISwipeGestureRecognizer(target:self ,action:#selector(swiped))
        swipeRight.direction=UISwipeGestureRecognizer.Direction.right
        
        let swipeLeft=UISwipeGestureRecognizer(target:self ,action:#selector(swiped))
        swipeLeft.direction=UISwipeGestureRecognizer.Direction.left
        
        self.view.addGestureRecognizer(swipeRight)
        self.view.addGestureRecognizer(swipeLeft)
        
    }
    
    // MARK: - Action
    
    @objc func swiped(gesture:UIGestureRecognizer){
        
        if let swipeGesture=gesture as? UISwipeGestureRecognizer{
            switch swipeGesture.direction{
                
            case UISwipeGestureRecognizer.Direction.right:
                print("User Swiped Right")
                currentIndex = (currentIndex - 1 + totalImages) % totalImages
                imageName = imageNames[currentIndex]
                
            case UISwipeGestureRecognizer.Direction.left:
                print("User Swiped Left")
                currentIndex = (currentIndex + 1 + totalImages) % totalImages
                imageName = imageNames[currentIndex]
                
            default:
                break
            }
        }
    }
}
