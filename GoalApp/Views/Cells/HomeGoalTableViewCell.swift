//
//  HomeGoalTableViewCell.swift
//  GoalApp
//
//  Created by Lane Faison on 7/22/18.
//  Copyright © 2018 Lane Faison. All rights reserved.
//

import UIKit

class HomeGoalTableViewCell: UITableViewCell {

    @IBOutlet weak var view: UIView!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dueDateLabel: UILabel!
    
    var goal: Goal?
    private var goalsHelper = GoalsHelper()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        selectionStyle = .none
        
        view.layer.backgroundColor = UIColor.white.cgColor
        view.layer.cornerRadius = view.bounds.size.height / 8
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
    
    private func rotateIcon() {
        UIView.animate(withDuration: 2.0, animations: {
            self.iconImageView.transform = CGAffineTransform(rotationAngle: .pi * 2)
        }) { (finished) -> Void in
            self.rotateIcon()
        }
    }
}
