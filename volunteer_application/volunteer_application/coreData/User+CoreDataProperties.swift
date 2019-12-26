//
//  User+CoreDataProperties.swift
//  volunteer_application
//
//  Created by Alexey Menshutin on 26.12.2019.
//  Copyright © 2019 Alexey Menshutin. All rights reserved.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var name: String?
    @NSManaged public var surname: String?
    @NSManaged public var patronymic: String?
    @NSManaged public var email: String?
    @NSManaged public var login: String?
    @NSManaged public var verified: Bool
    @NSManaged public var phone: String?
    @NSManaged public var photo_link: String?
    @NSManaged public var rating: Int64
    @NSManaged public var id: Int64
    @NSManaged public var group: String?

}
