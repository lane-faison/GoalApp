//
//  CreateViewController.swift
//  GoalApp
//
//  Created by Lane Faison on 7/22/18.
//  Copyright © 2018 Lane Faison. All rights reserved.
//

import UIKit
import RealmSwift

class CreateViewController: UIViewController {
    
    let options: [String] = ["1 day", "1 week", "1 month", "6 months", "1 year", "5 years"]
    
    private var nameTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.borderWidth = 2.0
        textField.layer.cornerRadius = 2.0
        return textField
    }()
    
    private var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 8.0
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupNavBar()
        setupNameTextField()
        setupTimeStackView()
    }
}

extension CreateViewController {
    @objc func cancelTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func saveTapped() {
        guard let name = nameTextField.text, !name.isEmpty  else { return }
        
        GoalsHelper().createGoal(name: name, monthsToComplete: 6) {
            self.navigationController?.popViewController(animated: true)
        }
    }
}

extension CreateViewController: TimeButtonViewDelegate {
    func userTappedButton() {
        for view in stackView.subviews {
            if let view = view as? TimeButtonView {
                if view.isSelected == true {
                    view.changeAppearance(isSelected: false)
                }
            }
        }
    }
    
    
}

extension CreateViewController {
    
    private func setupNavBar() {
        let leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelTapped))
        let rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveTapped))
        
        leftBarButtonItem.tintColor = UIColor.primaryRed
        rightBarButtonItem.tintColor = UIColor.black
        
        navigationItem.leftBarButtonItem = leftBarButtonItem
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    private func setupNameTextField() {
        view.addSubview(nameTextField)
        NSLayoutConstraint.activate([
            nameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            nameTextField.widthAnchor.constraint(equalToConstant: view.frame.size.width / 1.5),
            nameTextField.heightAnchor.constraint(equalToConstant: 40.0)
            ])
    }
    
    private func setupTimeStackView() {
        
        for option in options {
            let timeButtonView = TimeButtonView()
            let timeButtonViewModel = TimeButtonViewModel(title: option, tapAction: {
                print("We HERE")
            })
            timeButtonView.configure(with: timeButtonViewModel)
            timeButtonView.delegate = self
            timeButtonView.translatesAutoresizingMaskIntoConstraints = false
            stackView.addArrangedSubview(timeButtonView)
        }
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 24.0),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24.0),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24.0),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -24.0)
            ])
    }
}

