import UIKit


struct Constant {
    static let appColor: UIColor = UIColor(red: 0.12, green: 0.27, blue: 0.56, alpha: 1.00)
    static let font = "Pretendard-Bold"
    enum Identifier: String {
        case houseCell = "HouseCell"
        case apartCell = "ApartCell"
        case oneroomCell = "OneroomCell"
        case officeCell = "OfficeCell"
        case searchCell = "SearchCell"
        case annotationView = "AnnotaionView"
        case bookmarkedAnnotationView = "BookMarkedAnnotationView"
    }
    
    enum 주거: String {
        case 아파트
        case 원룸
        case 오피스텔
        case 주택
    }
    
    enum 주거형태: String {
        case 월세
        case 전세
        case 매매
        case 분양
    }
    
    enum 관리비미포함목록: String {
        case 인터넷
        case 전기세
        case 수도세
        case 가스비
        case 기타
    }
    
    enum 방향: String {
        case 남향
        case 동향
        case 북향
        case 서향
    }
   
}

