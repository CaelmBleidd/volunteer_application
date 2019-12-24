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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    
    
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
