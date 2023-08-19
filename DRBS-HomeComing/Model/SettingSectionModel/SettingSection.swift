import UIKit

enum SettingSection {
    case notice([NoticeModel])
    case option([OptionModel])
    case license([LicenseModel])
    case appVersion([AppVersionModel])
    case accountActions([AccountActionModel])
    case admob(AdmobModel)
}

struct NoticeModel {
    let title: String?
}

struct OptionModel {
    let title: String?
}

struct LicenseModel {
    let title: String?
}

struct AppVersionModel {
    let leftTitle: String?
    let rightTitle: String?
}

struct AccountActionModel {
    let logoutTitle: String
    let withdrawTitle: String
    let logoutAction: () -> Void
    let withdrawAction: () -> Void
}

struct AdmobModel {
    let adUnitID: String
    // 추후에 추가적인 정보나 설정을 포함할 때 추가
}
