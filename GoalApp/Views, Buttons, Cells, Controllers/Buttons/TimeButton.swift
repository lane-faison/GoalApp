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
    
    override var isSelected: Bool {
        didSet {
            backgroundColor = isSelected ? UIColor.primaryBlue : UIColor.primaryBackgroundColor
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(completionTime: CompletionTime) {
        self.completionTime = completionTime
        super.init(frame: .zero)
        initialize()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initialize()
    }
    
    private func initialize() {
        backgroundColor = UIColor.primaryBackgroundColor
        
        layer.borderColor = UIColor.primaryBlue.cgColor
        layer.borderWidth = 1.0
        
        setTitleColor(UIColor.primaryTextColor, for: .normal)
        setTitleColor(.white, for: .selected)
        
        setTitle(completionTime?.rawValue, for: .normal)
        setTitle(completionTime?.rawValue, for: .selected)
    }
}
