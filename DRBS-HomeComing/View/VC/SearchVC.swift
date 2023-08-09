//
//  SearchVC.swift
//  MKMapViewTest
//
//  Created by 김은상 on 2023/08/03.
//
import CoreLocation
import UIKit

class SearchVC: UIViewController {
    
    
    //MARK: - Properties

    weak var mapDelegate: MapDelegate?

    
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
        5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchCell.identifier, for: indexPath) as! SearchCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let gaepoLocation = Location(latitude: 37.482040282097046, longitude: 127.06796189321376)
        mapDelegate?.cordHandler(with: gaepoLocation)
        self.navigationController?.popViewController(animated: true)
        
        
    }
    
}

extension SearchVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        //글자가 바뀔 때의 로직
    }
}


