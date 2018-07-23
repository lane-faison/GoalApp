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
    
    private var nameTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.borderWidth = 2.0
        textField.layer.cornerRadius = 2.0
        return textField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupNavBar()
        setupNameTextField()
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

extension CreateViewController {
    
    private func setupNavBar() {
        let leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelTapped))
        let rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveTapped))
        
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
}

