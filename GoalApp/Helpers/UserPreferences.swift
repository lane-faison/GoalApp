//
//  UserPreferences.swift
//  GoalApp
//
//  Created by Lane Faison on 7/29/18.
//  Copyright © 2018 Lane Faison. All rights reserved.
//

import UIKit

class UserPreferences {
    static var darkThemed: Bool {
        get {
            return UserDefaults.standard.bool(forKey: "darkThemed")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "darkThemed")
        }
    }
}
