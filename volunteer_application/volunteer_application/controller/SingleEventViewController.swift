//
//  SingleEventViewController.swift
//  volunteer_application
//
//  Created by Alexey Menshutin on 26.12.2019.
//  Copyright © 2019 Alexey Menshutin. All rights reserved.
//

import UIKit

class SingleEventViewController: UIViewController {

    var event: Event?
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var descriptionView: UITextView!
    
    @IBOutlet weak var joinButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        descriptionView.isUserInteractionEnabled = false
        
        if let event = event {
            titleLabel.text = event.title
            descriptionView.text = "\(event.description ?? "There is no description for thid event")\n\nDate:\(event.startDate.getOnlyDay()) –– \(event.endDate.getOnlyDay())\n\nLocation: \(event.location)"
            
            if event.starred {
                joinButton.setTitle("Leave", for: .normal)
            } else {
                joinButton.setTitle("Join", for: .normal)
            }
        }
    }
    
    

    @IBAction func joinLeaveAction(_ sender: Any) {
        let group = DispatchGroup()
        group.enter()
        if joinButton.titleLabel?.text == "Join" {
            event?.starred = true
            DispatchQueue.main.async {
                ServerApi.subscribe(eventId: self.event!.id, userId: Int64(UserDefaults.standard.integer(forKey: "currentUserId")), dGroup: group)
            }
            group.notify(queue: .main) {
                self.joinButton.setTitle("Leave", for: .normal)
            }
        } else {
            event?.starred = false
            DispatchQueue.main.async {
                ServerApi.unsubscribe(eventId: self.event!.id, userId: Int64(UserDefaults.standard.integer(forKey: "currentUserId")), dGroup: group)
            }
            group.notify(queue: .main) {
                self.joinButton.setTitle("Join", for: .normal)
                
            }
        }
        
        //make request for participating
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
