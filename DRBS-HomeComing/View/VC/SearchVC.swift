import CoreLocation
import UIKit

class SearchVC: UIViewController {
    
    
    //MARK: - Properties

    weak var mapDelegate: MapDelegate?

    let location: [String] = ["개포동", "개푸동", "진주시", "잠실", "수원시"]
    var filtered: [String] = []
    
    let searchBar = UISearchBar()
    
    lazy var tableView = UITableView(frame: self.view.frame)
    
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        settingSearchBar()
        configureUI()
        settingTableView()
        
    }
    
    //MARK: - Helpers

    func configureUI() {
        view.backgroundColor = .white
        view.addSubview(tableView)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    func settingSearchBar() {
        searchBar.delegate = self
        searchBar.placeholder = "지역 검색하기"

        self.navigationItem.titleView = searchBar
        self.searchBar.becomeFirstResponder()
    }
    
    func settingTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 60
        tableView.register(SearchCell.self, forCellReuseIdentifier: SearchCell.identifier)
    }
    
    
}

//MARK: - Extensions



extension SearchVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.filtered.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchCell.identifier, for: indexPath) as! SearchCell
        cell.locationLabel.text = self.filtered[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let gaepoLocation = Location(latitude: "37.482040282097046", longitude: "127.06796189321376", isBookMarked: true)
        mapDelegate?.cordHandler(with: gaepoLocation)
        self.navigationController?.popViewController(animated: true)
        
        
    }
    
}

extension SearchVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            filtered = location.filter {$0.lowercased().contains(searchText.lowercased())}
            self.tableView.reloadData()
    }
}


