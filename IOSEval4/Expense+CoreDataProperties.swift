//
//  Expense+CoreDataProperties.swift
//  IOSEval4
//
//  Created by Raphael Fassotte on 14/09/2023.
//
//

import Foundation
import CoreData


extension Expense {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Expense> {
        return NSFetchRequest<Expense>(entityName: "Expense")
    }

    @NSManaged public var myCustomDate: String
    @NSManaged public var myCustomName: String
    @NSManaged public var myCustomValue: Float
    @NSManaged public var expenserelationship: ExpenseSection?

}

extension Expense : Identifiable {

}
