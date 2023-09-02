import UIKit
import CoreLocation

struct House: Codable {
    
//        @DocumentID가 붙은 경우 Read시 해당 문서의 ID를 자동으로 할당
//        @DocumentID var documentID: String?
    
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
