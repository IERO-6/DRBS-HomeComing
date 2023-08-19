import UIKit

//struct CheckVC1Model {
    struct Information {
        var name: String = ""
        var 거래방식: TransactionMethod = .none
        var 주거형태: DwellingType = .none
        var 주소: String = ""
    }
    
    enum TransactionMethod {
        case 월세
        case 전세
        case 매매
        case none
    }
    
    enum DwellingType {
        case 아파트
        case 투룸
        case 오피스텔
        case 원룸
        case none
    }
//}
