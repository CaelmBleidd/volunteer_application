//
//  NewTaskViewController.swift
//  volunteer_application
//
//  Created by Alexey Menshutin on 27.11.2019.
//  Copyright © 2019 Alexey Menshutin. All rights reserved.
//

import UIKit
import os.log

class NewTaskViewController: UIViewController, UITextFieldDelegate {

    var task: Task?
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    @IBOutlet weak var processButton: UIButton!
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var bodyTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // Handle the text field’s user input through delegate callbacks.
        titleTextField.delegate = self

        
        if let task = task {
            navigationItem.title = "See task"
            titleTextField.text = task.title
            bodyTextView.text = task.description
            
            titleTextField.isUserInteractionEnabled = false
            bodyTextView.isUserInteractionEnabled = false
            processButton.isHidden = false
            processButton.isEnabled = true
            
            let title = task.status == "proccess" ? "done" : "proccess"
 
            processButton.setTitle(title, for: .normal)
        } else {
            processButton.isEnabled = false
            processButton.isHidden = true
        }
        
        updateSaveButtonState()
    }
    
    
    //MARK: UITextFieldDelegate
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        saveButton.isEnabled = false
    }
    
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateSaveButtonState()
        navigationItem.title = textField.text
    }
    
    @IBAction func processAction(_ sender: Any) {
        let group = DispatchGroup()
        let status = processButton.titleLabel!.text
        if status == "done" {
            processButton.isEnabled = false
            processButton.isHidden = true
        } else {
            processButton.setTitle("done", for: .normal)
        }
        group.enter()
        DispatchQueue.main.async {
            ServerApi.updateStatus(taskId: self.task!.id, status: status!, dGroup: group)
        }
        
        group.notify(queue: .main) {
            self.task?.status = status ?? "new"
        }
    }
    
    //MARK: Private Methods
    private func updateSaveButtonState() {
        // Disable the Save button if the text field is empty.
        let text = titleTextField.text ?? ""
        saveButton.isEnabled = !text.isEmpty
    }
    
    
    // MARK: - Navigation
     
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        let isPresentingInAddTaskMode = presentingViewController is UINavigationController
        
        if isPresentingInAddTaskMode {
            dismiss(animated: true, completion: nil)
        } else if let owningNavigationController = navigationController {
            owningNavigationController.popViewController(animated: true)
        } else {
            fatalError("The TaskViewController is not inside a navigation controller.")
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }
        
        let title = titleTextField.text ?? ""
        let body = bodyTextView.text
        
        task = Task(id: 0, title: title, description: body, status: "new")
        let group = DispatchGroup()
        group.enter()
        
        DispatchQueue.main.async {
            ServerApi.createNewTask(task: self.task!, userId: Int64(UserDefaults.standard.integer(forKey: "currentUserId")), dGroup: group) { taskFromServer -> Void in
                self.task = taskFromServer
            }
        }
    }

}
