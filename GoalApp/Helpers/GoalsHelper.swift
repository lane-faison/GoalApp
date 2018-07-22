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
}
