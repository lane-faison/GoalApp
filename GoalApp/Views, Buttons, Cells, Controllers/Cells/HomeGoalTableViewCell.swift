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
        setupView()
    }
    
    func configure(with viewModel: HomeGoalTableViewCellModel) {
        if let goal = viewModel.goal {
            nameLabel.text = goal.name
            dueDateLabel.text = goalsHelper.getShortFormattedDate(from: goal)
            iconImageView.image = goalsHelper.getIcon(for: goal.status)
            iconImageView.tintColor = goalsHelper.getIconTintColor(for: goal.status)
            
            if goal.status == .inProgress {
                iconImageView.startRotating(duration: 1.5)
            }
            
            if goal.goalHasExpired && goal.status != .completed {
                subView.backgroundColor = UIColor.primaryRed.withAlphaComponent(0.2)
            } else if goal.goalHasExpired && goal.status == .completed {
                subView.backgroundColor = UIColor.primaryGreen.withAlphaComponent(0.2)
            } else {
                subView.backgroundColor = UIColor.primaryBackgroundColor
            }
        }
    }
    
    private func setupView() {
        backgroundColor = UIColor.primaryBackgroundColor
        subView.backgroundColor = UIColor.primaryBackgroundColor
        nameLabel.textColor = UIColor.primaryTextColor
        nameLabel.font = UIFont.font18
        dueDateLabel.textColor = UIColor.primaryTextColor
    }
    
    private func rotateIcon() {
        UIView.animate(withDuration: 2.0, animations: {
            self.iconImageView.transform = CGAffineTransform(rotationAngle: .pi * 2)
        }) { (finished) -> Void in
            self.rotateIcon()
        }
    }
}
