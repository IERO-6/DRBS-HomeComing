/*
 ################################################################
 #                        #                                     #
 #  ⭐️뷰모델이 모델을 소유⭐️   # ⭐️사용자와 상호작용하는 로직도 뷰모델이 소유⭐️ #
 #                        #                                     #
 ################################################################
 */
import CoreLocation
import UIKit

class HouseViewModel {
    //MARK: - Model
    var house: House?
    /* 뷰컨은 뷰모델이 소유한 데이터를 표기해야하기 때문에
       뷰모델은 뷰컨이 소유한 데이터와 관련있는 값도 가져야 함 */
    
    var name: String?
    var trade: String?
    var living: String?
    var address: CLLocationCoordinate2D?
    
    
    //MARK: - Output
    
    
    
    //MARK: - Input


    
    
    
    //MARK: - Logics
    func blahblah() {
        
    }

}
