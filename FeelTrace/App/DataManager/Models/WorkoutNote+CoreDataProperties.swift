//
//  WorkoutNote+CoreDataProperties.swift
//  FeelTrace
//
//  Created by Bektemur Mamashayev on 12/3/2024.
//
//

import Foundation
import CoreData

@objc(WorkoutNote)
public class WorkoutNote: NSManagedObject {

}

extension WorkoutNote {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WorkoutNote> {
        return NSFetchRequest<WorkoutNote>(entityName: "WorkoutNote")
    }

    @NSManaged public var date: Date?
    @NSManaged public var isFavorite: Bool
    @NSManaged public var noteTitle: String?
    @NSManaged public var note: String?

}

extension WorkoutNote : Identifiable {

}
