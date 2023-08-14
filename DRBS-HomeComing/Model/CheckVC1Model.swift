//
//  CheckVC1Model.swift
//  DRBS-HomeComing
//
//  Created by 김성호 on 2023/08/14.
//

import UIKit

struct Information {
    var name: String = ""
    var transactionMethod: TransactionMethod = .none
    var dwellingType: DwellingType = .none
    var address: String = ""
}

enum TransactionMethod {
    case monthly
    case jeonse
    case bargain
    case none
}

enum DwellingType {
    case apartment
    case twoRoom
    case office
    case oneroom
    case none
}

