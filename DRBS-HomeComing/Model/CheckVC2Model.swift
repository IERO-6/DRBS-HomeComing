//
//  CheckVC2Model.swift
//  DRBS-HomeComing
//
//  Created by 김성호 on 2023/08/20.
//

import UIKit

struct Report {
    var name: String = ""
    var 관리비미포함: MaintenanceMethod = .none
}

enum MaintenanceMethod {
    case 전기
    case 가스
    case 수도
    case 인터넷
    case TV
    case 기타
    case none
}
