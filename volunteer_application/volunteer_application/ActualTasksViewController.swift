//
//  FirstViewController.swift
//  volunteer_application
//
//  Created by Alexey Menshutin on 13.10.2019.
//  Copyright © 2019 Alexey Menshutin. All rights reserved.
//

import UIKit
import os.log

class ActualTasksViewController: UITableViewController {

    //MARK: Properties
    var tasks = [Task]()
    


    override func viewDidLoad() {
        super.viewDidLoad()

        loadSampleTask()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "TaskTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? TaskTableViewCell else {
            fatalError("The dequeued cell is not an instance of TaskTableViewCell.")
        }
        let task = tasks[indexPath.row]
        cell.taskTitle.text = task.title
        return cell
    }

    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteTitle = NSLocalizedString("Delete", comment: "Delete")
        let deleteAction = UIContextualAction(style: .normal, title: deleteTitle, handler: { (deleteAction, view, completionHandler) in
            self.tasks.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .bottom)
            completionHandler(true)
        })
        deleteAction.backgroundColor = .red
        
        let processingTitle = NSLocalizedString("Processing", comment: "Processing")
        let processingAction = UIContextualAction(style: .normal, title: processingTitle, handler: {
            (processingAction, view, completionHandler) in
            //todo
        })
        
        
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction, processingAction])
        return configuration
    }
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        //todo
        return nil
    }

    
    //MARK: Actions
    @IBAction func unwindToTasksList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? NewTaskViewController, let task = sourceViewController.task {
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                tasks[selectedIndexPath.row] = task
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            } else {
                let newIndexPath = IndexPath(row: tasks.count, section: 0)
                tasks.append(task)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }

        }
    }
    
    
    //MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        switch segue.identifier ?? "" {
        case "AddItem":
            os_log("Adding a new task", log: OSLog.default, type: .debug)
        case "ShowDetails":
            guard let taskDetailViewController = segue.destination as? NewTaskViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            guard let selectedTaskCell = sender as? TaskTableViewCell else {
                fatalError("Unexpected sender: \(String(describing: sender))")
            }
            
            guard let indexPath = tableView.indexPath(for: selectedTaskCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            
            let selectedTask = tasks[indexPath.row]
            
            taskDetailViewController.task = selectedTask

            
        default:
            fatalError("Unexpected Segue Identifier; \(String(describing: segue.identifier))")
        }
    }
    
    //MARK: Private Methods
    private func loadSampleTask() {
        let task1 = Task("First sample task")
        let task2 = Task("Second sample")
        let task3 = Task("Third sample task")
        
        tasks += [task1, task2, task3]
    }

}
