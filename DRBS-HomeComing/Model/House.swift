import UIKit
import MapKit
import CoreLocation

class House: NSObject, Codable, MKAnnotation {
    
    var coordinate: CLLocationCoordinate2D
    var uid: String?                        //유저ID
    var houseId: String?                    //부동산모델 Id
    var title: String?                      //타이틀
    var isBookMarked: Bool?                 //북마크여부
    var livingType: String?                 //주거 ex) 아파트, 원룸 등..
    var tradingType: String?                //주거형태 ex) 월세 분양 매매 등
    var address: String?                    //주소    ex) 서울특별시 ~~
    var latitude: Double?                   //위도
    var longitude: Double?                  //경도
    var 보증금: String?
    var 월세: String?
    var 관리비: String?
    var 관리비미포함목록: [String]?
    var 면적: String?
    var 입주가능일: String?
    var 계약기간: String?
    var 체크리스트: CheckList?
    var 기록: String?
    var 사진: [String]?                   //imageUrl
    var 별점: Double?
    var noneMaintenanceList: [String] = []
    
    // 외부에서 입력값을 받아 초기화하는 이니셜라이저
    init(uid: String? = nil, houseId: String? = nil, title: String? = nil, isBookMarked: Bool? = nil, livingType: String? = nil, tradingType: String? = nil, address: String? = nil, latitude: Double? = nil, longitude: Double? = nil, 보증금: String? = nil, 월세: String? = nil, 관리비: String? = nil, 관리비미포함목록: [String]? = nil, 면적: String? = nil, 입주가능일: String? = nil, 계약기간: String? = nil, 체크리스트: CheckList? = nil, 기록: String? = nil, 사진: [String]? = nil, 별점: Double? = nil, noneMaintenanceList: [String]) {
        
        // 입력값으로 받은 위도와 경도를 사용하여 coordinate 초기화
        if let latitude = latitude, let longitude = longitude {
            self.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        } else {
            self.coordinate = CLLocationCoordinate2D(latitude: 0, longitude: 0) // 기본값
        }
        
        self.uid = uid
        self.houseId = houseId
        self.title = title
        self.isBookMarked = isBookMarked
        self.livingType = livingType
        self.tradingType = tradingType
        self.address = address
        self.latitude = latitude
        self.longitude = longitude
        self.보증금 = 보증금
        self.월세 = 월세
        self.관리비 = 관리비
        self.관리비미포함목록 = 관리비미포함목록
        self.면적 = 면적
        self.입주가능일 = 입주가능일
        self.계약기간 = 계약기간
        self.체크리스트 = 체크리스트
        self.기록 = 기록
        self.사진 = 사진
        self.별점 = 별점
    }
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.coordinate = CLLocationCoordinate2D(
            latitude: try container.decodeIfPresent(Double.self, forKey: .latitude) ?? 0,
            longitude: try container.decodeIfPresent(Double.self, forKey: .longitude) ?? 0
        )
        
        self.uid = try container.decodeIfPresent(String.self, forKey: .uid)
        self.houseId = try container.decodeIfPresent(String.self, forKey: .houseId)
        self.title = try container.decodeIfPresent(String.self, forKey: .title)
        self.isBookMarked = try container.decodeIfPresent(Bool.self, forKey: .isBookMarked)
        self.livingType = try container.decodeIfPresent(String.self, forKey: .livingType)
        self.tradingType = try container.decodeIfPresent(String.self, forKey: .tradingType)
        self.address = try container.decodeIfPresent(String.self, forKey: .address)
        self.latitude = try container.decodeIfPresent(Double.self, forKey: .latitude)
        self.longitude = try container.decodeIfPresent(Double.self, forKey: .longitude)
        self.보증금 = try container.decodeIfPresent(String.self, forKey: .보증금)
        self.월세 = try container.decodeIfPresent(String.self, forKey: .월세)
        self.관리비 = try container.decodeIfPresent(String.self, forKey: .관리비)
        self.관리비미포함목록 = try container.decodeIfPresent([String].self, forKey: .관리비미포함목록)
        self.면적 = try container.decodeIfPresent(String.self, forKey: .면적)
        self.입주가능일 = try container.decodeIfPresent(String.self, forKey: .입주가능일)
        self.계약기간 = try container.decodeIfPresent(String.self, forKey: .계약기간)
        self.체크리스트 = try container.decodeIfPresent(CheckList.self, forKey: .체크리스트)
        self.기록 = try container.decodeIfPresent(String.self, forKey: .기록)
        self.사진 = try container.decodeIfPresent([String].self, forKey: .사진)
        self.별점 = try container.decodeIfPresent(Double.self, forKey: .별점)
    }
    
    enum CodingKeys: String, CodingKey {
        // 왼쪽: Project에서 사용하는 이름, 오른쪽 : Firebase에서 사용될 이름
        
        case uid =          "uid"
        case houseId =      "houseId"
        case title =        "title"
        case isBookMarked = "isBookMarked"
        case livingType =   "livingType"
        case tradingType =  "tradingType"
        case address =      "address"
        case latitude =     "latitude"
        case longitude =    "longitude"
        case 보증금 =         "deposit"
        case 월세 =           "rent_payment"
        case 관리비 =          "maintenance_fee"
        case 관리비미포함목록 =   "maintenance_non_list"
        case 면적 =           "area"
        case 입주가능일 =        "movingDay"
        case 계약기간 =         "contractTerm"
        case 체크리스트 =        "checkList"
        case 기록 =           "memo"
        case 사진 =           "photos"
        case 별점 =           "rate"
    }
    
}
