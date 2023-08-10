import UIKit
import MapKit
import Then
import SnapKit

class AnnotationView: MKAnnotationView {
    //MARK: - Properties

    static let identifier = "AnnotationView"
    
    private let view = UIImageView().then {
        $0.backgroundColor = Constant.appColor
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 15
        $0.image = UIImage(systemName: "house")
        $0.contentMode = .scaleAspectFit
        $0.tintColor = .white
    }
    //MARK: - LifeCycle

    override init(annotation: MKAnnotation?, reuseIdentifier: String?){
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)

        configureUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helpers

    private func configureUI() {
        backgroundColor = .clear
        self.addSubviews(view)
        view.snp.makeConstraints {
            $0.width.height.equalTo(30)
            $0.centerX.equalTo(self.snp.centerX)
            $0.centerY.equalTo(self.snp.centerY)

        }
    }
    
}
