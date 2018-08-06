//
//  PrimaryTextField.swift
//  GoalApp
//
//  Created by Lane Faison on 7/28/18.
//  Copyright © 2018 Lane Faison. All rights reserved.
//

import UIKit

class PrimaryTextField: UITextField {
    
    var type: TextFieldType
    
    let padding = UIEdgeInsets(top: 0, left: 120.0, bottom: 0, right: 16.0)
    
    private var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Goal name:"
        return label
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(type: TextFieldType) {
        self.type = type
        super.init(frame: .zero)
        initialize()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initialize()
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    
    private func initialize() {
        backgroundColor = .white
        placeholder = type.rawValue
        textAlignment = .right
        returnKeyType = .continue
        
        addSubview(label)
        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: centerYAnchor),
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.0)
            ])
        
        
    }
}

enum TextFieldType: String {
    case optional = "(optional)"
    case required = "*required"
}
