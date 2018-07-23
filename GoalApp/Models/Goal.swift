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
    @objc dynamic var created: Date = Date()
    @objc private dynamic var statusType: Int = Status.notStarted.rawValue
    
    var status: Status {
        get {
            return Status(rawValue: statusType)!
        }
        set {
            statusType = newValue.rawValue
        }
    }
    
    convenience init(name: String, monthsToComplete: Int, created: Date, status: Status) {
        self.init()
        self.name = name
        self.monthsToComplete = monthsToComplete
        self.created = created
        self.status = status
    }
}

public enum Status: Int {
    case notStarted = 1
    case inProgress = 2
    case completed = 3
    case didNotFinish = 4
}
