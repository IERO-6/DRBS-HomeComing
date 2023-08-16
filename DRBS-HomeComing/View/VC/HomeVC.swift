import UIKit
import SnapKit
import Then

class HomeVC: UIViewController {
    //MARK: - Properties
    // 뷰컨트롤러가 뷰모델을 소유
    private var viewModel = HouseViewModel()
    private let categories = ["아파트", "원룸", "오피스텔"]
    private lazy var tableView = UITableView()
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        settingTV()
        
        self.extendedLayoutIncludesOpaqueBars = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setupHomeBarAppearance()
    }
    
    //MARK: - Helpers

    func configureUI() {
        view.addSubview(tableView)
        tableView.rowHeight = 200
        tableView.snp.makeConstraints { $0.top.bottom.left.right.equalToSuperview() }
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(plusButtonTapped))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gearshape"), style: .plain, target: self, action: #selector(settingButtonTapped))
        
    }
    func settingTV() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(HouseTVCell.self, forCellReuseIdentifier: Constant.Identifier.houseCell.rawValue)
        tableView.separatorStyle = .none
    }
    
    //MARK: - Actions

    @objc public func plusButtonTapped() {
           let checkVC = CheckVC1()
           checkVC.hidesBottomBarWhenPushed = true
           self.navigationController?.pushViewController(checkVC, animated: true)
       }
       @objc func settingButtonTapped() {
           let settingVC = SettingVC()
           self.navigationController?.pushViewController(settingVC, animated: true)
       }
}

//MARK: - UITableViewDelegate

extension HomeVC: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return self.categories[section]
//    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
            let headerView = UIView()
            let titleButton = UIButton(frame: CGRect(x: 15, y: 0, width: 200, height: 40))
            headerView.addSubview(titleButton)
            titleButton.setTitle("\(self.categories[section]) > ", for: .normal)
            titleButton.setTitleColor(.black, for: .normal)
            titleButton.contentHorizontalAlignment = .left
            titleButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
            
            return headerView
        }
    
}

//MARK: - UITableViewDataSource

extension HomeVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //섹션별 열의 개수
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        //섹션의 개수
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constant.Identifier.houseCell.rawValue, for: indexPath) as! HouseTVCell
        cell.selectionStyle = .none
        cell.indexPath = indexPath.section
        return cell
    }
}
