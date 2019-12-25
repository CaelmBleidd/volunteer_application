//
//  Task.swift
//  volunteer_application
//
//  Created by Alexey Menshutin on 26.11.2019.
//  Copyright © 2019 Alexey Menshutin. All rights reserved.
//

import Foundation


class Task {
    init(_ title: String) {
        self.title = title
        //todo
        self.event = nil
    }
    
    init(_ title: String, _ body: String?, _ event: Event) {
        self.title = title
        self.body = body
        self.event = event
    }
    
    var title: String
    var body: String? = nil
    var event: Event?
    
    //todo images
}
