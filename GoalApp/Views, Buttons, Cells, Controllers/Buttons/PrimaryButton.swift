//
//  RadioButtonView.swift
//  GoalApp
//
//  Created by Lane Faison on 7/23/18.
//  Copyright © 2018 Lane Faison. All rights reserved.
//

import UIKit

class PrimaryButton: UIButton {
    
    enum ButtonType {
        case cancel
        case submit
    }
    
    var type: ButtonType
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(type: ButtonType) {
        self.type = type
        super.init(frame: .zero)
        initialize()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initialize()
    }
    
    private func initialize() {
        switch type {
        case .cancel:
            backgroundColor = UIColor.primaryRed
            setTitle("Cancel", for: .normal)
        case .submit:
            backgroundColor = UIColor.primaryGreen
            setTitle("Submit", for: .normal)
        }
        
        setTitleColor(.white, for: .normal)
    }
}
