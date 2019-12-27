//
//  Task.swift
//  volunteer_application
//
//  Created by Alexey Menshutin on 26.11.2019.
//  Copyright © 2019 Alexey Menshutin. All rights reserved.
//

import Foundation


class Task: Codable {
    
    init(id: Int64, title: String, description: String?, status: String) {
        self.id = id
        self.title = title
        self.description = description
        self.status = status
    }
    
    
    var id: Int64
    var title: String
    var description: String?
    var status: String
    
    //todo images
}
