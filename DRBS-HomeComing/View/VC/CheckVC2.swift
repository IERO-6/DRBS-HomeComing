import UIKit
import Then
import SnapKit

class CheckVC2: UIViewController {

    
    //MARK: - Properties

//    private let tableView = UITableView()
    let tableView = UITableView().then {
        $0.register(CheckVC2Cell.self, forCellReuseIdentifier: CheckVC2Cell.identifierCheckVC2)
    }
    
    
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
        self.navigationItem.title = "추가하기"
        self.navigationController?.navigationBar.backItem?.title = ""
    }

    
    
    
    //MARK: - Actions

    
    
}

extension CheckVC2 {
    
    private func configure() {
        tableView.dataSource = self
        tableView.rowHeight = 250
        tableView.delegate = self
        tableView.backgroundColor = .white
    }
    
    private func addSubView() {
        view.addSubview(tableView)
    }
    
    private func autoLayout() {
        tableView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
    }
}


//MARK: - UITableViewDataSource

extension CheckVC2 : UITableViewDataSource {
 
    //섹션개수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: CheckVC2Cell.identifierCheckVC2, for: indexPath) as! CheckVC2Cell
        cell.selectionStyle = .none

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section > 0 {
            return 90.0 // 원하는 간격 값으로 변경
        }
        return 0.0 // 첫 번째 섹션 이전에는 간격이 필요 없으면 0으로 설정
    }
    
    // 섹션 헤더 뷰 설정
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .black
        return nil
    }
    
}

//MARK: - UITableViewDelegate

extension CheckVC2 : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("select \(indexPath.row)")
    }
}
