import UIKit

class HomeImagesCell: UIView {
    // MARK: - Properties
    let imageView = UIImageView()
    
    // MARK: - LifeCycle
    init(imageName: String) {
        super.init(frame: .zero)
        configureUI(imageName: imageName)
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    //MARK: - Helpers
    private func configureUI(imageName: String) {
        backgroundColor = UIColor.lightGray
        
        imageView.image = UIImage(named: imageName)
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        
        addSubview(imageView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    //MARK: - Actions
}
