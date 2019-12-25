//
//  TaskTableViewCell.swift
//  volunteer_application
//
//  Created by Alexey Menshutin on 04.12.2019.
//  Copyright © 2019 Alexey Menshutin. All rights reserved.
//

import UIKit

class TaskTableViewCell: UITableViewCell {

    //MARK: Properties
    @IBOutlet weak var taskTitle: UILabel!
    @IBOutlet weak var infoButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
