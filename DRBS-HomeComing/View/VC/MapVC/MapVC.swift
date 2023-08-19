import UIKit
import CoreLocation
import MapKit
import Then
import SnapKit


// https://co-dong.tistory.com/73 참고중..

final class MapVC: UIViewController {
    //MARK: - Properties
    
    private lazy var locationViewModel = LocationViewModel()
    private lazy var mkMapView = MKMapView(frame: self.view.frame)
    private lazy var locationManager = CLLocationManager()
    
    private lazy var currentLocationButton = UIButton().then {
        $0.setImage(UIImage(systemName: "location"), for: .normal)
        $0.backgroundColor = .white
        $0.clipsToBounds = true
        $0.tintColor = .gray
        $0.addTarget(self, action: #selector(currentLocationTapped), for: .touchUpInside)}
    
    private lazy var searchButton = UIButton().then {
        $0.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        $0.backgroundColor = .white
        $0.clipsToBounds = true
        $0.tintColor = .gray
        $0.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)}
    
    private lazy var separateLine = UIView().then {$0.backgroundColor = .systemGray4}
    
    private lazy var stackView = UIStackView().then {
        $0.spacing = 0
        $0.axis = .vertical
        $0.distribution = .fill
        $0.alignment = .fill
        $0.clipsToBounds = true
        $0.layer.cornerRadius = self.view.frame.width/30}
    
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
            $0.height.equalTo(self.view.frame.width/4)}}
    
    private func settingMKMapView() {
        //MKMapView설정
        self.mkMapView.isPitchEnabled = false
        self.mkMapView.isRotateEnabled = false
        self.mkMapView.delegate = self
        self.mkMapView.register(AnnotationView.self, forAnnotationViewWithReuseIdentifier: Constant.Identifier.annotationView.rawValue)
        self.mkMapView.showsUserLocation = true
        self.mkMapView.setUserTrackingMode(.follow, animated: true)
    }
    
    private func settingCLLocationManager() { locationManager.delegate = self }
    
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
        // 디바이스 자체 위치 서비스 관련 로직
        DispatchQueue.global(qos: .userInitiated).async {
            guard CLLocationManager.locationServicesEnabled() else {
                print("디버깅: 현재 디바이스 위치 서비스 상태는 ❌")
                self.showRequestLocationServiceAlert()
                return}
            print("디버깅: 현재 디바이스의 위치 서비스 상태는 ⭕️")
            let authStatus = self.locationManager.authorizationStatus
            self.checkCurrentLocationAuth(authStatus)}}
    
    private func checkCurrentLocationAuth(_ status: CLAuthorizationStatus) {
        // 디바이스 확인해서 허용이면, CLAuthorizationStatus를 통해 앱 설정
        switch status {
        case .notDetermined:
            print("디버깅: notDetermined")
            // 사용자가 권한에 대한 설정을 선택하지 않은 상태
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            // 권한 요청을 보내기 전에 desiredAccuracy 설정 필요
            locationManager.requestWhenInUseAuthorization()
            print("requestWhenInUseAuthorization 실행됨")
            // 권한 요청을 보낸다.
        case .restricted, .denied:
            // 안심 자녀 서비스 등 위치 서비스 활성화가 제한된 상태
            // 시스템 설정에서 설정값을 변경하도록 유도
            print("디버깅: restricted, denied")
            showRequestLocationServiceAlert()
        case .authorizedWhenInUse:
            print("디버깅: authorizedWhenInUse ")
            settingMKMapView()
            settingCLLocationManager()
            // 앱을 사용중일 때, 위치 서비스를 이용할 수 있는 상태
            // manager 인스턴스를 사용하여 사용자의 위치를 가져온다.
            locationManager.startUpdatingLocation()
        default:
            print("디버깅: default")
        }
    }
    private func showRequestLocationServiceAlert() {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "위치 정보 이용", message: "위치 서비스를 사용할 수 없습니다.\n디바이스의 '설정 > 개인정보 보호'에서 위치 서비스를 켜주세요.", preferredStyle: .alert)
            let goSetting = UIAlertAction(title: "설정으로 이동", style: .default) { _ in
                if let appSetting = URL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(appSetting)
                }
            }
            alert.addAction(goSetting)
            self.present(alert, animated: true)
        }
    }
    
    
    //MARK: - Actions
    @objc func currentLocationTapped() {
        self.checkDeviceService()
    }
    
    @objc func searchButtonTapped() {
        let searchVC = SearchVC()
        navigationController?.pushViewController(searchVC, animated: true)
    }
}

//MARK: - MKMapViewDelegate
extension MapVC: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        let modalVC = ModalVC()
        modalVC.modalPresentationStyle = .pageSheet
        //모달VC에 데이터 전달 => viewModel을 통해
        present(modalVC, animated: true)}
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        // 커스텀 어노테이션 뷰 설정
        guard let annotation = annotation as? Annotation else {return nil}
        var annotationView = self.mkMapView.dequeueReusableAnnotationView(withIdentifier: Constant.Identifier.annotationView.rawValue)
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: Constant.Identifier.annotationView.rawValue)
            annotationView?.canShowCallout = false
            annotationView?.contentMode = .scaleAspectFit
        } else { annotationView?.annotation = annotation }
        let annotationImage: UIImage!
        switch annotation.isBookMarked {
        case true:
//            annotationImage = UIImage(named: "annotation_Bookmarked.png")
            annotationImage = UIImage(named: "test1.png")
        case false:
//            annotationImage = UIImage(named: "annotation_default.png")
            annotationImage = UIImage(named: "testb1.png")
        }
//        annotationImage.draw(in: CGRect(x: 0, y: 0, width: 20, height: 20))
        annotationView?.image = annotationImage
        return annotationView
    }
    
    
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        self.locationViewModel.currentVisible(region: mapView.region)
        self.locationViewModel.locationsWhenRegionChanged()
        DispatchQueue.main.async {
            self.removeAllAnnotations()
            let annotations = self.locationViewModel.getAnnotations()
            for customPin in annotations {
                self.mkMapView.addAnnotation(customPin)
            }
        }
    }
}
//MARK: - CLLocationManagerDelegate

extension MapVC: CLLocationManagerDelegate {
    // 사용자의 위치를 성공적으로 가져왔을 때 호출
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        // 위치 정보를 배열로 입력받는데, 마지막 index값이 가장 정확.
        //        if let coordinate = locations.last?.coordinate {
        //            // ⭐️ 사용자 위치 정보 사용
        //            self.mkMapView.showsUserLocation = true
        //            self.mkMapView.setUserTrackingMode(.follow, animated: true)
        //        }
        
        // startUpdatingLocation()을 사용하여 사용자 위치를 가져왔다면
        // 불필요한 업데이트를 방지하기 위해 stopUpdatingLocation을 호출
        locationManager.stopUpdatingLocation()
    }
    
    // 사용자가 GPS 사용이 불가한 지역에 있는 등 위치 정보를 가져오지 못했을 때 호출
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(#function)}
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        // 사용자 디바이스의 위치 서비스가 활성화 상태인지 확인하는 메서드 호출
        checkDeviceService()}
    
}
