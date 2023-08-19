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
    
    func fetchNotices() {
        self.notices.append(NoticeList(title: "성호님 개강 임박", date: "2023-08-14"))
        self.notices.append(NoticeList(title: "어질어질 하네요", date: "2023-08-13"))
        self.notices.append(NoticeList(title: "하...MVVM", date: "2023-08-12"))
        self.notices.append(NoticeList(title: "DRBS: HomeComing이 오픈 하였습니다!", date: "2023-08-28"))
    }

    
}
