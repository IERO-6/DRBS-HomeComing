import UIKit
import Then
import SnapKit
import GoogleMobileAds

final class DetailVC: UIViewController {
    
    //MARK: - Properties
    
    private let noDataView = CategoryNoDataView()
    private lazy var tableView = UITableView()
    var houseViewModel = HouseViewModel()
    private let bannerView = GADBannerView(adSize: GADCurrentOrientationAnchoredAdaptiveBannerAdSizeWithWidth(UIScreen.main.bounds.width))
    var currentTitle: String?
    
    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        settingTV()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNav()
        bannerView.load(GADRequest())
        
        if houseViewModel.houses.isEmpty {
            tableView.isHidden = true
            noDataView.isHidden = false
        } else {
            tableView.isHidden = false
            noDataView.isHidden = true
        }
    }
    
    //MARK: - Helpers
    
    private func configureUI() {
        view.backgroundColor = .white
        view.addSubviews(tableView, bannerView, noDataView)
        
        bannerView.adUnitID = "ca-app-pub-5665531154477823/9914288196"
        bannerView.rootViewController = self
        bannerView.backgroundColor = tableView.backgroundColor

        bannerView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-30)
        }
        
        tableView.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
            $0.bottom.equalTo(bannerView.snp.top)
        }
        
        noDataView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.bottom.equalTo(bannerView.snp.top)
            $0.leading.trailing.equalToSuperview()
        }
    }
    
    private func configureNav() {
        self.navigationController?.navigationBar.backItem?.title = self.currentTitle
        view.backgroundColor = .white
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(plusButtonTapped))
    }
    
    private func settingTV() {
        tableView.register(DetailCell.self, forCellReuseIdentifier: Constant.Identifier.detailCell.rawValue)
        tableView.dataSource = self
//        tableView.rowHeight =
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
//        cell.updateUIForImages() // 이미지가 없을때, 메모를 위오 올리는 함수실행
        return cell
    }
    
}

//MARK: - UITableViewDelegate
extension DetailVC : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let myHouseVC = MyHouseVC()
        myHouseVC.selectedHouse = self.houseViewModel.houses[indexPath.row]
//        self.navigationController?.pushViewController(myHouseVC, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch (self.houseViewModel.houses[indexPath.row].사진 ?? []).count {
        case 0:
            return 220
        default:
            return 280
        }
    }
}


// MARK: - GADBannerViewDelegate

extension DetailVC: GADBannerViewDelegate {
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
        bannerView.alpha = 0
        UIView.animate(withDuration: 1) {
            bannerView.alpha = 1
        }
    }
    
    func bannerView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: Error) {
        bannerView.isHidden = true
    }
}
