import UIKit
import CoreLocation
import MapKit

protocol MapDelegate: AnyObject {
    func cordHandler(with: Location)
}


final class MapVC: UIViewController {
    //MARK: - Properties
    
    
    private var locationViewModel: LocationViewModel!
    
    
    private lazy var mkMapView = MKMapView(frame: self.view.frame)
    private var locationManager = CLLocationManager()
    private var currentLocation: CLLocation = CLLocation(latitude: 37.332651635682176, longitude: 127.11873405786073)
    var location: Location? {
        didSet {
            guard let location = location else { return }
            self.mkMapView.setCenter(CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude), animated: true)
        }
    }
    
    private lazy var currentLocationButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "location"), for: .normal)
        button.backgroundColor = .white
        button.clipsToBounds = true
        //        button.layer.cornerRadius = 5
        button.tintColor = .gray
        button.addTarget(self, action: #selector(currentLocationTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var searchButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        button.backgroundColor = .white
        button.clipsToBounds = true
        //        button.layer.cornerRadius = 5
        button.tintColor = .gray
        button.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 0
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.alignment = .fill
        stack.clipsToBounds = true
        stack.layer.cornerRadius = 10
        return stack
    }()
    
    let mark = Marker(
        title: "무지개마을",
        subtitle: "아파트",
        coordinate: CLLocationCoordinate2D(latitude: 37.33511535552606, longitude: 127.11933035555937))
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        settingMKMapView()
        settingCLLocationManager()
        checkUserDeviceLocationServiceAuthorization()
    }
    
    //MARK: - Helpers
    
    func configureUI() {
        view.addSubview(mkMapView)
        view.addSubview(stackView)
        stackView.addArrangedSubview(currentLocationButton)
        stackView.addArrangedSubview(searchButton)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 0),
            stackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10),
            stackView.widthAnchor.constraint(equalToConstant: 40),
            stackView.heightAnchor.constraint(equalToConstant: 80)
        ])
    }
    
    func settingMKMapView() {
        self.mkMapView.delegate = self
        self.mkMapView.showsUserLocation = true
        self.mkMapView.setRegion(MKCoordinateRegion(center:  CLLocationCoordinate2D(latitude: 37.57273458434912, longitude: 126.97784685534123), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)), animated: true)
        self.mkMapView.addAnnotation(mark)
        // mapKit.zoomEnabled = false         // 줌 가능 여부
        // mapKit.scrollEnabled = false       // 스크롤 가능 여부
        // mapKit.rotateEnabled = false       // 회전 가능 여부
        // mapKit.pitchEnabled = false        // 각도 가능 여부
        
        
    }
    
    func settingCLLocationManager() {
        locationManager.delegate = self
        //        locationManager.desiredAccuracy = kCLLocationAccuracyBest   // 정확도 최상 설정
        //        locationManager.requestWhenInUseAuthorization()             // 위치 데이터 승인 요구
        //        locationManager.startUpdatingLocation()                     // 위치 업데이트 시작
        //        self.currentLocation = locationManager.location
        
        
        
    }
    
    func checkUserDeviceLocationServiceAuthorization() {
        // 디바이스 자체 위치 서비스가 활성화인지 확인
//        switch CLLocationManager.authorizationStatus() {
//        case
//        }
        
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
           
           present(requestLocationServiceAlert, animated: true)
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
    
    func markAction() {
        
    }
    
    
    //MARK: - Actions
    
    @objc func currentLocationTapped() {
        print("디버깅: 현재위치 버튼 눌림")
        self.mkMapView.showsUserLocation = true
        self.mkMapView.setUserTrackingMode(.follow, animated: true)
        
    }
    
    @objc func searchButtonTapped() {
        print("디버깅: 검색 버튼 눌림")
        let searchVC = SearchVC()
        searchVC.mapDelegate = self
        navigationController?.pushViewController(searchVC, animated: true)
    }
}

//MARK: - Extension

extension MapVC: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        print("디버깅: AnnotationView")
        let modalVC = ModalVC()
        modalVC.modalPresentationStyle = .pageSheet
        present(modalVC, animated: true)
    }
    
}



extension MapVC: CLLocationManagerDelegate {
    // 사용자의 위치를 성공적으로 가져왔을 때 호출
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        // 위치 정보를 배열로 입력받는데, 마지막 index값이 가장 정확.
        if let coordinate = locations.last?.coordinate {
            // ⭐️ 사용자 위치 정보 사용
            self.mkMapView.showsUserLocation = true
            self.mkMapView.setUserTrackingMode(.follow, animated: true)
        }
        
        // startUpdatingLocation()을 사용하여 사용자 위치를 가져왔다면
        // 불필요한 업데이트를 방지하기 위해 stopUpdatingLocation을 호출
        locationManager.stopUpdatingLocation()
    }
    
    // 사용자가 GPS 사용이 불가한 지역에 있는 등 위치 정보를 가져오지 못했을 때 호출
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(#function)
    }
    
    
    
    
    // 앱에 대한 권한 설정이 변경되면 호출 (iOS 14 이상)
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        // 사용자 디바이스의 위치 서비스가 활성화 상태인지 확인하는 메서드 호출
        checkUserDeviceLocationServiceAuthorization()
    }
    
}
extension MapVC: MapDelegate {
    func cordHandler(with: Location){
        self.location = with
        
    }
    
}
