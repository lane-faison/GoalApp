//
//  TimeButtonViewModel.swift
//  GoalApp
//
//  Created by Lane Faison on 7/23/18.
//  Copyright © 2018 Lane Faison. All rights reserved.
//

import Foundation

class TimeButtonViewModel {
    var title: String
    var tapAction: (() -> Void)
    
    init(title: String, tapAction: @escaping (() -> Void)) {
        self.title = title
        self.tapAction = tapAction
    }
    
    func buttonTapped() {
        tapAction()
    }
}
