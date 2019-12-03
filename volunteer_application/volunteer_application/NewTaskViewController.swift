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
    
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var bodyTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // Handle the text field’s user input through delegate callbacks.
        titleTextField.delegate = self
        
        // Enable the Save button only if the text field has a valid Meal name.
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
    
    
    //MARK: Private Methods
    private func updateSaveButtonState() {
        // Disable the Save button if the text field is empty.
        let text = titleTextField.text ?? ""
        saveButton.isEnabled = !text.isEmpty
    }
    
    
    // MARK: - Navigation
     
    @IBAction func cancel(_ sender: UIBarButtonItem) {
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
        let body = bodyTextField.text
        
        task = Task(title, body)
    }

}
