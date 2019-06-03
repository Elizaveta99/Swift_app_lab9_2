//
//  Record+CoreDataProperties.swift
//  application_2
//
//  Created by Lizaveta Rudzko on 3/12/1398 AP.
//  Copyright © 1398 Lizaveta Rudzko. All rights reserved.
//
//

import Foundation
import CoreData


extension Record {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Record> {
        return NSFetchRequest<Record>(entityName: "Record")
    }

    @NSManaged public var title: String?
    @NSManaged public var info: String?

}
