//
//  Event.swift
//  volunteer_application
//
//  Created by Alexey Menshutin on 03.12.2019.
//  Copyright © 2019 Alexey Menshutin. All rights reserved.
//

import Foundation

class Event {
    init(_ title: String, _ tasks: Array<Task>, _ members: Array<Person>, _ roles: Dictionary<Person, Person.Role>) {
        self.title = title
        self.tasks = tasks
        self.members = members
        self.roles = roles
    }
    
    
    var title: String
    var tasks: Array<Task>
    var members: Array<Person>
    var roles: Dictionary<Person, Person.Role>
}
