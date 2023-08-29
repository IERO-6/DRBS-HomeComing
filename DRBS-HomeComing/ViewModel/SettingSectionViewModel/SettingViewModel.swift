import UIKit

class SettingsViewModel {

    //MARK: - Model
    
    var sections: [SettingSection] = []

    //MARK: - Output
    
    var logoutAction: (() -> Void)?
    var withdrawAction: (() -> Void)?
    
    //MARK: - Input
    
    init() {
        configureSections()
    }
    
    //MARK: - Logics

    private func configureSections() {
        let notice = [NoticeModel(title: "공지사항")]

        let options = [
            OptionModel(title: "문의하기"),
            OptionModel(title: "App Store 리뷰하기")
        ]

        let licenses = [
            LicenseModel(title: "개인정보처리방침"),
            LicenseModel(title: "서비스 이용약관"),
            LicenseModel(title: "오픈소스 라이선스")
        ]

        let version = AppVersionModel(leftTitle: "앱 버전", rightTitle: retrieveAppVersion())

        let accountActionsModel = AccountActionModel(
            logoutTitle: "로그아웃",
            withdrawTitle: "회원탈퇴",
            logoutAction: { [weak self] in
                self?.logoutAction?()
            },
            withdrawAction: { [weak self] in
                self?.withdrawAction?()
            }
        )
        
        let admob = AdmobModel(adUnitID: "YOUR_AD_UNIT_ID_HERE")

        sections = [
            .notice(notice),
            .option(options),
            .license(licenses),
            .appVersion([version]),
            .accountActions([accountActionsModel]),
            .admob(admob)
        ]
    }

    private func retrieveAppVersion() -> String? {
        guard let dictionary = Bundle.main.infoDictionary,
              let version = dictionary["CFBundleShortVersionString"] as? String,
              let build = dictionary["CFBundleVersion"] as? String else {
            return nil
        }
        return "\(version).\(build)"
    }
}
