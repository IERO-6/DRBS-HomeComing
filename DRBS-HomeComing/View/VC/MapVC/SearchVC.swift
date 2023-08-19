
import CoreLocation
import UIKit
import MapKit

final class SearchVC: UIViewController {
    //MARK: - Properties
    
    private lazy var searchLocationViewModel = LocationViewModel()
    
    let location: [String] = ["개포동", "개푸동", "진주시", "잠실", "수원시"]
    
    var filtered: [String] = []
    
    private lazy var searchBar = UISearchBar()
    
    private lazy var tableView = UITableView(frame: self.view.frame)
    
    //오늘 추가한 부분
    private lazy var searchCompleter = MKLocalSearchCompleter()
    private lazy var searchResults: [MKLocalSearchCompletion] = []
    weak var searchViewDelegate: searchViewDelegate?
    
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        settingSearchBar()
        configureUI()
        settingTableView()
        settingSearchCompleter()
        
    }
    
    //MARK: - Helpers
    
    private func configureUI() {
        view.backgroundColor = .white
        view.addSubview(tableView)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    private func settingSearchBar() {
        searchBar.delegate = self
        searchBar.placeholder = "지역 검색하기"
        self.navigationItem.titleView = searchBar
        self.searchBar.becomeFirstResponder()
    }
    
    private func settingTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 60
        tableView.register(SearchCell.self, forCellReuseIdentifier: Constant.Identifier.searchCell.rawValue)
    }
    private func settingSearchCompleter() {
        self.searchCompleter.delegate = self
        self.searchCompleter.resultTypes = .address
    }
}

//MARK: - UITableViewDataSource, UITableViewDelegate
extension SearchVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //        return self.filtered.count
        return searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constant.Identifier.searchCell.rawValue, for: indexPath) as! SearchCell
        //        cell.locationLabel.text = self.filtered[indexPath.row]
        let searchResults = self.searchResults[indexPath.row]
        cell.locationLabel.text = searchResults.title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //사용자가 선택한 cell의 구체적 위치 정보를 알고 싶다면
        //MKLocalSearch.Request 와 MKLocalSearch Class를 이용하여 검색 요청으로 response를 받음
        //선택한 cell에 맞는 MKLocalSearchCompletion 객체로 MKLocalSearch.Request 객체를 만든다
        //Request 객체로 MKLocalSearch 객체를 만들어 start() 메서드로 검색결과를 받는다.
        let selectedResult = searchResults[indexPath.row]
        let searchRequest = MKLocalSearch.Request(completion: selectedResult)
        let search = MKLocalSearch(request: searchRequest)
        search.start { (response, error) in
            guard error == nil else {
                print("\(String(describing: error?.localizedDescription))")
                return
            }
            guard let placeMark = response?.mapItems[0].placemark else {
                return
            }
//            let coordinate = Coordinate(coordinate: placeMark.coordinate)
            let coordinate = CLLocationCoordinate2D(latitude: placeMark.coordinate.latitude, longitude: placeMark.coordinate.longitude)
            print(coordinate)
//            self.delegate?.userAdd(newLocation: Location(coordinate: coordinate, name: "\(placeMark.locality ?? selectedResult.title)"))
            self.searchViewDelegate?.setRegion(cood: coordinate)
            
            self.navigationController?.popViewController(animated: true)
        }
    }
}
    //MARK: - UISearchBarDelegate
    
    extension SearchVC: UISearchBarDelegate {
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            //            filtered = location.filter {$0.lowercased().contains(searchText.lowercased())}
            //            self.tableView.reloadData()
            if searchText == "" {
                searchResults.removeAll()
                tableView.reloadData()
            }
            searchCompleter.queryFragment = searchText
        }
        func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
            self.dismiss(animated: true, completion: nil)
        }
        
    }
    
    
    extension SearchVC: MKLocalSearchCompleterDelegate {
        func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
            //위치 자동완성이 끝나면 completer 가 호출하는 delegate 메서드
            //자동완성한 결과를 TableView의 DataSource에서 참조하는 변수에 할당,
            // reloadData()를 통해 테이블뷰에 전달
            searchResults = completer.results
            tableView.reloadData()
        }
        func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
            print(error.localizedDescription)
        }
        
    }
