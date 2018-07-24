//
//  HomeGoalTableViewCell.swift
//  GoalApp
//
//  Created by Lane Faison on 7/22/18.
//  Copyright © 2018 Lane Faison. All rights reserved.
//

import UIKit

class HomeGoalTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var subView: UIView!
    @IBOutlet private weak var iconImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var dueDateLabel: UILabel!
    
    var goal: Goal?
    private var goalsHelper = GoalsHelper()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        selectionStyle = .none
        
        setupShadow()
    }
    
    func configure(with viewModel: HomeGoalTableViewCellModel) {
        if let goal = viewModel.goal {
            nameLabel.text = goal.name
            iconImageView.image = goalsHelper.getIcon(for: goal.status)
            iconImageView.tintColor = goalsHelper.getIconTintColor(for: goal.status)
            
            if goal.status == .inProgress {
                iconImageView.startRotating(duration: 1.5)
            }
        }
    }
    
    private func setupShadow() {
        subView.layer.cornerRadius = subView.bounds.size.height / 8
        subView.layer.borderWidth = 1
        subView.layer.borderColor = UIColor.clear.cgColor
        subView.layer.masksToBounds = true
        
        layer.shadowOpacity = 0.1
        layer.shadowOffset = CGSize(width: 0, height: 1)
        layer.shadowRadius = subView.bounds.size.height / 8
        layer.shadowColor = UIColor.black.cgColor
        layer.masksToBounds = false
    }
    
    private func rotateIcon() {
        UIView.animate(withDuration: 2.0, animations: {
            self.iconImageView.transform = CGAffineTransform(rotationAngle: .pi * 2)
        }) { (finished) -> Void in
            self.rotateIcon()
        }
    }
}
