//
//  Person.swift
//  volunteer_application
//
//  Created by Alexey Menshutin on 03.12.2019.
//  Copyright © 2019 Alexey Menshutin. All rights reserved.
//

import Foundation

class Person: Hashable, Equatable {
    static func == (lhs: Person, rhs: Person) -> Bool {
        return lhs.first_name == rhs.first_name && lhs.last_name == rhs.last_name && lhs.email == rhs.email
    }
    // MARK: Hashable
    func hash(into hasher: inout Hasher) {
        hasher.combine(first_name)
        hasher.combine(last_name)
        hasher.combine(email)
    }

    
    
    init(_ first_name: String, _ last_name: String, _ group: String?, _ email: String, _ social: String?, _ phone_number: String?) {
        self.first_name = first_name
        self.last_name = last_name
        self.group = group
        self.email = email
        self.social = social
        self.phone_number = phone_number
    }
    
    var first_name: String
    var last_name: String
    var group: String?
    var email: String
    var social: String?
    var phone_number: String?
    
    enum Role {
        case reserve, hall_manager, deputy_hall_manager, hall_volunteer, press, registration, entertainment_volunteer, tc_assistant, entertainment_manager, registration_manager, press_manager, director_of_operations, technical_committee, volunteer_manager, z_cancelled, system_administrator, contest_director, pcms_manager, balloon_manager, balloon_volunteer
    }
}
