import UIKit
import MapKit
import CoreLocation

class MapVC: UIViewController {
    //MARK: - Properties

    private lazy var map = MKMapView(frame: self.view.frame)
    private var locationManager = CLLocationManager()
    private var currentLocation: CLLocation!
    private var authorizationStatus: CLAuthorizationStatus!
    
    private lazy var currentLocationButton = UIButton().then {
        $0.setImage(UIImage(systemName: "paperplane.fill"), for: .normal)
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 5
        $0.backgroundColor = .white
    }
    
    private lazy var searchLocationButton = UIButton().then {
        $0.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 5
        $0.backgroundColor = .white
    }
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        
    }
    
   
    
    
    
    //MARK: - Helpers

    func configureUI() {
        view.addSubview(map)
        view.addSubview(currentLocationButton)
        view.addSubview(searchLocationButton)
        
        currentLocationButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(50)
            make.right.equalToSuperview().offset(-10)
            make.width.height.equalTo(40)
        }
        searchLocationButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(90)
            make.right.equalTo(currentLocationButton.snp.right)
            make.width.height.equalTo(40)
        }
        
        
        map.delegate = self
        map.mapType = .standard
        self.map.showsUserLocation = true
        self.map.setUserTrackingMode(.follow, animated: true)
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
        locationManager.startMonitoringSignificantLocationChanges()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        DispatchQueue.global().async {
            if CLLocationManager.locationServicesEnabled() {
                switch self.locationManager.authorizationStatus {
                case .denied, .restricted:
                    let alert = UIAlertController(title: "오류 발생", message: "위치 서비스 기능이 꺼져있음", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                    alert.addAction(okAction)
                    self.present(alert, animated: true, completion: nil)
                default:
                    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
                    self.locationManager.delegate = self
                    self.locationManager.requestWhenInUseAuthorization()
                }
            }
        }
    }
    
    
    
    
    
    func firstSetting() {
        self.currentLocation = locationManager.location
    }
}

extension MapVC: MKMapViewDelegate {
    
}

extension MapVC: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationManager = manager
        if locationManager.authorizationStatus == .authorizedWhenInUse {
            currentLocation = locationManager.location
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
            break
        case .authorizedWhenInUse:
            self.firstSetting()
            break
        case .authorizedAlways:
            self.firstSetting()
            break
        case .restricted:
            break
        case .denied:
            break
        default:
            break
        }
    }
    
}
