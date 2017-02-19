//
//  AppDelegate.swift
//  MyLocations
//
//  Created by Pork Chop Express.
//  Copyright © 2016 Pork Chop Express. All rights reserved.//

import UIKit
import CoreData
import Parse

let MyManagedObjectContextSaveDidFailNotification = "MyManagedObjectContextSaveDidFailNotification"

func fatalCoreDataError(_ error: Error) {
    print("*** Fatal error: \(error)")
    NotificationCenter.default.post(name: Notification.Name(rawValue: MyManagedObjectContextSaveDidFailNotification), object: nil)
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    lazy var managedObjectContext: NSManagedObjectContext = {
        
        // 1 The Core Data model is stored in your application bundle in a folder name "DataModel.momd." Here you create a NSURL object pointing at this folder in the app bundle. Paths to files and folders are often represented by URLs in the iOS frameworks
        guard let modelURL = Bundle.main.url(forResource: "DataModel", withExtension: "momd") else {
            fatalError("Could not find data model in app bundle")
        }
        
        // 2 Create a NSManagedObjectModel from that URL. This object represents the data model during runtime. You can ask it what sort of entities it has, what attributes these entities have, etc.
        guard let model = NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError("Error initializing model from: \(modelURL)")
        }
        
        // 3 The app's data is stored in a SQLite database inside the app's Documents folder. Here you create a NSURL object pointing at the DataStore.sqlite file
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = urls[0]
        let storeURL = try! documentsDirectory.appendingPathComponent("DataStore.sqlite")
        print(storeURL)
        
        do {
            // 4 Create a NSPersistentStoreCoordinator object which is in charge of the SQLite database
            let coordinator = NSPersistentStoreCoordinator(managedObjectModel: model)
            
            // 5 Add the SQLite database to the store coordinator
            //try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: storeURL, options: nil)
            try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: storeURL, options: nil)
            
            // 6 Create the NSManagedObjectContext object and return it
            let context = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
            context.persistentStoreCoordinator = coordinator
            return context
            
            // 7 If something went wrong with the above, print an error message and terminate the app.
        } catch {
            fatalError("Error adding persistent store at \(storeURL): \(error)")
        }
    }()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject : AnyObject]?) -> Bool {
        
        //   let configuration = ParseClientConfiguration {
        //        $0.applicationId = "my-locations-pork-chop-express"
        //        $0.server = "https://github.com/ParsePlatform/parse-server-example"
        //    }
        //    Parse.initialize(with: configuration)
        //
        //    let testObject = PFObject(className: "TestObject")
        //    testObject["foo"] = "bar"
        //    testObject.saveInBackground { (success: Bool, error: NSError?) -> Void in
        //        print("Object has been saved.")
        //    }
        customizeAppearance()
        
        let tabBarController = window!.rootViewController as! UITabBarController
        
        if let tabBarViewControllers = tabBarController.viewControllers {
            let currentLocationViewController = tabBarViewControllers[0] as! CurrentLocationViewController
            currentLocationViewController.managedObjectContext = managedObjectContext
            let navigationController = tabBarViewControllers[1] as! UINavigationController
            let locationsViewController = navigationController.viewControllers[0] as! LocationsViewController
            locationsViewController.managedObjectContext = managedObjectContext
            
            let mapViewController = tabBarViewControllers[2] as! MapViewController
            mapViewController.managedObjectContext = managedObjectContext
            
            // Workaround for the Core Data bug.
            let _ = locationsViewController.view
        }
        
        listenForFatalCoreDataNotifications()
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func listenForFatalCoreDataNotifications() {
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: MyManagedObjectContextSaveDidFailNotification), object: nil, queue: OperationQueue.main, using: { notification in
            
            let alert = UIAlertController(title: "Internal Error",
                                          message: "There was a fatal error in the app and it cannot continue.\n\n"
                                            + "Press OK to terminate the app. Sorry for the inconvenience.",
                                          preferredStyle: .alert)
            
            let action = UIAlertAction(title: "OK", style: .default) { _ in
                let exception = NSException(name: NSExceptionName.internalInconsistencyException, reason: "Fatal Core Data error", userInfo: nil)
                exception.raise()
            }
            
            alert.addAction(action)
            
            self.viewControllerForShowingAlert().present(
                alert, animated: true, completion: nil)
        })
    }
    
    func viewControllerForShowingAlert() -> UIViewController {
        let rootViewController = self.window!.rootViewController!
        if let presentedViewController = rootViewController.presentedViewController {
            return presentedViewController
        } else {
            return rootViewController
        }
    }
    
    func customizeAppearance() {
        UINavigationBar.appearance().barTintColor = UIColor.black
        UINavigationBar.appearance().titleTextAttributes = [ NSForegroundColorAttributeName: UIColor.white]
        UITabBar.appearance().barTintColor = UIColor.black
        let tintColor = UIColor(red: 255/255.0, green: 238/255.0, blue: 136/255.0, alpha: 1.0)
        UITabBar.appearance().tintColor = tintColor
    }
}
