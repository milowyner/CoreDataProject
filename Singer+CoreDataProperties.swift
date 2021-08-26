//
//  Singer+CoreDataProperties.swift
//  CoreDataProject
//
//  Created by Milo Wyner on 8/26/21.
//
//

import Foundation
import CoreData


extension Singer {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Singer> {
        return NSFetchRequest<Singer>(entityName: "Singer")
    }

    @NSManaged public var firstName: String?
    @NSManaged public var lastName: String?
    
    @objc var wrappedFirstName: String {
        firstName ?? "Unknown"
    }

    @objc var wrappedLastName: String {
        lastName ?? "Unknown"
    }
}

extension Singer : Identifiable {

}
