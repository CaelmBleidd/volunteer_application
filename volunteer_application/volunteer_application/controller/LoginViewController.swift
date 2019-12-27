//
//  LoginViewController.swift
//  volunteer_application
//
//  Created by Alexey Menshutin on 23.12.2019.
//  Copyright © 2019 Alexey Menshutin. All rights reserved.
//

import UIKit
import CoreData

class LoginViewController: UIViewController {

    @IBOutlet weak var loginField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginButton.isEnabled = false
        [loginField, passwordField].forEach({ $0.addTarget(self, action: #selector(editingChanged), for: .editingChanged) })
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
        
        self.view.showBlurLoader()
        
        DispatchQueue.main.async {
            ServerApi.auth(userCredentials: UserCredentials(login: self.loginField.text!, password: self.passwordField.text!), dGroup: group) { person -> Void in
                currentPerson = person
            }
        }
        
        group.notify(queue: .main) {
            self.view.removeBluerLoader()
            if (currentPerson != nil) {
                UserDefaults.standard.set(currentPerson?.id ,forKey: "currentUserId")
                UserDefaults.standard.set(true, forKey: "isUserAuthentificated")
                
                let appDelegate = UIApplication.shared.delegate as? AppDelegate
                if let context = appDelegate?.persistentContainer.viewContext {
                    let user = User(context: context)
                    user.name = currentPerson?.name
                    user.surname = currentPerson?.surname
                    user.patronymic = currentPerson?.patronymic
                    user.group = currentPerson?.group
                    user.user_id = currentPerson!.id
                    user.email = currentPerson?.email
                    user.phone = currentPerson?.phone
                    user.photo_link = currentPerson?.photo_link
                    user.verified = currentPerson!.verified
                    user.rating = currentPerson!.rating
                    user.login = currentPerson?.login
                    print (user)
                    try! context.save()
                }

                let vc = UIStoryboard(name: "Main", bundle:nil)
                    .instantiateViewController(withIdentifier: "InitialViewController") as! UITabBarController
                UIApplication.shared.windows.first?.rootViewController = vc
                UIApplication.shared.windows.first?.makeKeyAndVisible()
                
                           
            } else {
                print ("Wrong login or password")
            }
        }
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
