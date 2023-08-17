import UIKit
import SnapKit
import Then

class DetailTV: UIViewController {
    
    //MARK: - Properties
    
    let tableView = UITableView().then {
        $0.register(DetailTVCell.self, forCellReuseIdentifier: DetailTVCell.identifier)
    }
    
    var section: Int = 0
    
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
        print(section)
        if section == 0 {
            self.navigationItem.title = "아파트"
        } else if section == 1 {
            self.navigationItem.title = "원룸"
        } else {
            self.navigationItem.title = "오피스텔"
        }
        
        self.navigationController?.navigationBar.backItem?.title = ""
        view.backgroundColor = .white
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(plusButtonTapped))
    }
    
    //MARK: - Actions
    
    @objc public func plusButtonTapped() {
        let additionalVC = AdditionalVC()
        additionalVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(additionalVC, animated: true)
    }
}


extension DetailTV {
    
    private func configure() {
        tableView.dataSource = self
        tableView.rowHeight = 250
        tableView.delegate = self
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

extension DetailTV : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: DetailTVCell.identifier, for: indexPath) as! DetailTVCell
        cell.selectionStyle = .none
        cell.roomImageView.image = UIImage(named: "roomImage")
        cell.nameLabel.text = "신대방역 근처 원룸"
        cell.priceLabel.text = "1000/60"
        cell.starsNumber.text = "5.0"
        cell.bookMarkButton.setImage(UIImage(systemName: "bookmark"), for: .normal)
        cell.starImageView.image = UIImage(named: "star")
        return cell
    }
    
}

//MARK: - UITableViewDelegate

extension DetailTV : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("select \(indexPath.row)")
    }
}
