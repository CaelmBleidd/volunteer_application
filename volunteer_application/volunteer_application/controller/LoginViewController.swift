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
                
//
//                let person = NSEntityDescription.insertNewObject(forEntityName: "Person", into: moc)
//                person.setValue(currentPerson?.name, forKey: "name")
//                person.setValue(currentPerson?.surname, forKey: "surname")
//                person.setValue(currentPerson?.patronymic, forKey: "patronymic")
//                person.setValue(currentPerson?.group, forKey: "group")
//                person.setValue(currentPerson?.id, forKey: "id")
//                person.setValue(currentPerson?.email, forKey: "email")
//                person.setValue(currentPerson?.phone, forKey: "phone")
//                person.setValue(currentPerson?.photo_link, forKey: "photo_link")
//                person.setValue(currentPerson?.verified, forKey: "verified")
//                person.setValue(currentPerson?.rating, forKey: "rating")
//                person.setValue(currentPerson?.login, forKey: "login")


                
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
     func saveName(name: String) {
       //1
       let appDelegate =
       UIApplication.sharedApplication().delegate as! AppDelegate
      
       let managedContext = appDelegate.managedObjectContext!
      
       //2
       let entity =  NSEntityDescription.entityForName("Person",
         inManagedObjectContext:
         managedContext)
      
       let person = NSManagedObject(entity: entity!,
         insertIntoManagedObjectContext:managedContext)
      
       //3
       person.setValue(name, forKey: "name")
      
       //4
       var error: NSError?
       if !managedContext.save(&error) {
           println("Could not save \(error), \(error?.userInfo)")
       }
       //5
       people.append(person)
     }
     */
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
