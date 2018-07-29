//
//  HomeViewController.swift
//  GoalApp
//
//  Created by Lane Faison on 7/21/18.
//  Copyright © 2018 Lane Faison. All rights reserved.
//

import UIKit
import RealmSwift

class HomeViewController: UIViewController {
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor.primaryLightGray
        
        return tableView
    }()
    
    var goals: Results<Goal>?
    private lazy var goalsHelper = GoalsHelper()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        goals = goalsHelper.getGoals()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "HomeGoalTableViewCell", bundle: nil), forCellReuseIdentifier: "homeGoalCell")
        setupNavBar()
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return goals?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "homeGoalCell") as? HomeGoalTableViewCell else { return UITableViewCell() }
        
        guard let goal = goals?[indexPath.row] else { return UITableViewCell() }
        
        let cellViewModel = HomeGoalTableViewCellModel(goal: goal)
        cell.configure(with: cellViewModel)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let goal = goals?[indexPath.row] else { return }
        
        switch goal.status {
        case .notStarted:
            goalsHelper.updateGoal(goal, with: .inProgress)
        case .inProgress:
            goalsHelper.updateGoal(goal, with: .completed)
        case .completed:
            goalsHelper.updateGoal(goal, with: .didNotFinish)
        case .didNotFinish:
            goalsHelper.updateGoal(goal, with: .notStarted)
        }
        
        tableView.reloadRows(at: [indexPath], with: .fade)
    }
}

extension HomeViewController {
    @objc private func goToCreateGoal() {
        let createViewController = CreateViewController()
        navigationController?.present(createViewController, animated: true, completion: nil)
    }
}

extension HomeViewController {
    
    private func setupNavBar() {
        title = "Goals"
        let rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(goToCreateGoal))
        rightBarButtonItem.tintColor = UIColor.black
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.contentInsetAdjustmentBehavior = .never
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 64.0),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
    }
}
