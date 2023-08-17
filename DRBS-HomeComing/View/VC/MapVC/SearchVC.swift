import CoreLocation
import UIKit

final class SearchVC: UIViewController {
    
    
    //MARK: - Properties
    
    private lazy var searchLocationViewModel = LocationViewModel()
    
    let location: [String] = ["개포동", "개푸동", "진주시", "잠실", "수원시"]
    
    var filtered: [String] = []
    
    private lazy var searchBar = UISearchBar()
    
    private lazy var tableView = UITableView(frame: self.view.frame)
    
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        settingSearchBar()
        configureUI()
        settingTableView()
        
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
}

//MARK: - UITableViewDataSource, UITableViewDelegate
extension SearchVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.filtered.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constant.Identifier.searchCell.rawValue, for: indexPath) as! SearchCell
        cell.locationLabel.text = self.filtered[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.navigationController?.popViewController(animated: true)
    }
}
//MARK: - UISearchBarDelegate

extension SearchVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            filtered = location.filter {$0.lowercased().contains(searchText.lowercased())}
            self.tableView.reloadData()
    }
}


