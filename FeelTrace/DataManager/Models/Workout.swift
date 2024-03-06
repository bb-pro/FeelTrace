//
//  Workout+CoreDataProperties.swift
//  FeelTrace
//
//  Created by Bektemur Mamashayev on 6/3/2024.
//
//

import Foundation
import CoreData

@objc(Workout)
public class Workout: NSManagedObject {}

extension Workout {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Workout> {
        return NSFetchRequest<Workout>(entityName: "Workout")
    }

    @NSManaged public var title: String?
    @NSManaged public var date: Date?
    @NSManaged public var emotion: String?
    @NSManaged public var stressAmount: Double
    @NSManaged public var fatigueAmount: Double
    @NSManaged public var intensityAmount: Double
    @NSManaged public var time: String?

}


extension Workout : Identifiable {}
