import UIKit
import Then
import SnapKit
import MessageUI
import GoogleMobileAds

final class SettingVC: UIViewController {
    
    // MARK: - Properties
    
    private lazy var settingViewModel = SettingsViewModel()
    private lazy var authVM: AuthViewModel = AuthViewModel()
    
    private let bannerView = GADBannerView(adSize: GADCurrentOrientationAnchoredAdaptiveBannerAdSizeWithWidth(UIScreen.main.bounds.width))
    
    private let settingTableView = UITableView(frame: .zero, style: .grouped).then {
        $0.register(NoticeCell.self, forCellReuseIdentifier: NoticeCell.id)
        $0.register(OptionCell.self, forCellReuseIdentifier: OptionCell.id)
        $0.register(LicenseCell.self, forCellReuseIdentifier: LicenseCell.id)
        $0.register(AppVersionCell.self, forCellReuseIdentifier: AppVersionCell.id)
        $0.register(AccountSettingCell.self, forCellReuseIdentifier: AccountSettingCell.id)
        $0.separatorStyle = .none
    }
    
    // MARK: - View Lifecycle
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        
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
        configureNav()
        bannerView.load(GADRequest())
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
    
    private func configureUI() {
        view.backgroundColor = settingTableView.backgroundColor

        settingTableView.dataSource = self
        settingTableView.delegate = self
        bannerView.delegate = self
        
        view.addSubviews(settingTableView, bannerView)
        
        bannerView.adUnitID = "ca-app-pub-5665531154477823/9914288196"
        bannerView.rootViewController = self
        bannerView.backgroundColor = settingTableView.backgroundColor

        bannerView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-30)
        }
        
        settingTableView.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
            $0.bottom.equalTo(bannerView.snp.top)
        }
    }
    
    // MARK: - Actions
    
    private func showLogoutAlert() {
        let alertController = UIAlertController(title: nil, message: "로그아웃 하시겠습니까?", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "예", style: .default, handler: { [self] _ in
            authVM.authLogout()
            //화면 전환
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
                    case "문의하기":
                        if MFMailComposeViewController.canSendMail() {
                            let mailComposerVC = MFMailComposeViewController()
                            mailComposerVC.mailComposeDelegate = self
                            mailComposerVC.setToRecipients(["iero.drbs@gmail.com"])
                            mailComposerVC.setSubject("문의하기")
                            self.present(mailComposerVC, animated: true, completion: nil)
                        } else {
                            let alertController = UIAlertController(title: "메일을 보낼 수 없습니다.", message: "기기에서 이메일을 보낼 수 없습니다. 메일 설정을 확인 해주세요.", preferredStyle: .alert)
                            alertController.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
                            self.present(alertController, animated: true, completion: nil)
                        }
                        break
                    case "App Store 리뷰하기":
                        if let appStoreReviewURL = URL(string: "https://apps.apple.com/kr/app/%EB%8F%84%EB%9D%BC%EB%B0%A9%EC%8A%A4/id6466733709") {
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
                        if let privacyPolicyNotionUrl = URL(string: "https://iero-drbs.notion.site/9ee322c4343a4a2380570f4452190105?pvs=4") {
                            UIApplication.shared.open(privacyPolicyNotionUrl)
                        }
                        break
                    case "서비스 이용약관":
                        if let termsOfUseNotionUrl = URL(string: "https://iero-drbs.notion.site/452e33f0341945efb952d72658904e1e?pvs=4") {
                            UIApplication.shared.open(termsOfUseNotionUrl)
                        }
                        break
                    case "오픈소스 라이선스":
                        if let openSourceNotionUrl = URL(string: "https://iero-drbs.notion.site/5871edcf252647b3b0913a50881bcc6e?pvs=4") {
                            UIApplication.shared.open(openSourceNotionUrl)
                        }
                        break
                    default:
                        break
                }
            case .appVersion:
                return
            case .accountActions:
                return
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

// MARK: - MFMailComposeViewControllerDelegate

extension SettingVC: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
}

// MARK: - GADBannerViewDelegate

extension SettingVC: GADBannerViewDelegate {
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
        bannerView.alpha = 0
        UIView.animate(withDuration: 1) {
            bannerView.alpha = 1
        }
    }
    
    func bannerView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: Error) {
        bannerView.isHidden = true
    }
}
