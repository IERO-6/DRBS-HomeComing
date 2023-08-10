import UIKit
import CoreLocation

class LocationViewModel {
    //MARK: - Model
    var locationModel: Location?
    /* 뷰컨은 뷰모델이 소유한 데이터를 표기해야하기 때문에
       뷰모델은 뷰컨이 소유한 데이터와 관련있는 값도 가져야 함 */
    
    let locationManager = CLLocationManager()
    
    
    
    
    
    //MARK: - Output
    
    
    
    //MARK: - Input


    
    
    //MARK: - Logics
    func checkUserDeviceLocationServiceAuthorization() {
        // 디바이스 자체 위치 서비스가 활성화인지 확인
        
        DispatchQueue.global().async {
            guard CLLocationManager.locationServicesEnabled() else {
                self.showRequestLocationServiceAlert()
                return
            }
            
            // 앱의 권한 상태를 가져오는 코드
           
        }
        let authorizationStatus: CLAuthorizationStatus = self.locationManager.authorizationStatus
        
        /*
         CLAuthorizationStatus (권한 상태를 나타내는 열거형 타입)
         .notDeterminded: 사용자가 권한에 대한 설정을 선택하지 않은 상태
         .restricted    : 위치 서비스에 대한 권한이 없는 상태/자녀 보호기능과 같은 상황으로 디바이스 자체 활성화 제한 상태
         .denined       : 사용자가 앱에 대한 권한을 거부한 상태
         : 권한을 승인했다가 추후에 위치 서비스 비활성화한 경우
         : 사용자가 디바이스 전체에 대한 위치 서비스를 비활성화한 경우
         : 비행기 모드와 같은 상황으로, 위치 서비스를 이용할 수 없는 상황
         .authorizedAlways   : 앱이 백그라운드 상태에서도 위치 서비스를 이용할 수 있도록 승인된 상태
         .authorizedWhenInUse: 앱이 포그라운드 상태에서만 위치 서비스를 이용할 수 있도록 승인된 상태
         */
        
        
        
        // 권한 상태값에 따라 분기처리를 수행하는 메서드 실행
        self.checkUserCurrentLocationAuthorization(authorizationStatus)
        
    }
    
    
    
    
    
    func showRequestLocationServiceAlert() {
        let requestLocationServiceAlert = UIAlertController(title: "위치 정보 이용", message: "위치 서비스를 사용할 수 없습니다.\n디바이스의 '설정 > 개인정보 보호'에서 위치 서비스를 켜주세요.", preferredStyle: .alert)
           let goSetting = UIAlertAction(title: "설정으로 이동", style: .destructive) { _ in
               if let appSetting = URL(string: UIApplication.openSettingsURLString) {
                   UIApplication.shared.open(appSetting)
               }
           }
           let cancel = UIAlertAction(title: "취소", style: .default) { [weak self] _ in
//               async { await self?.reloadData() }
           }
           requestLocationServiceAlert.addAction(cancel)
           requestLocationServiceAlert.addAction(goSetting)
           
//           present(requestLocationServiceAlert, animated: true)
    }
    
    func checkUserCurrentLocationAuthorization(_ status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            // 사용자가 권한에 대한 설정을 선택하지 않은 상태
            
            // 권한 요청을 보내기 전에 desiredAccuracy 설정 필요
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            
            /*
             desiredAccuracy (위치 데이터의 정확도 설정) - 정확할수록 배터리 소모 많음
             
             KCLLocationAccuracyBest            : 가능한 최고 수준의 정확도
             KCLLocationAccuracyKilometer       : 킬로미터 기준의 정확도
             KCLLocationAccuracyThreeKilometers : 3킬로미터 기준의 정확도
             
             */
            
            
            
            // 권한 요청을 보낸다.
            locationManager.requestWhenInUseAuthorization()
            
        case .denied, .restricted:
            // 사용자가 명시적으로 권한을 거부했거나, 위치 서비스 활성화가 제한된 상태
            // 시스템 설정에서 설정값을 변경하도록 유도한다.
            // 시스템 설정으로 유도하는 커스텀 얼럿
            showRequestLocationServiceAlert()
            
        case .authorizedWhenInUse:
            // 앱을 사용중일 때, 위치 서비스를 이용할 수 있는 상태
            // manager 인스턴스를 사용하여 사용자의 위치를 가져온다.
            locationManager.startUpdatingLocation()
            
        default:
            print("Default")
        }
    }
    
    
}

