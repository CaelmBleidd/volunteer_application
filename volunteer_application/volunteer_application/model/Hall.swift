//
//  Hall.swift
//  volunteer_application
//
//  Created by Alexey Menshutin on 03.12.2019.
//  Copyright © 2019 Alexey Menshutin. All rights reserved.
//

import Foundation

class Hall {
    init(_ title: String) {
        self.title = title
        self.members = Array<Person>()
    }
    
    init(_ title: String, _ members: Array<Person>) {
        self.title = title
        self.members = members
    }
    
    var title: String
    var members: Array<Person>
    
}
