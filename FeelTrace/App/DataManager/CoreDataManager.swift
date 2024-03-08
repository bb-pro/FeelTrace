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
    
    // Create a new workout entity
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
    
    // Fetch all workouts
    public func fetchWorkouts() -> [Workout] {
        let fetchRequest = NSFetchRequest<Workout>(entityName: "Workout")
        
        do {
            if let fetchedObjects = try context?.fetch(fetchRequest) {
                return fetchedObjects
            } else {
                print("Failed to fetch objects")
            }
        } catch {
            print("Error during fetchWorkouts: \(error)")
        }
        
        return []
    }
    
    // Delete a workout
    public func deleteWorkout(_ workout: Workout) {
        context?.delete(workout)
        appDelegate?.saveContext()
    }
    
    // Edit a workout
    public func editWorkout(_ workout: Workout, title: String, time: String, stressAmount: Double, fatigueAmount: Double, intensityAmount: Double, emotion: String, date: Date) {
        workout.title = title
        workout.time = time
        workout.stressAmount = stressAmount
        workout.fatigueAmount = fatigueAmount
        workout.intensityAmount = intensityAmount
        workout.emotion = emotion
        workout.date = date
        
        appDelegate?.saveContext()
    }
}
