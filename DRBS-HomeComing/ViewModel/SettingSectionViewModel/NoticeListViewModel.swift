import UIKit

class NoticeListViewModel {

    //MARK: - Model
    
    var notices: [NoticeList] = []

    //MARK: - Output
    
    var numberOfNotices: Int {
        return notices.count
    }

    func notice(at index: Int) -> NoticeList {
        return notices[index]
    }
    
    //MARK: - Input
    /// - note : 테스팅용.
    func fetchNotices() {
        self.notices.append(NoticeList(title: "도라방스가 새롭게 오픈 하였습니다!", date: "2023-09-22"))
    }
    
}
