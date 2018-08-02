//
//  GoalsHelper.swift
//  GoalApp
//
//  Created by Lane Faison on 7/21/18.
//  Copyright © 2018 Lane Faison. All rights reserved.
//

import Foundation
import RealmSwift

public typealias SectionData = (CompletionTime, [Goal])

struct GoalsHelper {
    
    private func getGoals() -> Results<Goal>? {
        if let realm = try? Realm() {
            let goals = realm.objects(Goal.self).sorted(byKeyPath: "created")
            return goals
        } else {
            return nil
        }
    }
    
    func getCompletionTimesSet() -> Set<CompletionTime>? {
        guard let goals = getGoals() else { return nil }
        
        var goalCategorySet = Set<CompletionTime>()
        
        for goal in goals {
            if !goalCategorySet.contains(goal.completionTime) {
                goalCategorySet.insert(goal.completionTime)
            }
        }
        return goalCategorySet
    }
    
    func getTableData() -> [SectionData]? {
        guard let goals = getGoals(), let completionTimesSet = getCompletionTimesSet() else { return nil }
        var tableData: [SectionData] = []
        
        for completionTime in completionTimesSet {
            tableData.append((completionTime, []))
        }
        
        for goal in goals {
            if let index = tableData.index(where: { $0.0 == goal.completionTime }) {
                tableData[index].1.append(goal)
            }
        }
        
        let sortedTableData = tableData.sorted(by: { $0.0.hashValue < $1.0.hashValue })
        
        return sortedTableData
    }
    
    func createGoal(name: String, completionTime: CompletionTime, completion: (() -> Void)?) {
        if let realm = try? Realm() {
            let goal = Goal()
            goal.name = name
            goal.completionTime = completionTime
            
            try? realm.write {
                realm.add(goal)
                completion?()
            }
        }
    }
    
    func updateGoal(_ goal: Goal, with status: Status) {
        if let realm = try? Realm() {
            try? realm.write {
                goal.status = status
            }
        }
    }
    
    func deleteGoal(_ goal: Goal, completion: (() -> Void)?) {
        if let realm = try? Realm() {
            try? realm.write {
                realm.delete(goal)
                completion?()
            }
        }
    }
}

// MARK: - Icons and Statuses
extension GoalsHelper {
    
    func getIcon(for status: Status) -> UIImage? {
        switch status {
        case .notStarted:
            return UIImage(named: "play")?.withRenderingMode(.alwaysTemplate)
        case .inProgress:
            return UIImage(named: "refresh")?.withRenderingMode(.alwaysTemplate)
        case .completed:
            return UIImage(named: "ok")?.withRenderingMode(.alwaysTemplate)
        case .didNotFinish:
            return UIImage(named: "cancel")?.withRenderingMode(.alwaysTemplate)
        }
    }
    
    func getIconTintColor(for status: Status) -> UIColor {
        switch status {
        case .notStarted:
            return UIColor.primaryLightGreen
        case .inProgress:
            return UIColor.primaryBlue
        case .completed:
            return UIColor.primaryGreen
        case .didNotFinish:
            return UIColor.primaryRed
        }
    }
    
    func advanceGoalToNextStatus(for goal: Goal) {
        switch goal.status {
        case .notStarted:
            updateGoal(goal, with: .inProgress)
        case .inProgress:
            updateGoal(goal, with: .completed)
        case .completed:
            updateGoal(goal, with: .didNotFinish)
        case .didNotFinish:
            updateGoal(goal, with: .notStarted)
        }
    }
}

// MARK: - Date Helpers
extension GoalsHelper {
    
    func getShortFormattedDate(from goal: Goal) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        
        switch goal.completionTime {
        case .oneDay:
            guard let date = NSCalendar.current.date(byAdding: .day, value: 1, to: goal.created) else { return nil }
            return dateFormatter.string(from: date)
        case .oneWeek:
            guard let date = NSCalendar.current.date(byAdding: .day, value: 7, to: goal.created) else { return nil }
            return dateFormatter.string(from: date)
        case .oneMonth:
            guard let date = NSCalendar.current.date(byAdding: .month, value: 1, to: goal.created) else { return nil }
            return dateFormatter.string(from: date)
        case .sixMonths:
            guard let date = NSCalendar.current.date(byAdding: .month, value: 6, to: goal.created) else { return nil }
            return dateFormatter.string(from: date)
        case .oneYear:
            guard let date = NSCalendar.current.date(byAdding: .year, value: 1, to: goal.created) else { return nil }
            return dateFormatter.string(from: date)
        case .fiveYears:
            guard let date = NSCalendar.current.date(byAdding: .year, value: 5, to: goal.created) else { return nil }
            return dateFormatter.string(from: date)
        }
    }
    
    func getDueDate(creationDate: Date, timeToComplete: CompletionTime) -> Date? {
        switch timeToComplete {
        case .oneDay:
            return NSCalendar.current.date(byAdding: .day, value: 1, to: creationDate)
        case .oneWeek:
            return NSCalendar.current.date(byAdding: .day, value: 7, to: creationDate)
        case .oneMonth:
            return NSCalendar.current.date(byAdding: .month, value: 1, to: creationDate)
        case .sixMonths:
            return NSCalendar.current.date(byAdding: .month, value: 6, to: creationDate)
        case .oneYear:
            return NSCalendar.current.date(byAdding: .year, value: 1, to: creationDate)
        case .fiveYears:
            return NSCalendar.current.date(byAdding: .year, value: 5, to: creationDate)
        }
    }
}
