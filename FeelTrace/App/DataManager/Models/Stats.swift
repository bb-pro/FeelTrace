//
//  Stats+CoreDataProperties.swift
//  FeelTrace
//
//  Created by Bektemur Mamashayev on 10/3/2024.
//
//

import Foundation
import CoreData


@objc(Stats)
public class Stats: NSManagedObject {}

extension Stats {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Stats> {
        return NSFetchRequest<Stats>(entityName: "Stats")
    }

    @NSManaged public var emotionIndex: Int16
    @NSManaged public var monthIndex: Int16
    @NSManaged public var timeSpent: String?
    @NSManaged public var workoutType: String?

}

extension Stats : Identifiable {

}
