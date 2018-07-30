//
//  SettingsViewController.swift
//  GoalApp
//
//  Created by Lane Faison on 7/29/18.
//  Copyright © 2018 Lane Faison. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
}

extension SettingsViewController {
    private func setupView() {
        view.backgroundColor = UIColor.primaryBackgroundColor
        title = "Settings"
        setupSettings()
    }
    
    private func setupSettings() {
        let settingViewFrame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: 50.0)
        
        let darkThemeView = SwitchView(frame: settingViewFrame, title: "Dark Theme", value: UserPreferences.darkThemed, setting: .darkTheme)
        darkThemeView.translatesAutoresizingMaskIntoConstraints = false
        darkThemeView.delegate = self
        
        view.addSubview(darkThemeView)
        NSLayoutConstraint.activate([
            darkThemeView.topAnchor.constraint(equalTo: view.topAnchor, constant: 64.0),
            darkThemeView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            darkThemeView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            darkThemeView.heightAnchor.constraint(equalToConstant: 64.0)
            ])
    }
}

extension SettingsViewController: SwitchViewDelegate {
    func userSwitchedValue(for setting: Setting, to value: Bool) {
        switch setting {
        case .darkTheme:
            UserPreferences.darkThemed = value
            setupView()
        }
    }
}
