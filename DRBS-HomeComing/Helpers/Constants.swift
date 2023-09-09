import UIKit


struct Constant {
    static let appColor: UIColor = UIColor(red: 0.12, green: 0.27, blue: 0.56, alpha: 1.00)
    static let font = "Pretendard-Bold"
    static let fontRegular = "Pretendard-Regular"
    static let fontMedium = "Pretendard-Medium"
    static let fontSemiBold = "Pretendard-SemiBold"
    enum Identifier: String {
        case houseCell = "HouseCell"
        case apartCell = "ApartCell"
        case oneroomCell = "OneroomCell"
        case villaCell = "VillaCell"
        case bookmarkCell = "BookMarkCell"
        case searchCell = "SearchCell"
        case detailCell = "DetailCell"
        case annotationView = "AnnotaionView"
        case bookmarkedAnnotationView = "BookMarkedAnnotationView"
        case topCell = "TopCell"
    }
   
}

class KeyedButton: UIButton {
    var key: String?
}
open class DynamicStatusBarNavigation: UINavigationController {
    override open var childForStatusBarStyle: UIViewController? {
        return topViewController
    }
}
