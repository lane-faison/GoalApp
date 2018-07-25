//
//  RadioButtonView.swift
//  GoalApp
//
//  Created by Lane Faison on 7/23/18.
//  Copyright © 2018 Lane Faison. All rights reserved.
//

import UIKit

enum TimeButtonType: String {
    case oneDay = "1 Day"
    case oneWeek = "1 Week"
    case oneMonth = "1 Month"
    case sixMonths = "6 Months"
    case oneYear = "1 Year"
    case fiveYears = "5 Years"
}

class TimeButton: UIButton {
    
    var type: TimeButtonType?
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(frame: CGRect, type: TimeButtonType) {
        self.type = type
        super.init(frame: frame)
        initialize()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initialize()
    }
    
    private func initialize() {
        layer.borderColor = UIColor.primaryGreen.cgColor
        layer.borderWidth = 1.0
        layer.cornerRadius = 5.0
        
        setTitleColor(.black, for: .normal)
        setTitleColor(UIColor.primaryGreen, for: .selected)
        
        setTitle(type?.rawValue, for: .normal)
        setTitle(type?.rawValue, for: .selected)
    }
}
