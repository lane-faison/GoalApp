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
    
    let headerHeight: CGFloat = 40.0
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = UIColor.primaryBackgroundColor
        return tableView
    }()
    
    var tableGoalData: [SectionData]?
    
    private lazy var goalsHelper = GoalsHelper()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
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
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let title = tableGoalData?[section].0.rawValue else { return nil }
        
        let headerFrame = CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: headerHeight)
        
        let headerView = HomeTableViewHeader(frame: headerFrame, title: "\(title) Goals")
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return headerHeight
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
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let editAction = UIContextualAction(style: .normal, title: "Edit") { [weak self] (action, view, success) in
            if let goal = self?.tableGoalData?[indexPath.section].1[indexPath.row] {
                self?.goToEditGoal(goal)
                success(true)
            }
        }
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [weak self] (action, view, success) in
            self?.deleteRow(from: tableView, at: indexPath)
            success(true)
        }
        
        editAction.backgroundColor = UIColor.primaryBlue
        deleteAction.backgroundColor = UIColor.primaryRed
        
        editAction.image = UIImage(named: "support")
        deleteAction.image = UIImage(named: "trash")
        
        let config = UISwipeActionsConfiguration(actions: [deleteAction, editAction])
        config.performsFirstActionWithFullSwipe = false
        return config
    }
}

// MARK: - Custom TableView methods
extension HomeViewController {
    
    private func deleteRow(from tableView: UITableView, at indexPath: IndexPath) {
        guard let goal = tableGoalData?[indexPath.section].1[indexPath.row] else { return }
        
        goalsHelper.deleteGoal(goal) { [weak self] in
            guard let strongSelf = self else { return }
            
            if strongSelf.tableGoalData?[indexPath.section].1.count == 1 {
                strongSelf.tableGoalData?.remove(at: indexPath.section)
                tableView.deleteSections([indexPath.section], with: .none)
            } else {
                strongSelf.tableGoalData?[indexPath.section].1.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .top)
            }
        }
    }
}

// MARK: - Button actions
extension HomeViewController {
    @objc private func goToCreateGoal() {
        let createViewController = CreateViewController()
        navigationController?.present(createViewController, animated: true, completion: nil)
    }
    
    @objc private func goToSettings() {
        let settingsViewController = SettingsViewController()
        navigationController?.pushViewController(settingsViewController, animated: true)
    }
    
    private func goToEditGoal(_ goal: Goal) {
        let createViewController = CreateViewController()
        createViewController.goal = goal
        navigationController?.present(createViewController, animated: true, completion: nil)
    }
}

// MARK: - UI Setup methods
extension HomeViewController {
    
    private func setupNavBar() {
        title = "Goals"
        let leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "pencil"), style: .plain, target: self, action: #selector(goToCreateGoal))
        leftBarButtonItem.tintColor = UIColor.primaryLightGray
        navigationItem.leftBarButtonItem = leftBarButtonItem
        
        let rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "settings"), style: .plain, target: self, action: #selector(goToSettings))
        rightBarButtonItem.tintColor = UIColor.primaryLightGray
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
