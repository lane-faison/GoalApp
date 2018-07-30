//
//  HomeTableViewHeader.swift
//  GoalApp
//
//  Created by Lane Faison on 7/29/18.
//  Copyright © 2018 Lane Faison. All rights reserved.
//

import UIKit

class HomeTableViewHeader: UIView {
    
    var title: String
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.primaryTextColor
        label.font = UIFont.font14b
        return label
    }()
    
    var byLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.primaryTextColor
        label.font = UIFont.font14sb
        return label
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(frame: CGRect, title: String) {
        self.title = title
        super.init(frame: frame)
        initialize()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initialize()
    }
    
    private func initialize() {
        backgroundColor = UIColor.sectionHeaderColor
        
        addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.0),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4.0)
            ])
        titleLabel.text = title.uppercased()
        
        addSubview(byLabel)
        NSLayoutConstraint.activate([
            byLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.0),
            byLabel.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor)
            ])
        byLabel.text = "Due By:".uppercased()
        
    }
}
