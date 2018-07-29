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
    
    var tableGoalData: [SectionData]?
    
    private lazy var goalsHelper = GoalsHelper()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "HomeGoalTableViewCell", bundle: nil), forCellReuseIdentifier: "homeGoalCell")
        setupNavBar()
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableGoalData = goalsHelper.getTableData()
        tableView.reloadData()
    }
}

// MARK: -TableView methods
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return tableGoalData?[section].0.rawValue
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        guard let completionTimesSet = goalsHelper.getCompletionTimesSet() else { return 0 }
        
        return completionTimesSet.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableGoalData?[section].1.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "homeGoalCell") as? HomeGoalTableViewCell else { return UITableViewCell() }
        
        guard let goal = tableGoalData?[indexPath.section].1[indexPath.row] else { return UITableViewCell() }
        
        let cellViewModel = HomeGoalTableViewCellModel(goal: goal)
        cell.configure(with: cellViewModel)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let goal = tableGoalData?[indexPath.section].1[indexPath.row] else { return }
        
        goalsHelper.advanceGoalToNextStatus(for: goal)
        tableView.reloadRows(at: [indexPath], with: .fade)
    }
}

// MARK: - Button actions
extension HomeViewController {
    @objc private func goToCreateGoal() {
        let createViewController = CreateViewController()
        navigationController?.present(createViewController, animated: true, completion: nil)
    }
}

// MARK: - UI Setup methods
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
