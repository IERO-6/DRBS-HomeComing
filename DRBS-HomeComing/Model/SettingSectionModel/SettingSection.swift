import UIKit

enum SettingSection {
    case notice([NoticeModel])
    case option([OptionModel])
    case license([LicenseModel])
    case appVersion([AppVersionModel])
    case accountActions([AccountActionModel])
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
