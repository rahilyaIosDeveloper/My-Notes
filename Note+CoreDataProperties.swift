//
//  Note+CoreDataProperties.swift
//  HW 5 Notes
//
//  Created by Rahilya Nazaralieva on 8/5/24.
//
//

import Foundation
import CoreData


extension Note {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Note> {
        return NSFetchRequest<Note>(entityName: "Note")
    }

    @NSManaged public var id: String?
    @NSManaged public var title: String?
    @NSManaged public var desc: String?
    @NSManaged public var date: Date?
    @NSManaged public var color: String?

}

extension Note : Identifiable {

}
