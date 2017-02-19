//
//  Location+CoreDataProperties.swift
//  MyLocations
//
//  Created by Pork Chop Express.
//  Copyright © 2016 Pork Chop Express. All rights reserved.
//
//  Delete this file and regenerate it using "Create NSManagedObject Subclass…"
//  to keep your implementation up to date with your model.
//

import Foundation
import CoreData
import CoreLocation

extension Location {

    @NSManaged var category: String
    @NSManaged var date: Date
    @NSManaged var latitude: Double
    @NSManaged var locationDescription: String
    @NSManaged var longitude: Double
    @NSManaged var placemark: CLPlacemark?
    @NSManaged var photoID : NSNumber?

}
