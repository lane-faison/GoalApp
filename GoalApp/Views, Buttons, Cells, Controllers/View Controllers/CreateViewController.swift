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
    
    private var divider: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.primaryLightGray
        return view
    }()
    
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
    
    private var selectedCompletionTime: CompletionTime?
    
    private lazy var goalHelper = GoalsHelper()
    private lazy var toasterHelper = ToastHelper()
    
    // Goal to be edited
    var goal: Goal? {
        didSet {
            configureEditingMode(with: goal)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.primaryBackgroundColor
        
        setupNameTextField()
        setupChooseLabel()
        setupButtons()
        setupTimeStackView()
        
        let viewTapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped(_:)))
        view.addGestureRecognizer(viewTapGesture)
    }
}

// MARK: - Button stack methods
extension CreateViewController {
    @objc func cancelTapped() {
        dismiss(animated: false, completion: nil)
    }
    
    @objc func submitTapped() {
        if nameTextField.text?.isEmpty ?? true || nameTextField.text == nil || nameTextField.text == "" {
            toasterHelper.presentToast(from: self, type: .missingName)
            return
        } else if selectedCompletionTime == nil {
            toasterHelper.presentToast(from: self, type: .missingTime)
            return
        }
        
        guard let name = nameTextField.text, let time = selectedCompletionTime else {
                toasterHelper.presentToast(from: self, type: .genericError)
                return
        }
        
        if let editedGoal = goal {
            goalHelper.editGoal(editedGoal, toName: name, toCompletionTime: time) { [weak self] in
                self?.dismiss(animated: true, completion: nil)
            }
        } else {
            goalHelper.createGoal(name: name, completionTime: time) { [weak self] in
                self?.dismiss(animated: true, completion: nil)
            }
        }
    }
}

// MARK: - Methods specific to when the user is editing a goal
extension CreateViewController {
    private func configureEditingMode(with goal: Goal?) {
        guard let goal = goal else { return }
        
        nameTextField.text = goal.name
        
        for option in optionButtons where option.completionTime == goal.completionTime {
            selectedCompletionTime = option.completionTime
            option.isSelected = true
        }
    }
}

// MARK: - View setup
extension CreateViewController {
    
    private func setupNameTextField() {
        view.addSubview(nameTextField)
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        nameTextField.delegate = self
        NSLayoutConstraint.activate([
            nameTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 64.0),
            nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            nameTextField.heightAnchor.constraint(equalToConstant: 50.0)
            ])
        
        view.addSubview(divider)
        divider.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            divider.leadingAnchor.constraint(equalTo: nameTextField.leadingAnchor),
            divider.trailingAnchor.constraint(equalTo: nameTextField.trailingAnchor),
            divider.topAnchor.constraint(equalTo: nameTextField.bottomAnchor),
            divider.heightAnchor.constraint(equalToConstant: 1.0)
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
            let time = sender.completionTime else { return }
        
        selectedCompletionTime = time
        
        for optionButton in optionButtons {
            if optionButton.tag != sender.tag {
                optionButton.isSelected = false
            }
        }
        sender.isSelected = !sender.isSelected
        
        if !sender.isSelected {
            selectedCompletionTime = nil
        }
    }
}

// MARK: - TextView delegate methods & related methods
extension CreateViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @objc private func viewTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
}
