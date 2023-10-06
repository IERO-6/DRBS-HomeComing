import UIKit
import Then
import SnapKit

final class NoDataView: UIView {
    
    // MARK: - Properties
    
    private let messageLabel = UILabel().then {
        $0.textColor = .darkGray
        $0.textAlignment = .center
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    // MARK: - Initialization
    
    init(message: String) {
        super.init(frame: .zero)
        self.configureUI(message: message)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    
    private func configureUI(message: String) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.messageLabel)
        self.messageLabel.text = message
        
        self.messageLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.leading.equalToSuperview().offset(10)
            $0.trailing.equalToSuperview().offset(-10)
            $0.top.equalToSuperview().offset(10)
            $0.bottom.equalToSuperview().offset(-10)
        }
    }
}
