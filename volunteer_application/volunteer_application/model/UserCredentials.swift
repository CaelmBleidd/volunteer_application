//
//  Task.swift
//  volunteer_application
//
//  Created by Alexey Menshutin on 25.12.2019.
//  Copyright © 2019 Alexey Menshutin. All rights reserved.
//

import Foundation


class UserCredentials: Codable {
    
    init(login: String, password: String) {
        self.login = login
        self.password = password
    }
    
    var login: String
    var password: String
 
    
    //todo images
}
