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
    
//    private func setUpLabel() {
//        //*만 빨갛게 바꾸는 콛
//        let labels = [보증금, tradeLabel,
//                      livingLabel, addressLabel]
//        for texts in labels {
//            let fullText = texts.text ?? ""
//            let attribtuedString = NSMutableAttributedString(string: fullText)
//            let range = (fullText as NSString).range(of: "*")
//            attribtuedString.addAttribute(.foregroundColor, value: UIColor.systemRed, range: range)
//            texts.attributedText = attribtuedString}
//    }
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
        cell.보증금.isHidden = indexPath.row != 0
        cell.보증금TextField.isHidden = indexPath.row != 0
        cell.만원.isHidden = indexPath.row != 0

        return cell
    }
    
    // 섹션간 거리를 띄우기 위해
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        if section == 0 {
//            return 0.0 // 첫 번째 섹션의 간격 설정
//        }
//        return 20.0 // 다른 섹션의 간격 설정
//    }
    
//    // 섹션 헤더 뷰 설정
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let headerView = UIView()
//        headerView.backgroundColor = .black
//        return nil
//    }
    
}

//MARK: - UITableViewDelegate

extension CheckVC2 : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("select \(indexPath.row)")
    }
}
