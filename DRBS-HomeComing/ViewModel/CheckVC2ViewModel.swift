import UIKit

class CheckVC2ViewModel{
    
    //MARK: - Model
    var report: Report = Report()
    var checkListModel = CheckList()
    private var 관리비미포함: UIButton?
    
    

    //MARK: - Output


    
    
    //MARK: - Input

    func updateMaintenanceMethod(_ method: MaintenanceMethod) {
        report.관리비미포함 = method
    }
    
    //거래방식 버튼이 눌렸을 때 실행할 액션
    func handleMaintenanceButtonAction(_ sender: UIButton, method: MaintenanceMethod) {
        updateMaintenanceMethod(method)
        updateMaintenanceStyle(button: sender)
    }
    
    //MARK: - Logics

    func changeColor() -> UIColor {
        return UIColor.red
    }
    
    //버튼색깔 바꾸는 코드
    private func updateMaintenanceStyle(button: UIButton) {
        관리비미포함?.setTitleColor(.darkGray, for: .normal)
        관리비미포함?.backgroundColor = .white

        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = Constant.appColor

        관리비미포함 = button
    }
    
    
}

