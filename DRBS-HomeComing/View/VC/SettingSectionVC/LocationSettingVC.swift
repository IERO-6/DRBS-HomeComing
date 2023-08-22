import UIKit
import Then
import SnapKit

final class LocationSettingVC: UIViewController {
    
    // MARK: - Properties
    
    private let locationSettingTableView = UITableView().then {
        $0.register(LocationSettingCell.self, forCellReuseIdentifier: LocationSettingCell.id)
    }
    
    private let viewModel = LocationSettingViewModel()

    
    // MARK: - View Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNav()
        configureTableView()
        configureFooterView()
        
        self.extendedLayoutIncludesOpaqueBars = true
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }

    // MARK: - Helpers
    
    private func configureNav() {
        navigationItem.title = "위치 기반 서비스 이용 동의 설정"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)

        let appearance = UINavigationBarAppearance().then {
            $0.configureWithOpaqueBackground()
            $0.backgroundColor = Constant.appColor
            $0.titleTextAttributes = [.foregroundColor: UIColor.white]
        }
        
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    private func configureTableView() {
        
        view.addSubview(locationSettingTableView)
        locationSettingTableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        locationSettingTableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        locationSettingTableView.separatorInsetReference = .fromCellEdges
        locationSettingTableView.dataSource = self
        locationSettingTableView.delegate = self
    }
    
    private func configureFooterView() {
        let footerLabel = UILabel().then {
            $0.numberOfLines = 0
            $0.lineBreakMode = .byWordWrapping
            $0.font = UIFont.systemFont(ofSize: 12)
            $0.textColor = .gray

            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 1

            let attributedString = NSMutableAttributedString(string: "• 위치기반서비스를 이용하기 위해서는 위치 선택, 접근권한에 먼저 동의하셔야 합니다.\n", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
            $0.attributedText = attributedString
        }

        let footerView = UIView()
        footerView.addSubview(footerLabel)
        footerLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.top.equalToSuperview().inset(10)
            $0.bottom.equalToSuperview().inset(50)
        }

        locationSettingTableView.tableFooterView = footerView
        locationSettingTableView.tableFooterView?.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 100)
    }

}
    
// MARK: - UITableViewDataSource, UITableViewDelegate

extension LocationSettingVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.locations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LocationSettingCell.id, for: indexPath) as! LocationSettingCell
        if let location = viewModel.getLocation(at: indexPath.row) {
            cell.titleLabel.text = location.leftTitle
            cell.toggleSwitch.isOn = location.rightItem
        }
        cell.selectionStyle = .none

        cell.onDetailsButtonTapped = { [weak self] in
            let locationConsentDetailVC = LocationConsentDetailVC()
            let navigationController = UINavigationController(rootViewController: locationConsentDetailVC)
            navigationController.modalPresentationStyle = .automatic
            self?.present(navigationController, animated: true, completion: nil)
        }

        return cell
    }
}
