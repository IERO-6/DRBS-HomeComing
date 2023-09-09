import UIKit


class CheckViewModel {
    //MARK: - Model
    var checkListModel: CheckList? {
        didSet {
            onCompleted(self.checkListModel)
        }
    }
    var 방향: [String] = []
    var 방음: [String] = []
    var 수압: [String] = []
    var 벌레: [String] = []
    var 통풍: [String] = []
    var 보안: [String] = []
    var 곰팡이: [String] = []
    
    //MARK: - Output
    var onCompleted: (CheckList?) -> Void = { _ in }

    //MARK: - Input
    
    //MARK: - Logics
    func makeCheckListModel() -> CheckList {
        let checkList = CheckList(방향: self.방향, 방음: self.방음, 수압: self.수압, 벌레: self.벌레, 통풍: self.통풍, 보안: self.보안, 곰팡이: self.곰팡이)
        return checkList
    }
    func checkListButton(_ sender: KeyedButton) {
        switch sender.tag {
        case 1:
            if !self.방향.contains(sender.key ?? "") {
                self.방향.append(sender.key ?? "")
            } else {
                self.방향 = self.방향.filter { $0 != (sender.key ?? "") }
            }
        case 2:
            if !self.방음.contains(sender.key ?? "") {
                self.방음.append(sender.key ?? "")
            } else {
                self.방음 = self.방음.filter { $0 != (sender.key ?? "") }
            }
        case 3:
            if !self.수압.contains(sender.key ?? "") {
                self.수압.append(sender.key ?? "")
            } else {
                self.수압 = self.수압.filter { $0 != (sender.key ?? "") }
            }
        case 4:
            if !self.벌레.contains(sender.key ?? "") {
                self.벌레.append(sender.key ?? "")
            } else {
                self.벌레 = self.벌레.filter { $0 != (sender.key ?? "") }
            }
        case 5:
            if !self.통풍.contains(sender.key ?? "") {
                self.통풍.append(sender.key ?? "")
            } else {
                self.통풍 = self.통풍.filter { $0 != (sender.key ?? "") }
            }
        case 6:
            if !self.보안.contains(sender.key ?? "") {
                self.보안.append(sender.key ?? "")
            } else {
                self.보안 = self.보안  .filter { $0 != (sender.key ?? "") }
            }
        case 7:
            if !self.곰팡이.contains(sender.key ?? "") {
                self.곰팡이.append(sender.key ?? "")
            } else {
                self.곰팡이 = self.곰팡이.filter { $0 != (sender.key ?? "") }
            }
        default:
            return
        }
    }
    
    
  

}



