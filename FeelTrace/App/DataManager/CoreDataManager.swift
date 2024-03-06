//
//  DataManager.swift
//  FeelTrace
//
//  Created by Bektemur Mamashayev on 6/3/2024.
//

import UIKit
import CoreData

public final class CoreDataManager: NSObject {
    public static let shared = CoreDataManager()
    private override init() {}
    
    private var appDelegate: AppDelegate? {
        return UIApplication.shared.delegate as? AppDelegate
    }
    
    private var context: NSManagedObjectContext? {
        return appDelegate?.persistentContainer.viewContext
    }
    
    //MARK: - Workout
    public func createWorkout(title: String, time: String, stressAmount: Double, fatigueAmount: Double, intensityAmount: Double, emotion: String, date: Date) {
        
        guard let unwrappedContext = context,
              let eventModelDescription = NSEntityDescription.entity(forEntityName: "Workout", in: unwrappedContext) else {
            return
        }
        
        let workout = Workout(entity: eventModelDescription, insertInto: unwrappedContext)
        workout.date = date
        workout.emotion = emotion
        workout.fatigueAmount = fatigueAmount
        workout.intensityAmount = intensityAmount
        workout.stressAmount = stressAmount
        workout.time = time
        workout.title = title
        
        appDelegate?.saveContext()
    }
    
    public func fetchArticles() -> [Workout] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Workout")
        
        do {
            if let fetchedObjects = try context?.fetch(fetchRequest) as? [Workout] {
                return fetchedObjects
            } else {
                print("Failed to cast fetched objects to [EventModel]")
            }
        } catch {
            print("Error during fetchEvents: \(error)")
        }
        
        return []
    }
    
    
}
