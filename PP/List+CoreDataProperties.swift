//
//  List+CoreDataProperties.swift
//  
//
//  Created by Максим Храбрый on 11.03.2021.
//
//

import Foundation
import CoreData


extension List {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<List> {
        return NSFetchRequest<List>(entityName: "List")
    }

    @NSManaged public var name: String
    @NSManaged public var password: String

}
