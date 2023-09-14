//
//  ExpenseSection+CoreDataProperties.swift
//  IOSEval4
//
//  Created by Raphael Fassotte on 14/09/2023.
//
//

import Foundation
import CoreData


extension ExpenseSection {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ExpenseSection> {
        return NSFetchRequest<ExpenseSection>(entityName: "ExpenseSection")
    }

    @NSManaged public var myCustomName: String
    @NSManaged public var expensesectionrelationship: Set<ExpenseSection>

}

// MARK: Generated accessors for expensesectionrelationship
extension ExpenseSection {

    @objc(addExpensesectionrelationshipObject:)
    @NSManaged public func addToExpensesectionrelationship(_ value: Expense)

    @objc(removeExpensesectionrelationshipObject:)
    @NSManaged public func removeFromExpensesectionrelationship(_ value: Expense)

    @objc(addExpensesectionrelationship:)
    @NSManaged public func addToExpensesectionrelationship(_ values: NSSet)

    @objc(removeExpensesectionrelationship:)
    @NSManaged public func removeFromExpensesectionrelationship(_ values: NSSet)

}

extension ExpenseSection : Identifiable {

}
