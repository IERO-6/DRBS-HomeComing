import UIKit
import Then
import SnapKit
import SafariServices

final class SettingVC: UIViewController {
    
    // MARK: - Properties
    
    private let settingTableView = UITableView(frame: .zero, style: .grouped).then {
        $0.register(NoticeCell.self, forCellReuseIdentifier: NoticeCell.id)
        $0.register(OptionCell.self, forCellReuseIdentifier: OptionCell.id)
        $0.register(LicenseCell.self, forCellReuseIdentifier: LicenseCell.id)
        $0.register(AppVersionCell.self, forCellReuseIdentifier: AppVersionCell.id)
        $0.register(AccountSettingCell.self, forCellReuseIdentifier: AccountSettingCell.id)
        $0.separatorStyle = .none
    }
    
    private lazy var settingViewModel = SettingsViewModel()
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
        
        settingViewModel.logoutAction = { [weak self] in
            self?.showLogoutAlert()
        }
        
        settingViewModel.withdrawAction = { [weak self] in
            let withDrawVC = WithdrawVC()
            self?.navigationController?.pushViewController(withDrawVC, animated: true)
        }
        self.extendedLayoutIncludesOpaqueBars = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        configureNav()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    // MARK: - Helpers
    
    private func configureNav() {
        navigationItem.title = "설정"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        let appearance = UINavigationBarAppearance().then {
            $0.configureWithOpaqueBackground()
            $0.backgroundColor = Constant.appColor
            $0.titleTextAttributes = [.foregroundColor: UIColor.white]
        }
        navigationController?.navigationBar.topItem?.title = ""
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    private func configureTableView() {
        settingTableView.dataSource = self
        settingTableView.delegate = self
        
        view.addSubview(settingTableView)
        settingTableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    // MARK: - Actions
    
    private func showLogoutAlert() {
        let alertController = UIAlertController(title: nil, message: "로그아웃 하시겠습니까?", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "예", style: .default, handler: { _ in
            // 로그아웃 처리 로직
        }))
        alertController.addAction(UIAlertAction(title: "아니오", style: .cancel, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension SettingVC: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return settingViewModel.sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionType = settingViewModel.sections[section]
        
        switch sectionType {
            case let .notice(models):
                return models.count
            case let .option(models):
                return models.count
            case let .license(models):
                return models.count
            case let .appVersion(models):
                return models.count
            case .accountActions:
                return 1
            case .admob:
                return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sectionType = settingViewModel.sections[indexPath.section]
        
        switch sectionType {
            case let .notice(models):
                let cell = tableView.dequeueReusableCell(withIdentifier: NoticeCell.id, for: indexPath) as! NoticeCell
                cell.prepare(leftTitleText: models[indexPath.row].title)
                return cell
                
            case let .option(models):
                let cell = tableView.dequeueReusableCell(withIdentifier: OptionCell.id, for: indexPath) as! OptionCell
                cell.prepare(leftTitleText: models[indexPath.row].title)
                return cell
                
            case let .license(models):
                let cell = tableView.dequeueReusableCell(withIdentifier: LicenseCell.id, for: indexPath) as! LicenseCell
                cell.prepare(leftTitleText: models[indexPath.row].title)
                return cell
                
            case let .appVersion(models):
                let cell = tableView.dequeueReusableCell(withIdentifier: AppVersionCell.id, for: indexPath) as! AppVersionCell
                let model = models[indexPath.row]
                cell.prepare(leftTitleText: model.leftTitle, rightTitleText: model.rightTitle)
                return cell
                
            case let .accountActions(models):
                let cell = tableView.dequeueReusableCell(withIdentifier: AccountSettingCell.id, for: indexPath) as! AccountSettingCell
                cell.prepare(with: models[indexPath.row])
                cell.logoutAction = settingViewModel.logoutAction
                cell.withdrawAction = settingViewModel.withdrawAction
                cell.selectionStyle = .none
                return cell
                
            case .admob:
                return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView().then {
            $0.backgroundColor = .clear
        }
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == settingViewModel.sections.firstIndex(where: { (sectionType) -> Bool in
            if case .appVersion = sectionType {
                return true
            }
            return false
        }) {
            return 0.1
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView().then {
            $0.backgroundColor = .clear
        }
        return footerView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        let sectionType = settingViewModel.sections[section]
        if case .appVersion = sectionType {
            return 0
        }
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sectionType = settingViewModel.sections[indexPath.section]
        switch sectionType {
            case let .notice(models):
                let _ = models[indexPath.row]
                let noticeVC = NoticeListVC()
                self.navigationController?.pushViewController(noticeVC, animated: true)
                tableView.deselectRow(at: indexPath, animated: true)
                break
            case .option(let models):
                let option = models[indexPath.row]
                switch option.title {
                    case "위치 기반 서비스 이용 동의 설정":
                        let _ = models[indexPath.row]
                        let locationSettingVC = LocationSettingVC()
                        self.navigationController?.pushViewController(locationSettingVC, animated: true)
                        break
                    case "App Store 리뷰하기":
                        if let appStoreReviewURL = URL(string: "https://apps.apple.com/kr/app/%EC%8A%A4%ED%84%B0%EB%94%94%EC%9C%97%EB%AF%B8/id6446102842") {
                            UIApplication.shared.open(appStoreReviewURL, options: [:], completionHandler: nil)
                        }
                        break
                    default:
                        break
                }
            case .license(let models):
                let license = models[indexPath.row]
                switch license.title {
                    case "개인정보처리방침":
                        if let privacyPolicyNotionUrl = URL(string: "https://ryuwon-project.notion.site/85489d7d5167465dbe7552a219ece420?pvs=4") {
                            let ppNotionSafariView = SFSafariViewController(url: privacyPolicyNotionUrl)
                            present(ppNotionSafariView, animated: true, completion: nil)
                        }
                        break
                    case "서비스 이용약관":
                        if let termsOfUseNotionUrl = URL(string: "https://ryuwon-project.notion.site/d47f7ee67b974d7da381d24a4ffa8bc2?pvs=4") {
                            let touNotionSafariView = SFSafariViewController(url: termsOfUseNotionUrl)
                            present(touNotionSafariView, animated: true, completion: nil)
                        }
                        break
                    case "오픈소스 라이선스":
                        if let openSourceNotionUrl = URL(string: "https://ryuwon-project.notion.site/d8a03bad5af24fecbeb01c558fd9912b?pvs=4") {
                            let opNotionSafariView = SFSafariViewController(url: openSourceNotionUrl)
                            present(opNotionSafariView, animated: true, completion: nil)
                        }
                        break
                    default:
                        break
                }
            case .appVersion:
                return
            case .accountActions:
                break
            case .admob:
                // AdMob 로직
                return
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
