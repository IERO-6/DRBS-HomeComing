import UIKit
import MapKit

class Location: NSObject, MKAnnotation {
    //Location 모델로 어노테이션 한 번에 해결
    //지도에서 사용될 모델, 모델은 앱의 정체성! 절대 변하지 않는 데이터들의 집합
    //중복을 최대한 피하고 모델을 봤을 때, 앱이 어떤 데이터를 필요로 하고 어떤 기능을 제공할지 예측가능해야함

    var coordinate: CLLocationCoordinate2D
    var isBookMarked: Bool      //북마크여부 => 전체 모델에서 가져올지 따로 변수로 만들지 고민중
    
    init(coordinate: CLLocationCoordinate2D, isBookMarked: Bool) {
        self.coordinate = coordinate
        self.isBookMarked = isBookMarked
    }
    
    
}


