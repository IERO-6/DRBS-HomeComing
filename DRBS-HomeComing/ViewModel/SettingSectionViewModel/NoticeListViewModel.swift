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
    
}
