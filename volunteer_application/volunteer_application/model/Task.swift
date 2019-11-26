//
//  Task.swift
//  volunteer_application
//
//  Created by Alexey Menshutin on 26.11.2019.
//  Copyright © 2019 Alexey Menshutin. All rights reserved.
//

import Foundation

class Task {
    init(_ title: String, _ body: String?) {
        self.title = title
        self.body = body
    }
    var title: String
    var body: String?
}
