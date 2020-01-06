//
//  DatabaseHelper.swift
//  fitness-app
//
//  Created by Hackintoshi9 on 2020-01-05.
//  Copyright © 2020 sam0sab0y. All rights reserved.
//

import UIKit
import CoreData

class DatabaseHelper {
    static let sharedInstance = DatabaseHelper()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func saveActivity(activity: Activities) {
        let entity = NSEntityDescription.entity(forEntityName: "Activity", in: context)
        let newActivity = NSManagedObject(entity: entity!, insertInto: context)
        
        newActivity.setValue(activity.title, forKey: "title")
        newActivity.setValue(activity.sets, forKey: "sets")
        newActivity.setValue(activity.reps, forKey: "reps")
        newActivity.setValue(activity.duration, forKey: "duration")
        
        do {
            try context.save()
        } catch {
            print("Failed saving")
        }
    }
    
    func getActivities() -> [Activities] {
        var activities = [Activities]()
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Activity")
        request.returnsDistinctResults = false
        
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                activities.append(Activities(title: data.value(forKey: "title") as! String, reps: data.value(forKey: "reps") as! Int, sets: data.value(forKey: "sets") as! Int, duration: data.value(forKey: "duration") as! Int, color: .common))
            }
        } catch {
            print("Error fetching")
        }
        
        return activities
    }
    
    func deleteActivity(activity: Activities) {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Activity")
        if let result = try? context.fetch(request) {
            for object in result {
                context.delete(object as! NSManagedObject)
                do {
                    try context.save()
                } catch {
                    print("Could not save")
                }
            }
        }
    }
}
