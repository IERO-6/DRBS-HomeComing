import UIKit


class CheckViewModel {
    //MARK: - Model
    var information: Information = Information()
    var checkListModel = CheckList()
    private var 거래방식버튼: UIButton?
    private var 주거형태버튼: UIButton?
    
    var 거래방식: String? 
    
    //MARK: - Output
        
    
    
    //MARK: - Input
    //거래정보 방식을 업데이트
    func updateTransactionMethod(_ method: TransactionMethod) {
        information.거래방식 = method
    }
    
    //주거형태 정보를 업데이트
    func updateDwellingType(_ type: DwellingType) {
        information.주거형태 = type
    }
    
    //거래방식 버튼이 눌렸을 때 실행할 액션
    func handleTransactionButtonAction(_ sender: UIButton, method: TransactionMethod) {
        updateTransactionMethod(method)
        updateTransactionStyle(button: sender)
    }

    //주거형태 버튼이 눌렸을 때 실행할 액션
    func handleDwellingTypeButtonAction(_ sender: UIButton, type: DwellingType) {
        updateDwellingType(type)
        updateDwellingStyle(button: sender)
    }
    
    //MARK: - Logics

    func changeColor() -> UIColor {
        return UIColor.red
    }
    
    //버튼색깔 바꾸는 코드
    private func updateTransactionStyle(button: UIButton) {
        거래방식버튼?.setTitleColor(.darkGray, for: .normal)
        거래방식버튼?.backgroundColor = .white

        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = Constant.appColor

        거래방식버튼 = button
    }
    
    private func updateDwellingStyle(button: UIButton) {
        주거형태버튼?.setTitleColor(.darkGray, for: .normal)
        주거형태버튼?.backgroundColor = .white

        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = Constant.appColor

        주거형태버튼 = button
    }
}



