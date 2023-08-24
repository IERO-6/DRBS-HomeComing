import UIKit
import CoreLocation

struct House: Codable {
    var uid: String?                        //유저ID
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
    var 입주가능일: Date?
    var 계약기간: String?
    var 체크리스트: CheckList?
    var 기록: String?
    var 사진: [String]?                   //imageUrl
    var 별점: Double?
}
