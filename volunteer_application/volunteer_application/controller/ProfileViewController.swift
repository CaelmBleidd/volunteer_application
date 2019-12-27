//
//  ProfileViewController.swift
//  volunteer_application
//
//  Created by Alexey Menshutin on 17.10.2019.
//  Copyright © 2019 Alexey Menshutin. All rights reserved.
//

import UIKit
import CoreData

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var myImageView: UIImageView!
    var imagePicker: ImagePicker!

    
    @IBOutlet weak var nameField: UITextField!
    
    @IBOutlet weak var emailField: UITextField!
    
    @IBOutlet weak var phoneNumberField: UITextField!
    
    @IBOutlet weak var groupField: UITextField!
    
    @IBOutlet weak var ratingLabel: UILabel!
    
    @IBOutlet weak var login: UITextField!
    
    private func initContext() -> User? {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

        do {
            let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "user_id == %@", NSNumber(integerLiteral: UserDefaults.standard.integer(forKey: "currentUserId")))
            let result = try context.fetch(fetchRequest)
            return result.last
        } catch {
            print ("fetch task failed", error)
        }
    
        return nil
    }
    
    @IBAction func showImagePicker(_ sender: UIButton) {
        self.imagePicker.present(from: sender)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let currentUser = initContext()
   
        nameField.isUserInteractionEnabled = false
        emailField.isUserInteractionEnabled = false
        login.isUserInteractionEnabled = false
        phoneNumberField.isUserInteractionEnabled = false
        groupField.isUserInteractionEnabled = false
        
        nameField.text = "\(currentUser?.name ?? "Empty name field") \(currentUser?.surname ?? "")"
        emailField.text = "\(currentUser?.email ?? "Empty email field")"
        login.text = "\(currentUser?.login ?? "Empty login field")"
        phoneNumberField.text = "\(currentUser?.phone ?? "Empty phone number field")"
        groupField.text = "\(currentUser?.group ?? "Empty group field")"
        
        ratingLabel.text = "Rating: \(currentUser?.rating ?? 1500)"
        
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
        
        // Do any additional setup after loading the view.
    }

    
    @IBAction func logoutAction(_ sender: Any) {
        UserDefaults.standard.set(false, forKey: "isUserAuthentificated")
        UserDefaults.standard.removeObject(forKey: "currentUserId")
        let vc = UIStoryboard(name: "Main", bundle:nil)
            .instantiateViewController(withIdentifier: "LoginViewController") as! UINavigationController
        UIApplication.shared.windows.first?.rootViewController = vc
        UIApplication.shared.windows.first?.makeKeyAndVisible()
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

extension ProfileViewController: ImagePickerDelegate {

    func didSelect(image: UIImage?) {
        self.myImageView.image = image
    }
}
