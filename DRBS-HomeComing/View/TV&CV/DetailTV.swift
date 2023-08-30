//
//  DetailTV.swift
//  DRBS-HomeComing
//
//  Created by 김성호 on 2023/08/14.
//

import UIKit

final class DetailTV: UIViewController {
    //MARK: - Properties

    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(DetailTVCell.self, forCellReuseIdentifier: DetailTVCell.identifier)
        return tableView
    }()
    
    //MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupNavigationBar()
        configure()
        addSubView()
        autoLayout()
    }

    
    //MARK: - Helpers
    
    func setupNavigationBar() {
        self.navigationController?.navigationBar.topItem?.title = ""
        let checkVC1 = CheckVC1()
        print(checkVC1.nameIndex)
        if checkVC1.nameIndex == 4 {
            self.navigationItem.title = "아파트"
        } else if checkVC1.nameIndex == 5 {
            self.navigationItem.title = "투룸"
        } else if checkVC1.nameIndex == 6 {
            self.navigationItem.title = "오피스텔"
        } else if checkVC1.nameIndex == 7 {
            self.navigationItem.title = "원룸"
        }
        
        //        self.navigationItem.title = "추가하기"
        self.navigationController?.navigationBar.backItem?.title = ""
        view.backgroundColor = .white
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(plusButtonTapped))
    }
    
    //MARK: - Actions
    
    @objc public func plusButtonTapped() {
        let additionalVC = CheckVC1()
        additionalVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(additionalVC, animated: true)
    }
}

//MARK: - Extensions


extension DetailTV {
    
    private func configure() {
        tableView.dataSource = self
        tableView.rowHeight = 290
        tableView.delegate = self
    }
    
    private func addSubView() {
        view.addSubview(tableView)
    }
    
    private func autoLayout() {
        tableView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

//MARK: - UITableViewDataSource

extension DetailTV : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: DetailTVCell.identifier, for: indexPath) as! DetailTVCell
        
        return cell
    }
    
}

//MARK: - UITableViewDelegate

extension DetailTV : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("select \(indexPath.row)")
    }
}
