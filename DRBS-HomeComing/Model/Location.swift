import UIKit
import MapKit

struct Location {
    //지도에서 사용될 모델, 모델은 앱의 정체성! 절대 변하지 않는 데이터들의 집합
    //중복을 최대한 피하고 모델을 봤을 때, 앱이 어떤 데이터를 필요로 하고 어떤 기능을 제공할지 예측가능해야함

    var latitude: String        //위도
    var longitude: String       //경도
    var isBookMarked: Bool      //북마크여부 => 전체 모델에서 가져올지 따로 변수로 만들지 고민중
//    var house: House?
    // House 모델도 소유해야함
    
    
}


