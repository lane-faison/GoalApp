//
//  Goal.swift
//  GoalApp
//
//  Created by Lane Faison on 7/21/18.
//  Copyright © 2018 Lane Faison. All rights reserved.
//

import UIKit

struct Goal: Decodable {
    let name: String
    let completed: Bool
    let timeToComplete: TimeToComplete
    
    init(name: String, completed: Bool, timeToComplete: TimeToComplete) {
        self.name = name
        self.completed = completed
        self.timeToComplete = timeToComplete
    }
    
    public enum TimeToComplete: String, Decodable {
        case oneDay = "1 day"
        case oneWeek = "1 week"
        case twoWeeks = "2 weeks"
        case threeWeeks = "3 weeks"
        case oneMonth = "1 month"
        case twoMonths = "2 months"
        case threeMonths = "3 months"
        case sixMonths = "6 months"
        case oneYear = "1 year"
        case twoYears = "2 years"
        case threeYears = "3 years"
        case fourYears = "4 years"
        case fiveYears = "5 years"
    }
}
