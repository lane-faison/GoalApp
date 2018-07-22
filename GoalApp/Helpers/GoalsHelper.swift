//
//  GoalsHelper.swift
//  GoalApp
//
//  Created by Lane Faison on 7/21/18.
//  Copyright © 2018 Lane Faison. All rights reserved.
//

import Foundation

struct GoalsHelper {
    private let goals: [Goal] = [Goal(name: "Finish this app", completed: false, timeToComplete: .oneMonth),
                         Goal(name: "Finish running pattern", completed: false, timeToComplete: .threeWeeks),
                         Goal(name: "Stick to workout", completed: false, timeToComplete: .threeMonths)]
    
    func getGoals() -> [Goal] {
        return goals
    }
}
