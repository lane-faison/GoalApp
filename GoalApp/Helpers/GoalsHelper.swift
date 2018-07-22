//
//  GoalsHelper.swift
//  GoalApp
//
//  Created by Lane Faison on 7/21/18.
//  Copyright © 2018 Lane Faison. All rights reserved.
//

import Foundation

struct GoalsHelper {
    private let goals: [Goal] = [Goal(name: "Finish this app", completed: false, monthsToComplete: 1),
                                 Goal(name: "Finish running pattern", completed: false, monthsToComplete: 2),
                                 Goal(name: "Stick to workout", completed: false, monthsToComplete: 3)]
    
    func getGoals() -> [Goal] {
        let sortedGoals = goals.sorted(by: { $0.monthsToComplete < $1.monthsToComplete })
        return sortedGoals
    }
    
    func getGoalsOrganizedByMonthsToComplete() -> [Int: [Goal]] {
        let goals = getGoals()
        var monthsSet = Set<Int>()
        var goalsOrganizedByMonthsToComplete: [Int: [Goal]] = [:]
        
        for goal in goals {
            if monthsSet.contains(goal.monthsToComplete) {
                goalsOrganizedByMonthsToComplete[goal.monthsToComplete]?.append(goal)
            } else {
                monthsSet.insert(goal.monthsToComplete)
                goalsOrganizedByMonthsToComplete.updateValue([goal], forKey: goal.monthsToComplete)
            }
        }
        
        return goalsOrganizedByMonthsToComplete
    }
    
}
