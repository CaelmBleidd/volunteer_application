//
//  EventData+CoreDataProperties.swift
//  volunteer_application
//
//  Created by Alexey Menshutin on 27.12.2019.
//  Copyright © 2019 Alexey Menshutin. All rights reserved.
//
//

import Foundation
import CoreData


extension EventData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<EventData> {
        return NSFetchRequest<EventData>(entityName: "EventData")
    }

    @NSManaged public var id: Int64
    @NSManaged public var title: String?
    @NSManaged public var eventDescription: String?
    @NSManaged public var startDate: Date?
    @NSManaged public var endDate: Date?
    @NSManaged public var location: String?
    @NSManaged public var starred: Bool

}
