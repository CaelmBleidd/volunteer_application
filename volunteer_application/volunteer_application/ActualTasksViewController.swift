//
//  FirstViewController.swift
//  volunteer_application
//
//  Created by Alexey Menshutin on 13.10.2019.
//  Copyright © 2019 Alexey Menshutin. All rights reserved.
//

import UIKit

class ActualTasksViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    //MARK: Properties
    var tasks = [Task]()

    var tableView: UITableView {
        return view as! UITableView
    }

    //MARK: Actions
    @IBAction func unwindToTasksList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? NewTaskViewController, let task = sourceViewController.task {
            let newIndexPath = IndexPath(row: tasks.count, section: 0)
            tasks.append(task)
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        loadSampleTask()

        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(TaskTableViewCell.self, forCellReuseIdentifier: "TaskTableViewCell")
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell
        cell = tableView.dequeueReusableCell(withIdentifier: "TaskTableViewCell", for: indexPath)
        cell.textLabel?.text = "\(tasks[indexPath.row].title) \(indexPath.row + 1)"
        return cell
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        if let cached = layoutCache[indexPath] {
            return cached
        } else {
            return 44
        }
    }

    var layoutCache: [IndexPath: CGFloat] = [:]

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        layoutCache[indexPath] = 55
        return 55
    }


    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else {
            return
        }
        tasks.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .bottom)
    }

    
    //MARK: Private Methods
    private func loadSampleTask() {
        let task1 = Task("First sample task")
        let task2 = Task("Second sample")
        let task3 = Task("Third sample task")
        
        tasks += [task1, task2, task3]
    }

}
