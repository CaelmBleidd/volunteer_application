//
//  ThirdViewController.swift
//  volunteer_application
//
//  Created by Alexey Menshutin on 17.10.2019.
//  Copyright © 2019 Alexey Menshutin. All rights reserved.
//

import UIKit

class EventsViewController: UITableViewController {
    @IBOutlet weak var eventSelectSegmentControl: UISegmentedControl!
    
    var events = [Event]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        loadSampleEvents()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "EventTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? EventTableViewCell else {
            fatalError("The dequeued cell is not an instance of EventTableViewCell.")
        }
        let event = events[indexPath.row]
        cell.titleLabel.text = event.title
        cell.locationLabel.text = event.location
        cell.dateLabel.text = "\(event.beginDate.getOnlyDay()) –– \(event.endDate.getOnlyDay())"
        return cell
    }
    
    
    /*
     var id: Int64
     var title: String
     var description: String?
     var beginDate: Date
     var endDate: Date
     var location: String
     */
    private func loadSampleEvents() {
        let event1 = Event(id: 0, title: "title", description: "description", beginDate: Date().millisecondsSince1970, endDate: Date().millisecondsSince1970, location: "St. Petersburg", starred: false)
        let event2 = Event(id: 0, title: "title", description: "description", beginDate: Date().millisecondsSince1970, endDate: Date().millisecondsSince1970, location: "St. Petersburg", starred: true)
        let event3 = Event(id: 0, title: "title", description: "description", beginDate: Date().millisecondsSince1970, endDate: Date().millisecondsSince1970, location: "St. Petersburg", starred: false)
        events.append(event1)
        events.append(event2)
        events.append(event3)
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard let singleEventViewController = segue.destination as? SingleEventViewController else {
            fatalError("Unexpected destination: \(segue.destination)")
        }
        
        guard let selectedTaskCell = sender as? EventTableViewCell else {
            fatalError("Unexpected sender: \(String(describing: sender))")
        }
        
        guard let indexPath = tableView.indexPath(for: selectedTaskCell) else {
            fatalError("The selected cell is not being displayed by the table")
        }
        let selectedEvent = events[indexPath.row]
        
        singleEventViewController.event = selectedEvent
    }
    

}
