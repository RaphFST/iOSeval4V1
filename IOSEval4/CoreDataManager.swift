//
//  CoreDataManager.swift
//  IOSEval4
//
//  Created by Raphael Fassotte on 14/09/2023.
//

import CoreData
import Foundation

class DataManager {
    static let shared = DataManager()

    // MARK: - CoreData

    let context: NSManagedObjectContext

    init() {
        let container = NSPersistentContainer(name: "Transactions")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.

                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })

        context = container.viewContext
    }

    private func saveContext() {
        guard context.hasChanges else { return }
        
        do {
            try context.save()
        } catch {
            print("Error saving context", error)
        }
    }

    // MARK: - Sections

    func addExpenseSection(name: String) {
        let sections = ExpenseSection(context: context)
        sections.myCustomName = name

        saveContext()
    }

    func deleteExpenseSections(_ expenseSections: ExpenseSection) {
        context.delete(expenseSections)

        saveContext()
    }

    // MARK: - Expense

    func addExpense(myCustomDate: String, myCustomName: String, myCustomValue: Int, sections: ExpenseSection) {
        let expense = Expense(context: context)
        expense.myCustomDate = myCustomDate
        expense.myCustomName = myCustomName
        expense.myCustomValue = Float(myCustomValue)
        expense.expenserelationship = sections

        saveContext()
    }

    func deleteExpense(_ expense: Expense) {
        context.delete(expense)

        saveContext()
    }
}
