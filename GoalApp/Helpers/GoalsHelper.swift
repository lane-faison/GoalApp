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
            let goals = realm.objects(Goal.self).sorted(byKeyPath: "monthsToComplete", ascending: true)
            return goals
        } else {
            return nil
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
            return UIColor.gray
        case .inProgress:
            return UIColor.blue
        case .completed:
            return UIColor.green
        case .didNotFinish:
            return UIColor.red
        }
    }
}
