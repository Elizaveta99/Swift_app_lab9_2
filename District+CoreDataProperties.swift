//
//  District+CoreDataProperties.swift
//  application_2
//
//  Created by Lizaveta Rudzko on 3/12/1398 AP.
//  Copyright © 1398 Lizaveta Rudzko. All rights reserved.
//
//

import Foundation
import CoreData


extension District {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<District> {
        return NSFetchRequest<District>(entityName: "District")
    }

    @NSManaged public var title: String?
    @NSManaged public var longitude: Double
    @NSManaged public var latitude: Double

}
