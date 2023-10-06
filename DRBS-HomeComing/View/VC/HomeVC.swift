import UIKit
import SnapKit
import Then

final class HomeVC: UIViewController {
    
    // MARK: - Properties
    
    private var viewModel = HouseViewModel()
    private let categories = ["아파트/오피스텔", "빌라/주택", "원룸/투룸+", "북마크"]
    private lazy var tableView = UITableView(frame: .zero, style: .grouped)
    var allHouseModels: [House]?
    var selectedHouse: House?
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        settingTV()
        NotificationCenter.default.addObserver(self, selector: #selector(refreshData), name: Notification.Name("houseDeleted"), object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.configureNav()
        tableView.reloadData()
    }
    
    // MARK: - Helpers
    
    private func configureNav() {
        let appearance = UINavigationBarAppearance().then {
            $0.configureWithOpaqueBackground()
            $0.backgroundColor = .white
            $0.titleTextAttributes = [.foregroundColor: UIColor.black]
            $0.shadowColor = nil
        }
        
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    private func configureUI() {
        view.backgroundColor = .white
        tableView.backgroundColor = .white
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints {
            $0.top.bottom.right.equalToSuperview()
            $0.leading.equalToSuperview().offset(15)
        }
        
        let navBarHeight = navigationController?.navigationBar.frame.height ?? 0
        tableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: navBarHeight - 20))
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(plusButtonTapped))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gearshape"), style: .plain, target: self, action: #selector(settingButtonTapped))
    }
    
    private func settingTV() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = view.frame.height / 3.8
        tableView.register(HouseTVCell.self, forCellReuseIdentifier: Constant.Identifier.houseCell.rawValue)
        tableView.separatorStyle = .none
    }
    
    // MARK: - Actions
    
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
    
    @objc func headButtonTapped(_ sender: KeyedButton) {
        let detailVC = DetailVC()
        switch sender.tag {
            case 0:
                detailVC.houseViewModel.houses = (self.allHouseModels ?? []).filter { $0.livingType! == "아파트/오피스텔" }
                detailVC.navTitle = "아파트/오피스텔"
            case 1:
                detailVC.houseViewModel.houses = (self.allHouseModels ?? []).filter { $0.livingType! == "빌라/주택" }
                detailVC.navTitle = "빌라/주택"
            case 2:
                detailVC.houseViewModel.houses = (self.allHouseModels ?? []).filter { $0.livingType! == "원룸/투룸+" }
                detailVC.navTitle = "원룸/투룸+"
            case 3:
                detailVC.houseViewModel.houses = (self.allHouseModels ?? []).filter { $0.isBookMarked! == true }
                detailVC.navTitle = "북마크"
            default:
                break
        }
        let backButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationItem.backBarButtonItem = backButtonItem
        
        detailVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    @objc func refreshData(notification: Notification) {
        if let userInfo = notification.userInfo, let deletedHouseId = userInfo["deletedHouseId"] as? String {
            if let index = self.allHouseModels?.firstIndex(where: { $0.houseId == deletedHouseId }) {
                self.allHouseModels?.remove(at: index)
            }
        }
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

// MARK: - UITableViewDelegate

extension HomeVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .white
        let titleButton = KeyedButton(frame: CGRect(x: 0, y: -10, width: 200, height: 20))
        headerView.addSubview(titleButton)

        let image = UIImage(systemName: "chevron.right")?.withTintColor(.darkGray, renderingMode: .alwaysOriginal)
        titleButton.setImage(image, for: .normal)
        titleButton.setTitle(self.categories[section], for: .normal)
        titleButton.semanticContentAttribute = .forceRightToLeft

        titleButton.setTitleColor(.darkGray, for: .normal)
        titleButton.backgroundColor = .white
        titleButton.tag = section
        titleButton.contentHorizontalAlignment = .left
        titleButton.titleLabel?.font = UIFont(name: "Pretendard-Bold", size: 18)
        titleButton.addTarget(self, action: #selector(headButtonTapped(_:)), for: .touchUpInside)
        titleButton.tag = section
        return headerView
    }
}

// MARK: - UITableViewDataSource

extension HomeVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constant.Identifier.houseCell.rawValue, for: indexPath) as! HouseTVCell
        cell.cellselectedDelegate = self
        cell.selectionStyle = .none
        cell.indexPath = indexPath.section
        cell.houses = self.allHouseModels ?? []
        return cell
    }
}

// MARK: - CellSelectedDelegate

extension HomeVC: CellSelectedDelegate {
    func cellselected(houseTVCell: HouseTVCell, house: House) {
        let myHouseVC = MyHouseVC()
        myHouseVC.selectedHouse = house // House 객체 전달
        myHouseVC.checkListView.checkViewModel.checkListModel = house.체크리스트 ?? CheckList()
        myHouseVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(myHouseVC, animated: true)
    }
}
