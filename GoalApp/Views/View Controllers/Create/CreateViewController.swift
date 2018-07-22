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
    
    var goal = Goal()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupNavBar()
    }
}

extension CreateViewController {
    @objc func cancelTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func saveTapped() {
        if let realm = try? Realm() {
            goal.name = "Test name"
            goal.monthsToComplete = 2
            goal.status = .notStarted
            
            try? realm.write {
                realm.add(goal)
            }
            
            navigationController?.popViewController(animated: true)
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
}

