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
    
    private var chooseLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Choose one:"
        return label
    }()
    
    private var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = -1
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private var buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 1.0
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private var cancelButton = PrimaryButton(type: .cancel)
    private var submitButton = PrimaryButton(type: .submit)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.primaryLightGray
        
        setupNameTextField()
        setupChooseLabel()
        setupButtons()
        setupTimeStackView()
    }
}

extension CreateViewController {
    @objc func cancelTapped() {
        dismiss(animated: false, completion: nil)
    }
    
    @objc func submitTapped() {
        guard let name = nameTextField.text, !name.isEmpty  else { return }
        
        GoalsHelper().createGoal(name: name, completionTime: .oneDay) { [weak self] in
            guard let strongSelf = self else { return }
            
            strongSelf.dismiss(animated: true, completion: nil)
        }
    }
}

extension CreateViewController {
    
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
    
    private func setupChooseLabel() {
        view.addSubview(chooseLabel)
        chooseLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            chooseLabel.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 24.0),
            chooseLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16.0),
            chooseLabel.trailingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor),
            chooseLabel.heightAnchor.constraint(equalToConstant: 24.0)
            ])
    }
    
    private func setupButtons() {
        buttonStackView.addArrangedSubview(cancelButton)
        buttonStackView.addArrangedSubview(submitButton)
        
        view.addSubview(buttonStackView)
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            buttonStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            buttonStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            buttonStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            buttonStackView.heightAnchor.constraint(equalToConstant: 64.0)
            ])
        
        cancelButton.addTarget(self, action: #selector(cancelTapped), for: .touchUpInside)
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
            stackView.topAnchor.constraint(equalTo: chooseLabel.bottomAnchor, constant: 4.0),
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
