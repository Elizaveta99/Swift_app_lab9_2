//
//  AppDelegate.swift
//  application_2
//
//  Created by Lizaveta Rudzko on 3/12/1398 AP.
//  Copyright © 1398 Lizaveta Rudzko. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate
{

    var window: UIWindow?


    lazy var applicationDocumentsDirectory: NSURL = {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return urls[urls.count-1] as NSURL
    }()
    
    lazy var managedObjectModel: NSManagedObjectModel = {
        let modelURL = NSManagedObjectModel.mergedModel(from: nil)
        return modelURL!
    }()
    
    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.appendingPathComponent("lab9_database.sqlite")
        do
        {
            try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url, options: nil)
        }
        catch {
            NSLog("Unresolved error")
            abort()
        }
        return coordinator
    }()
    
    lazy var managedObjectContext: NSManagedObjectContext = {
        let coordinator = self.persistentStoreCoordinator
        var managedContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedContext.persistentStoreCoordinator = coordinator
        return managedContext
    }()
    
    func saveContext () {
        if managedObjectContext.hasChanges {
            do
            {
                try managedObjectContext.save()
            }
            catch
            {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        if !UserDefaults.standard.bool(forKey: "HasLaunchedOnce")
        {
            UserDefaults.standard.set(true, forKey: "HasLaunchedOnce")
            UserDefaults.standard.synchronize()
            
            let entity = NSEntityDescription.entity(forEntityName: "Record", in: self.managedObjectContext)
            
            let record1 = Record(entity: entity!, insertInto: self.managedObjectContext)
            record1.setValue("Ленинский", forKey: "name")
            record1.setValue("Общежитие № 6", forKey: "info")
            
            let record2 = Record(entity: entity!, insertInto: self.managedObjectContext)
            record2.setValue("Ленинский", forKey: "name")
            record2.setValue("Общежитие № 2", forKey: "info")
            
            let record3 = Record(entity: entity!, insertInto: self.managedObjectContext)
            record3.setValue("Ленинский", forKey: "name")
            record3.setValue("Общежитие № 7", forKey: "info")

            let record4 = Record(entity: entity!, insertInto: self.managedObjectContext)
            record4.setValue("Ленинский", forKey: "name")
            record4.setValue("ФПМИ", forKey: "info")
            
            let record5 = Record(entity: entity!, insertInto: self.managedObjectContext)
            record5.setValue("Ленинский", forKey: "name")
            record5.setValue("Мех-мат", forKey: "info")
            
            let record6 = Record(entity: entity!, insertInto: self.managedObjectContext)
            record6.setValue("Октябрьский", forKey: "name")
            record6.setValue("Общежитие № 1", forKey: "info")
            
            let record7 = Record(entity: entity!, insertInto: self.managedObjectContext)
            record7.setValue("Октябрьский", forKey: "name")
            record7.setValue("ФМО", forKey: "info")
            
            let record8 = Record(entity: entity!, insertInto: self.managedObjectContext)
            record8.setValue("Московский", forKey: "name")
            record8.setValue("Филологический", forKey: "info")
            
            let record9 = Record(entity: entity!, insertInto: self.managedObjectContext)
            record9.setValue("Московский", forKey: "name")
            record9.setValue("ФФСН", forKey: "info")
            
            let record10 = Record(entity: entity!, insertInto: self.managedObjectContext)
            record10.setValue("Центральный", forKey: "name")
            record10.setValue("общежитие № 8", forKey: "info")
            
            
            let entity_d = NSEntityDescription.entity(forEntityName: "District", in: self.managedObjectContext)
            
            let record1_d = District(entity: entity_d!, insertInto: self.managedObjectContext)
            record1_d.setValue("Ленинский", forKey: "name")
            record1_d.setValue(53.867378, forKey: "latitude")
            record1_d.setValue(27.597416, forKey: "longitude")
            
            let record2_d = District(entity: entity_d!, insertInto: self.managedObjectContext)
            record2_d.setValue("Октябрьский", forKey: "name")
            record2_d.setValue(53.863225, forKey: "latitude")
            record2_d.setValue(27.537723, forKey: "longitude")
            
            let record3_d = District(entity: entity_d!, insertInto: self.managedObjectContext)
            record3_d.setValue("Московский", forKey: "name")
            record3_d.setValue(53.868128, forKey: "latitude")
            record3_d.setValue(27.477901, forKey: "longitude")
            
            let record4_d = District(entity: entity_d!, insertInto: self.managedObjectContext)
            record4_d.setValue("Центральный", forKey: "name")
            record4_d.setValue(53.934000, forKey: "latitude")
            record4_d.setValue(27.530893, forKey: "longitude")
            
            
            self.saveContext()
        }
        return true
    }
    
    func getInfo() -> [Record]
    {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Record")
        var info = [NSManagedObject]()
        do
        {
            info = try managedObjectContext.fetch(fetchRequest)
        }
        catch let error as NSError
        {
            print("Could not fetch. \(error)")
        }
        return info as! [Record]
    }

    func getDistrict() -> [District]
    {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "District")
        var distr = [NSManagedObject]()
        do
        {
            distr = try managedObjectContext.fetch(fetchRequest)
        }
        catch let error as NSError
        {
            print("Could not fetch. \(error)")
        }
        return distr as! [District]
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
         self.saveContext()
    }


}

