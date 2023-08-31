import UIKit
import SnapKit
import Then

final class DetailVC: UIViewController {
    //MARK: - Properties
    private lazy var tableView = UITableView()
    
    //MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        settingNav()
    }

    
    //MARK: - Helpers
    private func configureUI() {
        view.backgroundColor = .white
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func settingNav() {
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
    
    private func settingTV() {
        tableView.register(DetailCell.self, forCellReuseIdentifier: Constant.Identifier.detailCell.rawValue)
        tableView.dataSource = self
        tableView.rowHeight = 290
        tableView.delegate = self
    }
    
    //MARK: - Actions
    
    @objc public func plusButtonTapped() {
        let additionalVC = CheckVC1()
        additionalVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(additionalVC, animated: true)
    }
}

//MARK: - UITableViewDataSource
extension DetailVC : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constant.Identifier.detailCell.rawValue, for: indexPath) as! DetailCell
        
        return cell
    }
    
}

//MARK: - UITableViewDelegate
extension DetailVC : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("select \(indexPath.row)")
    }
}
