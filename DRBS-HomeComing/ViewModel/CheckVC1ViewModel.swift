//
//  CheckVC1ViewModel.swift
//  DRBS-HomeComing
//
//  Created by 김성호 on 2023/08/14.
//

import UIKit


class CheckViewModel {
    var information: Information = Information()
    
    func updateTransactionMethod(_ method: TransactionMethod) {
        information.transactionMethod = method
    }
    
    func updateDwellingType(_ type: DwellingType) {
        information.dwellingType = type
    }
}

