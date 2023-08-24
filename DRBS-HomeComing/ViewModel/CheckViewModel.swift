import UIKit


class CheckViewModel {
    //MARK: - Model
    var checkListModel = CheckList()
    var 방향: String?
    var 방음: String?
    var 수압: String?
    var 벌레: String?
    var 통풍: String?
    var 보안: String?
    var 곰팡이: String?
    
    //MARK: - Output
        
    
    
    //MARK: - Input
    
   
    
    //MARK: - Logics
    func makeCheckListModel() -> CheckList {
        
        
        let checkList = CheckList(방향: "", 방음: "", 수압: "", 벌레: "", 통풍: "", 보안: "", 곰팡이: "")
        return checkList
    }
  

}



