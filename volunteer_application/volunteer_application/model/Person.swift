//
//  Person.swift
//  volunteer_application
//
//  Created by Alexey Menshutin on 03.12.2019.
//  Copyright © 2019 Alexey Menshutin. All rights reserved.
//

import Foundation

class Person: Hashable, Equatable, Codable {
    static func == (lhs: Person, rhs: Person) -> Bool {
        return lhs.name == rhs.name && lhs.surname == rhs.surname && lhs.email == rhs.email
    }
    // MARK: Hashable
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(surname)
        hasher.combine(email)
    }

    
    
    init(_ id: Int64,
         _ name: String,
         _ surname: String,
         _ patronymic: String?,
         _ group: String?,
         _ email: String,
         _ phone_number: String?,
         _ photo_link: String?,
         _ rating: Int64,
         _ verified: Bool,
         _ login: String) {
        self.id = id
        self.name = name
        self.surname = surname
        self.patronymic = patronymic
        self.group = group
        self.email = email
        self.phone = phone_number
        self.photo_link = photo_link
        self.rating = rating
        self.verified = verified
        self.login = login
    }
    
    var id: Int64
    var name: String
    var surname: String
    var patronymic: String?
    var group: String?
    var email: String
    var phone: String?
    var photo_link: String?
    var rating: Int64
    var verified: Bool
    var login: String
    

    enum Role {
        case reserve, hall_manager, deputy_hall_manager, hall_volunteer, press, registration, entertainment_volunteer, tc_assistant, entertainment_manager, registration_manager, press_manager, director_of_operations, technical_committee, volunteer_manager, z_cancelled, system_administrator, contest_director, pcms_manager, balloon_manager, balloon_volunteer
    }
}
