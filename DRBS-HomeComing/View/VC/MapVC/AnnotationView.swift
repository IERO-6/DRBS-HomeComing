import UIKit
import MapKit
import Then
import SnapKit

class AnnotationView: MKAnnotationView {
    //MARK: - Properties
    
    private let view = UIImageView().then {
        $0.backgroundColor = .clear
        $0.clipsToBounds = true
        $0.image = UIImage(systemName: "house")
        $0.contentMode = .scaleAspectFit
        $0.tintColor = .white
    }
    
    private let backgroundView = UIView().then {
        $0.backgroundColor = Constant.appColor
        $0.clipsToBounds = true
    }
    
    
    //MARK: - LifeCycle

    override init(annotation: MKAnnotation?, reuseIdentifier: String?){
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
//        configureUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helpers

    private func configureUI() {
        backgroundColor = .clear
        backgroundView.addSubview(view)
        self.addSubviews(backgroundView)
        
        backgroundView.snp.makeConstraints {
            $0.width.height.equalTo(30)
            $0.centerX.equalTo(self.snp.centerX)
            $0.centerY.equalTo(self.snp.centerY)}
        
        view.snp.makeConstraints {
            $0.width.height.equalTo(25)
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()}
        backgroundView.layer.cornerRadius = 15
    }
    
}
