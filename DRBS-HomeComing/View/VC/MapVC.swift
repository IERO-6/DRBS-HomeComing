import UIKit
import CoreLocation
import MapKit
import Then
import SnapKit

protocol MapDelegate: AnyObject {
    func cordHandler(with: Location)
}


final class MapVC: UIViewController {
    //MARK: - Properties
    
    //⭐️뷰모델⭐️
    private lazy var locationViewModel = LocationViewModel()
    private lazy var mkMapView = MKMapView(frame: self.view.frame)
    private lazy var locationManager = CLLocationManager()
    private lazy var currentLocation: CLLocation = CLLocation(latitude: 37.332651635682176, longitude: 127.11873405786073)
    var location: Location? {
        didSet {
            guard let location = location else { return }
            self.mkMapView.setCenter(CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude), animated: true)
        }
    }
    
    private lazy var currentLocationButton = UIButton().then {
        $0.setImage(UIImage(systemName: "location"), for: .normal)
        $0.backgroundColor = .white
        $0.clipsToBounds = true
        $0.tintColor = .gray
        $0.addTarget(self, action: #selector(currentLocationTapped), for: .touchUpInside)
    }
    
    private lazy var searchButton = UIButton().then {
        $0.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        $0.backgroundColor = .white
        $0.clipsToBounds = true
        $0.tintColor = .gray
        $0.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
    }
    
    private lazy var separateLine = UIView().then {
        $0.backgroundColor = .systemGray4
    }
    
    private lazy var stackView = UIStackView().then {
        $0.spacing = 0
        $0.axis = .vertical
        $0.distribution = .fill
        $0.alignment = .fill
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 10
    }
    
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
        locationViewModel.checkUserDeviceLocationServiceAuthorization()
    }
    
    //MARK: - Helpers
    
    func configureUI() {
        //화면구성
        stackView.addArrangedSubviews(currentLocationButton, separateLine, searchButton)
        view.addSubviews(mkMapView, stackView)
        currentLocationButton.snp.makeConstraints{$0.height.equalTo(self.view.frame.width/8)}
        searchButton.snp.makeConstraints{$0.height.equalTo(self.view.frame.width/8)}
        separateLine.snp.makeConstraints {$0.height.equalTo(1)}
        stackView.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(10)
            $0.trailing.equalToSuperview().offset(-10)
            $0.width.equalTo(self.view.frame.width/8)
            $0.height.equalTo(self.view.frame.width/4)}}
    
    func settingMKMapView() {
        //MKMapView설정
        self.mkMapView.isPitchEnabled = false        // 각도 가능 여부
        self.mkMapView.delegate = self
        self.mkMapView.showsUserLocation = true
                self.mkMapView.setRegion(MKCoordinateRegion(center:  CLLocationCoordinate2D(latitude: 37.57273458434912, longitude: 126.97784685534123), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)), animated: true)
//        self.mkMapView.addAnnotations([mark])
        self.mkMapView.register(AnnotationView.self, forAnnotationViewWithReuseIdentifier: AnnotationView.identifier)
        let pin = Annotation(isBookMarked: false, coordinate: CLLocationCoordinate2D(latitude: 37.33511535552606, longitude: 127.11933035555937))
        mkMapView.addAnnotation(pin)
        
        // mapKit.zoomEnabled = false         // 줌 가능 여부
        // mapKit.scrollEnabled = false       // 스크롤 가능 여부
        // mapKit.rotateEnabled = false       // 회전 가능 여부
        
        
    }
    
    func settingCLLocationManager() {
    
        locationManager.delegate = self
        //        locationManager.desiredAccuracy = kCLLocationAccuracyBest   // 정확도 최상 설정
        //        locationManager.requestWhenInUseAuthorization()             // 위치 데이터 승인 요구
        //        locationManager.startUpdatingLocation()                     // 위치 업데이트 시작
        //        self.currentLocation = locationManager.location
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
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        guard let annotation = annotation as? Annotation else { return nil}
        var annotationView = self.mkMapView.dequeueReusableAnnotationView(withIdentifier: AnnotationView.identifier)
        
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: AnnotationView.identifier)
            annotationView?.canShowCallout = false
            annotationView?.contentMode = .scaleAspectFit
        } else {
            annotationView?.annotation = annotation
        }
        
        let size = CGSize(width: 30, height: 30)
        UIGraphicsBeginImageContext(size)
        
        switch annotation.isBookMarked {
        case true:
            return annotationView
        case false:
            return annotationView
        }
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
//    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
//        // 사용자 디바이스의 위치 서비스가 활성화 상태인지 확인하는 메서드 호출
//        checkUserDeviceLocationServiceAuthorization()
//    }
    
}
extension MapVC: MapDelegate {
    func cordHandler(with: Location){
        self.location = with
        
        
    }
    
    
    
    
    
}
