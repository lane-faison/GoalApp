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
        return 60
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
        navigationController?.pushViewController(createViewController, animated: true)
    }
}

extension HomeViewController {
    
    private func setupNavBar() {
        title = "Goals"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(goToCreateGoal))
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
    }
}
