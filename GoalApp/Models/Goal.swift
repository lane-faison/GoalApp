//
//  Goal.swift
//  GoalApp
//
//  Created by Lane Faison on 7/21/18.
//  Copyright © 2018 Lane Faison. All rights reserved.
//

import UIKit
import RealmSwift

class Goal: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var monthsToComplete: Int = -1
    @objc private dynamic var statusType: Int = Status.notStarted.rawValue
    
    var status: Status {
        get {
            return Status(rawValue: statusType)!
        }
        set {
            statusType = newValue.rawValue
        }
    }
}

public enum Status: Int {
    case notStarted = 1
    case inProgress = 2
    case completed = 3
    case didNotFinish = 4
}
