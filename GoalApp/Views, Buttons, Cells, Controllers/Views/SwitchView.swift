//
//  SwitchView.swift
//  GoalApp
//
//  Created by Lane Faison on 7/29/18.
//  Copyright © 2018 Lane Faison. All rights reserved.
//

import UIKit

protocol SwitchViewDelegate {
    func userSwitchedValue(for setting: Setting, to value: Bool)
}

public enum Setting {
    case darkTheme
}

class SwitchView: UIView {
    
    var title: String
    
    var value: Bool
    
    var setting: Setting
    
    var delegate: SwitchViewDelegate?
    
    var settingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.primaryTextColor
        return label
    }()
    
    var settingSwitch: UISwitch = {
        let newSwitch = UISwitch()
        newSwitch.translatesAutoresizingMaskIntoConstraints = false
        return newSwitch
    }()
    
    init(frame: CGRect, title: String, value: Bool, setting: Setting) {
        self.title = title
        self.value = value
        self.setting = setting
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initialize()
    }
}

extension SwitchView {
    @objc private func switchChanged(sender: UISwitch) {
        delegate?.userSwitchedValue(for: setting, to: sender.isOn)
    }
}

extension SwitchView {
    
    private func initialize() {
        addSubview(settingLabel)
        NSLayoutConstraint.activate([
            settingLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            settingLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.0)
            ])
        settingLabel.text = title
        
        addSubview(settingSwitch)
        NSLayoutConstraint.activate([
            settingSwitch.centerYAnchor.constraint(equalTo: settingLabel.centerYAnchor),
            settingSwitch.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24.0)
            ])
        settingSwitch.setOn(value, animated: true)
        settingSwitch.addTarget(self, action: #selector(switchChanged(sender:)), for: .touchUpInside)
    }
}
