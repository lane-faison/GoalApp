//
//  GoalsHelper.swift
//  GoalApp
//
//  Created by Lane Faison on 7/21/18.
//  Copyright © 2018 Lane Faison. All rights reserved.
//

import Foundation
import RealmSwift

struct GoalsHelper {
    
    func getGoals() -> Results<Goal>? {
        if let realm = try? Realm() {
            let goals = realm.objects(Goal.self)
            return goals
        } else {
            return nil
        }
    }
    
    func createGoal(name: String, completionTime: CompletionTime, completion: (() -> Void)?) {
        if let realm = try? Realm() {
            let goal = Goal()
            goal.name = name
            goal.completionTime = completionTime
            
            try? realm.write {
                realm.add(goal)
                completion?()
            }
        }
    }
    
    func updateGoal(_ goal: Goal, with status: Status) {
        if let realm = try? Realm() {
            try? realm.write {
                goal.status = status
            }
        }
    }
    
    func deleteGoal(_ goal: Goal) {
        if let realm = try? Realm() {
            try? realm.write {
                realm.delete(goal)
            }
        }
    }
    
    func getIcon(for status: Status) -> UIImage? {
        switch status {
        case .notStarted:
            return UIImage(named: "play")?.withRenderingMode(.alwaysTemplate)
        case .inProgress:
            return UIImage(named: "refresh")?.withRenderingMode(.alwaysTemplate)
        case .completed:
            return UIImage(named: "ok")?.withRenderingMode(.alwaysTemplate)
        case .didNotFinish:
            return UIImage(named: "cancel")?.withRenderingMode(.alwaysTemplate)
        }
    }
    
    func getIconTintColor(for status: Status) -> UIColor {
        switch status {
        case .notStarted:
            return UIColor.primaryLightGreen
        case .inProgress:
            return UIColor.primaryBlue
        case .completed:
            return UIColor.primaryGreen
        case .didNotFinish:
            return UIColor.primaryRed
        }
    }
}
