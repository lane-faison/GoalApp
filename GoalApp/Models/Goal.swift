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
    let monthsToComplete: Int
    
    init(name: String, completed: Bool, monthsToComplete: Int) {
        self.name = name
        self.completed = completed
        self.monthsToComplete = monthsToComplete
    }
}
