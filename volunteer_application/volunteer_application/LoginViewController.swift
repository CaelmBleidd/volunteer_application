//
//  LoginViewController.swift
//  volunteer_application
//
//  Created by Alexey Menshutin on 23.12.2019.
//  Copyright © 2019 Alexey Menshutin. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var loginField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginButton.isEnabled = false
        [loginField, passwordField].forEach({ $0.addTarget(self, action: #selector(editingChanged), for: .editingChanged) })
            // Do any additional setup after loading the view.
    }
        
    @objc func editingChanged(_ textField: UITextField) {
        if textField.text?.count == 1 {
            if textField.text?.first == " " {
                textField.text = ""
                return
            }
        }
        guard
            let login = loginField.text, !login.isEmpty,
            let password = passwordField.text, !password.isEmpty
    
        else {
            loginButton.isEnabled = false
            return
        }
        loginButton.isEnabled = true
    }
    
    
    @IBAction func loginAction(_ sender: Any) {
        var currentPerson: Person?
        
        let group = DispatchGroup()
        group.enter()
        

        ServerApi.auth(userCredentials: UserCredentials(login: loginField.text!, password: passwordField.text!), dGroup: group) { person -> Void in
            currentPerson = person
        }
    
        group.notify(queue: .main) {
            if (currentPerson != nil) {
                UserDefaults.standard.set(currentPerson?.id ,forKey: "currentUserId")
                UserDefaults.standard.set(true, forKey: "isUserAuthentificated")

                let vc = UIStoryboard(name: "Main", bundle:nil)
                    .instantiateViewController(withIdentifier: "InitialViewController") as! UITabBarController
                UIApplication.shared.windows.first?.rootViewController = vc
                UIApplication.shared.windows.first?.makeKeyAndVisible()

            } else {
                //show alert
            }
        }
    }
    
    @IBAction func forgotPasswordAction(_ sender: Any) {
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
 */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    

}
