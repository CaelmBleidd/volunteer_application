//
//  SplashViewController.swift
//  volunteer_application
//
//  Created by Alexey Menshutin on 24.12.2019.
//  Copyright © 2019 Alexey Menshutin. All rights reserved.
//

import UIKit

////*****
//UserDefaults.standard.set(true, forKey: "isUserAuthenticated")
//
////*****
//
//var myViewController: UIViewController
//if (UserDefaults.standard.bool(forKey: "isUserAuthenticated")) {
//    myViewController = UIStoryboard(name: "Main", bundle: nil)
//        .instantiateViewController(withIdentifier: "InitialViewController") as! UINavigationController
//} else {
//    myViewController = UIStoryboard(name: "Main", bundle: nil)
//        .instantiateViewController(identifier: "LoginViewController") as! LoginViewController
//}
//
//
//window.rootViewController = myViewController
//window.makeKeyAndVisible()

class SplashViewController: UIViewController {

    class SplashViewController: UIViewController {
       private let activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
       override func viewDidLoad() {
          super.viewDidLoad()
          view.backgroundColor = UIColor.white
          view.addSubview(activityIndicator)
          activityIndicator.frame = view.bounds
          activityIndicator.backgroundColor = UIColor(white: 0, alpha: 0.4)
          makeServiceCall()
       }
       private func makeServiceCall() {
          activityIndicator.startAnimating()
          DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(3)) {
             self.activityIndicator.stopAnimating()
             
             if UserDefaults.standard.bool(forKey: "isUserAuthentificated") {
                // navigate to protected page
             } else {
                // navigate to login screen
             }
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
