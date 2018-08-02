//
//  Goal.swift
//  GoalApp
//
//  Created by Lane Faison on 7/21/18.
//  Copyright © 2018 Lane Faison. All rights reserved.
//

import UIKit
import RealmSwift

public class Goal: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var created: Date = Date()
    @objc private dynamic var statusType: Int = Status.notStarted.rawValue
    @objc private dynamic var completionTimeType: String = CompletionTime.oneDay.rawValue
    
    var status: Status {
        get {
            return Status(rawValue: statusType)!
        }
        set {
            statusType = newValue.rawValue
        }
    }
    
    var completionTime: CompletionTime {
        get {
            return CompletionTime(rawValue: completionTimeType)!
        }
        set {
            completionTimeType = newValue.rawValue
        }
    }
    
    var dueDate: Date? {
        return GoalsHelper().getDueDate(creationDate: created, timeToComplete: completionTime)
    }
    convenience init(name: String, completionTime: CompletionTime, status: Status) {
        self.init()
        self.name = name
        self.completionTime = completionTime
        self.status = status
    }
}

public enum Status: Int {
    case notStarted = 1
    case inProgress = 2
    case completed = 3
    case didNotFinish = 4
}

public enum CompletionTime: String {
    case oneDay = "1 Day"
    case oneWeek = "1 Week"
    case oneMonth = "1 Month"
    case sixMonths = "6 Month"
    case oneYear = "1 Year"
    case fiveYears = "5 Years"
    
    static let allValues = [oneDay, oneWeek, oneMonth, sixMonths, oneYear, fiveYears]
}
