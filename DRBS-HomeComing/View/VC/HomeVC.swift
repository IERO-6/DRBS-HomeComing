import UIKit
import SnapKit
import Then

final class HomeVC: UIViewController {
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.configureNav()
    }
    
    //MARK: - Helpers

    func configureUI() {
        view.backgroundColor = .white
        view.addSubview(tableView)
        tableView.rowHeight = 200
        tableView.snp.makeConstraints { $0.top.bottom.left.right.equalToSuperview() }
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(plusButtonTapped))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gearshape"), style: .plain, target: self, action: #selector(settingButtonTapped))
        
    }
    private func settingTV() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(HouseTVCell.self, forCellReuseIdentifier: Constant.Identifier.houseCell.rawValue)
        tableView.separatorStyle = .none
    }
    
    private func configureNav() {
        let appearance = UINavigationBarAppearance().then {
            $0.configureWithOpaqueBackground()
            $0.backgroundColor = .white
            $0.titleTextAttributes = [.foregroundColor: UIColor.black]
        }
        navigationController?.navigationBar.topItem?.title = ""
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    //MARK: - Actions

    @objc public func plusButtonTapped() {
           let checkVC = CheckVC1()
           checkVC.hidesBottomBarWhenPushed = true
           self.navigationController?.pushViewController(checkVC, animated: true)
       }
    @objc func settingButtonTapped() {
           let settingVC = SettingVC()
           settingVC.hidesBottomBarWhenPushed = true
           self.navigationController?.pushViewController(settingVC, animated: true)
    }
    @objc func headButtonTapped() {
        let myHouseVC = MyHouseVC()
        self.navigationController?.pushViewController(myHouseVC, animated: true)
    }
    
}

//MARK: - UITableViewDelegate

extension HomeVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
            let headerView = UIView()
            let titleButton = UIButton(frame: CGRect(x: 15, y: 0, width: 200, height: 40))
            headerView.addSubview(titleButton)
            titleButton.setTitle("\(self.categories[section]) > ", for: .normal)
            titleButton.setTitleColor(.black, for: .normal)
            titleButton.contentHorizontalAlignment = .left
            titleButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
            titleButton.addTarget(self, action: #selector(headButtonTapped), for: .touchUpInside)
            titleButton.tag = section
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
