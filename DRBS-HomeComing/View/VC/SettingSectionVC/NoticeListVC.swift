import UIKit
import Then
import SnapKit

class NoticeListVC: UIViewController {

    // MARK: - Properties
    
    private let noticeTableView = UITableView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.estimatedRowHeight = 110
        $0.rowHeight = UITableView.automaticDimension
        $0.separatorColor = .opaqueSeparator
    }
    
    private let viewModel = NoticeListViewModel()
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.fetchNotices()
        noticeTableView.reloadData()

        configureNav()
        setupTableView()
        
        self.extendedLayoutIncludesOpaqueBars = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }

    // MARK: - Navigation Bar
    
    private func configureNav() {
        navigationItem.title = "공지사항"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)

        let appearance = UINavigationBarAppearance().then {
            $0.configureWithOpaqueBackground()
            $0.backgroundColor = UIColor(red: 0.12, green: 0.27, blue: 0.56, alpha: 1)
            $0.titleTextAttributes = [.foregroundColor: UIColor.white]
        }
        
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
    }
    
    // MARK: - Setup Layout
    
    private func setupTableView() {
        noticeTableView.delegate = self
        noticeTableView.dataSource = self
        noticeTableView.register(NoticeListCell.self, forCellReuseIdentifier: NoticeListCell.id)

        view.addSubview(noticeTableView)
        noticeTableView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
    }

}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension NoticeListVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfNotices
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NoticeListCell.id, for: indexPath) as! NoticeListCell
        let item = viewModel.notice(at: indexPath.row)
        cell.configure(title: item.title, date: item.date)
        cell.selectionStyle = .none
        return cell
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
            // 셀의 separator 인셋을 지정하여 separator의 좌우 여백을 조절
            if let cell = cell as? NoticeListCell {
                cell.separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
            }
        }
    
}
