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
    
    var optionButtons: [TimeButton] = {
        var array: [TimeButton] = []
        CompletionTime.allValues.forEach {
            array.append(TimeButton(completionTime: $0))
        }
        return array
    }()
    
    private var nameTextField = PrimaryTextField(type: .required)
    
    private var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = -1
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private var submitButton: SubmitButton = {
        let button = SubmitButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.primaryLightGray
        
        setupNavBar()
        setupNameTextField()
        setupSubmitButton()
        setupTimeStackView()
    }
}

extension CreateViewController {
    @objc func cancelTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func submitTapped() {
        guard let name = nameTextField.text, !name.isEmpty  else { return }
        
        GoalsHelper().createGoal(name: name, completionTime: .oneDay) {
            self.navigationController?.popViewController(animated: true)
        }
    }
}

extension CreateViewController {
    
    private func setupNavBar() {
        let leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelTapped))
        leftBarButtonItem.tintColor = UIColor.primaryRed
        navigationItem.leftBarButtonItem = leftBarButtonItem
    }
    
    private func setupNameTextField() {
        view.addSubview(nameTextField)
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 64.0),
            nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            nameTextField.heightAnchor.constraint(equalToConstant: 50.0)
            ])
    }
    
    private func setupSubmitButton() {
        view.addSubview(submitButton)
        NSLayoutConstraint.activate([
            submitButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            submitButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            submitButton.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            submitButton.heightAnchor.constraint(equalToConstant: 64.0)
            ])
        submitButton.addTarget(self, action: #selector(submitTapped), for: .touchUpInside)
    }
    
    private func setupTimeStackView() {
        
        for (index, optionButton) in optionButtons.enumerated() {
            optionButton.tag = index
            optionButton.addTarget(self, action: #selector(timeButtonTapped), for: .touchUpInside)
            stackView.addArrangedSubview(optionButton)
        }
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 24.0),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: submitButton.topAnchor, constant: -1 * view.frame.size.height / 4)
            ])
    }
    
    @objc private func timeButtonTapped(sender: UIButton) {
        guard let sender = sender as? TimeButton,
            let type = sender.completionTime else { return }
        
        for optionButton in optionButtons {
            if optionButton.tag != sender.tag {
                optionButton.isSelected = false
            }
        }
        sender.isSelected = !sender.isSelected
    }
}
