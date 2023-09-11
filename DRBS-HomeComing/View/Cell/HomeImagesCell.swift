import UIKit
import SnapKit
import Then

class HomeImagesCell: UIView {
    // MARK: - Properties
    
    let imageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
    }
    
    // MARK: - LifeCycle
    
    init(imageName: String) {
        super.init(frame: .zero)
        configureUI(imageName: imageName)
     }
     
     required init?(coder aDecoder:NSCoder){ fatalError("init(coder:) has not been implemented")}
     
     //MARK: - Helpers
     
     private func configureUI(imageName: String) {
         backgroundColor = UIColor.lightGray
        
         if let url = URL(string: imageName) {
            imageView.sd_setImage(with: url)
         }
         
         addSubview(imageView)
         
         imageView.snp.makeConstraints { make in
             make.edges.equalToSuperview()
         }
     }
}
