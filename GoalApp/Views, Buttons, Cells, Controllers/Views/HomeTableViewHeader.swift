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
        label.textColor = UIColor.primaryLightGray
        label.font = UIFont.headerBold
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
        backgroundColor = UIColor.primaryDarkGray
        
        addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.0)
            ])
        
        titleLabel.text = title
    }
}
