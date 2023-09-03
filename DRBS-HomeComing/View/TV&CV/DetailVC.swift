import UIKit
import SnapKit
import Then

final class DetailVC: UIViewController {
    //MARK: - Properties
    private lazy var tableView = UITableView()
    var houseViewModel = HouseViewModel()
    
    //MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        settingTV()
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
        return self.houseViewModel.houses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constant.Identifier.detailCell.rawValue, for: indexPath) as! DetailCell
        cell.house = self.houseViewModel.houses[indexPath.row]
        return cell
    }
    
}

//MARK: - UITableViewDelegate
extension DetailVC : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("select \(indexPath.row)")
    }
}
