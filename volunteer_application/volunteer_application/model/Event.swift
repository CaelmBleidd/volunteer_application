//
//  Event.swift
//  volunteer_application
//
//  Created by Alexey Menshutin on 03.12.2019.
//  Copyright © 2019 Alexey Menshutin. All rights reserved.
//

import Foundation

class Event {
    init(id: Int64, title: String, description: String?, beginDate: Int64, endDate: Int64, location: String, starred: Bool) {
        self.id = id
        self.title = title
        self.description = description
        self.beginDate = Date(milliseconds: beginDate)
        self.endDate = Date(milliseconds: endDate)
        self.location = location
        self.starred = starred
    }
    
    var id: Int64
    var title: String
    var description: String?
    var beginDate: Date
    var endDate: Date
    var location: String
    var starred: Bool
}
