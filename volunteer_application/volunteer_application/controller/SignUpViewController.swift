//
//  SignUpViewController.swift
//  volunteer_application
//
//  Created by Alexey Menshutin on 23.12.2019.
//  Copyright © 2019 Alexey Menshutin. All rights reserved.
//

import UIKit




class SignUpViewController: UIViewController {

    @IBOutlet weak var submitButton: UIButton!
        
    @IBOutlet weak var nameField: UITextField!

    @IBOutlet weak var lastNameField: UITextField!

    @IBOutlet weak var groupField: UITextField!
    
    @IBOutlet weak var emailField: UITextField!

    @IBOutlet weak var phoneNumberField: UITextField!

    @IBOutlet weak var loginField: UITextField!

    @IBOutlet weak var passwordField: UITextField!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        submitButton.isEnabled = false
        [nameField, lastNameField, groupField, emailField, phoneNumberField, loginField, passwordField]
            .forEach({ $0.addTarget(self, action: #selector(editingChanged), for: .editingChanged) })
        // Do any additional setup after loading the view.
        
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    @objc func editingChanged(_ textField: UITextField) {
        if textField.text?.count == 1 {
            if textField.text?.first == " " {
                textField.text = ""
                return
            }
        }
        guard
            let name = nameField.text, !name.isEmpty,
            let lastName = lastNameField.text, !lastName.isEmpty,
            let group = groupField.text, !group.isEmpty,
            let email = emailField.text, !email.isEmpty,
            let phoneNumber = phoneNumberField.text, !phoneNumber.isEmpty,
            let login = loginField.text, !login.isEmpty,
            let password = passwordField.text, !password.isEmpty
    
        else {
            submitButton.isEnabled = false
            return
        }
        submitButton.isEnabled = true
    }
    
    @IBAction func submitAction(_ sender: Any) {
        let curPerson = Person(
            0,
            nameField.text!,
            lastNameField.text!,
            nil,
            groupField.text!,
            emailField.text!,
            phoneNumberField.text!,
            nil,
            1500,
            false,
            loginField.text!)
        
        var personFromServer: Person? = nil
        
        
        let group = DispatchGroup()
        group.enter()
        group.enter()
        
        let password = self.passwordField.text!
        
        self.view.showBlurLoader()
        DispatchQueue.main.async {
            ServerApi.register(person: curPerson, dGroup: group) { (person) -> Void in
                ServerApi.addPassword(userCredentials: UserCredentials(login: curPerson.login, password: password), dGroup: group)
                personFromServer = person
            }
        }
        
        
    
        group.notify(queue: .main) {
            self.view.removeBluerLoader()
            if (personFromServer != nil) {
                UserDefaults.standard.set(personFromServer?.id ,forKey: "currentUserId")
                UserDefaults.standard.set(true, forKey: "isUserAuthentificated")
                
                let vc = UIStoryboard(name: "Main", bundle:nil)
                    .instantiateViewController(withIdentifier: "InitialViewController") as! UITabBarController
                UIApplication.shared.windows.first?.rootViewController = vc
                UIApplication.shared.windows.first?.makeKeyAndVisible()


                /*
                 let alert = UIAlertController(title: "New Name",
                                               message: "Add a new name",
                                               preferredStyle: .alert)
                 
                 let saveAction = UIAlertAction(title: "Save",
                                                style: .default) {
                   [unowned self] action in
                                                 
                   guard let textField = alert.textFields?.first,
                     let nameToSave = textField.text else {
                       return
                   }
                   
                   self.names.append(nameToSave)
                   self.tableView.reloadData()
                 }
                 
                 let cancelAction = UIAlertAction(title: "Cancel",
                                                  style: .cancel)
                 
                 alert.addTextField()
                 
                 alert.addAction(saveAction)
                 alert.addAction(cancelAction)
                 
                 present(alert, animated: true)
                 */
            } else {
                //show alert
            }
        }
        

        
        
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


/*
  @IBAction func submitAction(_ sender: Any) {
         // here will be request

         
         
         
 //        let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
 //
 //        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
 //        loadingIndicator.hidesWhenStopped = true
 //        loadingIndicator.style = UIActivityIndicatorView.Style.medium
 //        loadingIndicator.startAnimating();
 //
 //        alert.view.backgroundColor = .black
 //        alert.view.addSubview(loadingIndicator)
 //        alert.modalPresentationStyle = .overFullScreen
 //        alert.modalTransitionStyle = .flipHorizontal
 //
 //        print (alert.isBeingPresented)
 //        self.present(alert, animated: true, completion: nil)
 //        self.dismiss(animated: false, completion: nil)
 //        print (alert.isBeingPresented)
 //
 //        for _ in 0...10000 {
 //        }
 //
 //        alert.dismiss(animated: false, completion: nil)

         
 //        let requestResultAlert = UIAlertController(title: "Registration success", message: nil, preferredStyle: .alert)

         if ([true, false].randomElement()!) {     // result && currentUser != nil) {
 //            requestResultAlert = UIAlertController(title: "Registration success", message: "Request fail message"/* request fail message*/, preferredStyle: .alert
 //
 //            self.present(requestResultAlert, animated: true, completion: nil)
 //
 //            let when = DispatchTime.now() + 10
 //            DispatchQueue.main.asyncAfter(deadline: when){
 //              requestResultAlert.dismiss(animated: true, completion: nil)
 //            }
             
             UserDefaults.standard.set(true, forKey: "isUserAuthenticated")
 //            UserDefaults.standard.set(currentUser!.id, forKey: "currentUserId")

             
             let vc = UIStoryboard(name: "Main", bundle:nil)
                 .instantiateViewController(withIdentifier: "InitialViewController") as! UITabBarController
             UIApplication.shared.windows.first?.rootViewController = vc
             UIApplication.shared.windows.first?.makeKeyAndVisible()

         } else {
 //            requestResultAlert.title = "An error occurred"
 //            requestResultAlert.message = "Here will be the error message"
 //            requestResultAlert.addAction(
 //                UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
 //                    UIAlertAction in
 //                    NSLog("OK Pressed")
 //            })
 //            self.present(requestResultAlert, animated: true, completion: nil)
             
             
         }
         
         
     }
     
     

     /*
     // MARK: - Navigation

     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         // Get the new view controller using segue.destination.
         // Pass the selected object to the new view controller.
     }
     */

 }

 */
