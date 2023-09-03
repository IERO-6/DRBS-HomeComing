import UIKit
import CoreLocation
import MapKit
import Then
import SnapKit


final class MapVC: UIViewController {
    //MARK: - Properties
    lazy var houseViewModel = HouseViewModel()
    
    private lazy var mkMapView = MKMapView(frame: self.view.frame)
    
    private lazy var locationManager = CLLocationManager()
    
    private lazy var currentLocationButton = UIButton().then {
        $0.setImage(UIImage(systemName: "location"), for: .normal)
        $0.backgroundColor = .white
        $0.clipsToBounds = true
        $0.tintColor = .darkGray
        $0.addTarget(self, action: #selector(currentLocationTapped), for: .touchUpInside)
    }
    
    private lazy var separateLine = UIView().then {$0.backgroundColor = .darkGray}

    private lazy var searchButton = UIButton().then {
        $0.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        $0.backgroundColor = .white
        $0.clipsToBounds = true
        $0.tintColor = .darkGray
        $0.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
    }
    
    private lazy var stackView = UIStackView().then {
        $0.spacing = 0
        $0.axis = .vertical
        $0.distribution = .fill
        $0.alignment = .fill
        $0.clipsToBounds = true
        $0.layer.cornerRadius = self.view.frame.width/30
    }
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        checkDeviceService()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    //MARK: - Helpers
    private func configureUI() {
        stackView.addArrangedSubviews(currentLocationButton, separateLine, searchButton)
        view.addSubviews(mkMapView, stackView)
        currentLocationButton.snp.makeConstraints{
            $0.width.equalToSuperview()
            $0.height.equalTo(stackView.snp.width)
            $0.top.equalTo(stackView.snp.top)}
        searchButton.snp.makeConstraints{
            $0.width.equalToSuperview()
            $0.bottom.equalTo(stackView.snp.bottom)}
        separateLine.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.width.equalTo(stackView.snp.width)
            $0.leading.trailing.equalToSuperview()}
        stackView.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(10)
            $0.trailing.equalToSuperview().offset(-10)
            $0.width.equalTo(self.view.frame.width/8)
            $0.height.equalTo(self.view.frame.width/4)
        }
    }
    
    private func settingMKMapView() {
        //MKMapView설정
        self.mkMapView.isPitchEnabled = false
        self.mkMapView.isRotateEnabled = false
        self.mkMapView.delegate = self
        self.locationManager.delegate = self
        self.mkMapView.register(AnnotationView.self, forAnnotationViewWithReuseIdentifier: Constant.Identifier.annotationView.rawValue)
        self.mkMapView.showsUserLocation = true
        self.mkMapView.setUserTrackingMode(.follow, animated: true)
        DispatchQueue.main.async {
            //최초에 전체 어노테이션 추가하기
            for customPin in self.houseViewModel.myHouses() { self.mkMapView.addAnnotation(customPin) }
        }
    }
    
    
    private func removeAllAnnotations() {
        let annotations = mkMapView.annotations
        if !annotations.isEmpty {
            for annotation in annotations {
                mkMapView.removeAnnotation(annotation)
            }
        }
    }
    
    //MARK: - 권한설정탭(아마불변)
    private func checkDeviceService() {
        DispatchQueue.global(qos: .userInitiated).async {
            guard CLLocationManager.locationServicesEnabled() else {
                self.goSettingAlert()
                return
            }
            let authStatus = self.locationManager.authorizationStatus
            self.checkCurrentLocationAuth(authStatus)
        }
    }
    
    private func checkCurrentLocationAuth(_ status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
            self.locationManager.requestWhenInUseAuthorization()
        case .restricted, .denied:
            self.goSettingAlert()
        case .authorizedWhenInUse, .authorizedAlways:
            settingMKMapView()
            self.locationManager.startUpdatingLocation()
            self.mkMapView.showsUserLocation = true
            self.mkMapView.setUserTrackingMode(.follow, animated: true)
        default:
            print("디버깅: default")
        }
    }
    
    
    //MARK: - Actions
    @objc func currentLocationTapped() {
        let status = self.locationManager.authorizationStatus
        switch status {
        case .notDetermined:
            self.goSettingAlert()
        case .restricted, .denied:
            self.goSettingAlert()
        case .authorizedWhenInUse, .authorizedAlways:
            self.locationManager.startUpdatingLocation()
            self.mkMapView.showsUserLocation = true
            self.mkMapView.setUserTrackingMode(.follow, animated: true)
        default:
            print("디버깅: default")
        }
    }
    
    @objc func searchButtonTapped() {
        let searchVC = SearchVC()
        searchVC.searchViewDelegate = self
        navigationController?.pushViewController(searchVC, animated: true)
    }
}

//MARK: - MKMapViewDelegate
extension MapVC: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        let modalVC = ModalVC()
        modalVC.modalPresentationStyle = .pageSheet
        present(modalVC, animated: true)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        // 커스텀 어노테이션 뷰 설정
        guard let annotation = annotation as? House else {return nil}
        var annotationView = self.mkMapView.dequeueReusableAnnotationView(withIdentifier: Constant.Identifier.annotationView.rawValue)
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: Constant.Identifier.annotationView.rawValue)
            annotationView?.canShowCallout = false
            annotationView?.contentMode = .scaleAspectFit
        } else { annotationView?.annotation = annotation }
        let annotationImage: UIImage!
        switch annotation.isBookMarked {
        case true:
            annotationImage = UIImage(named: "testb1.png")
        case false:
            annotationImage = UIImage(named: "test1.png")
        default:
            annotationImage = UIImage()
        }
//        annotationImage.draw(in: CGRect(x: 0, y: 0, width: 20, height: 20))
        annotationView?.image = annotationImage
        return annotationView
    }
    
    
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        let currentRegion = mkMapView.region
        mapView.limitRegionToKorea(currentRegion: currentRegion)
        self.houseViewModel.currentVisible(region: mapView.region)
        DispatchQueue.main.async {
            mapView.removeAnnotations(self.houseViewModel.willDeleteHouses)
            for customPin in self.houseViewModel.visibleHouses {
                mapView.addAnnotation(customPin)
            }
        }
    }
}
//MARK: - CLLocationManagerDelegate
extension MapVC: CLLocationManagerDelegate {
    // 사용자의 위치를 성공적으로 가져왔을 때 호출
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let koreaCoordinateRegion = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 36.5, longitude: 127.5), // 대한민국 중심 좌표
            span: MKCoordinateSpan(latitudeDelta: 5.0, longitudeDelta: 5.0) // 지도 확대 정도
        )
        
        // MKMapView에 설정한 좌표 범위를 적용합니다.
        mkMapView.setRegion(koreaCoordinateRegion, animated: false)
        // startUpdatingLocation()을 사용하여 사용자 위치를 가져왔다면
        // 불필요한 업데이트를 방지하기 위해 stopUpdatingLocation을 호출
        locationManager.stopUpdatingLocation()
    }
    
    // 사용자가 GPS 사용이 불가한 지역에 있는 등 위치 정보를 가져오지 못했을 때 호출
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(#function)}
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        // 사용자 디바이스의 위치 서비스가 활성화 상태인지 확인하는 메서드 호출
        print(#function)
        checkDeviceService()
    }
    
}

extension MapVC: searchViewDelegate {
    func setRegion(cood: CLLocationCoordinate2D) {
        self.mkMapView.setRegion(.init(center: cood, span: .init(latitudeDelta: 0.1, longitudeDelta: 0.1)), animated: true)
    }
    
    
}
