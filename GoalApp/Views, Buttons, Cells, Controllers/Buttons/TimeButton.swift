//
//  RadioButtonView.swift
//  GoalApp
//
//  Created by Lane Faison on 7/23/18.
//  Copyright © 2018 Lane Faison. All rights reserved.
//

import UIKit

class TimeButton: UIButton {
    
    var completionTime: CompletionTime?
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(frame: CGRect, completionTime: CompletionTime) {
        self.completionTime = completionTime
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
        
        setTitle(completionTime?.rawValue, for: .normal)
        setTitle(completionTime?.rawValue, for: .selected)
    }
}
