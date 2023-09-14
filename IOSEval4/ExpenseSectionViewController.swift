//
//  ExpenseSectionViewController.swift
//  IOSEval4
//
//  Created by Raphael Fassotte on 14/09/2023.
//


import CoreData
import UIKit

class ExpenseSectionViewController: UIViewController {
    @IBOutlet var tableView: UITableView!

    private var resultsController: NSFetchedResultsController<ExpenseSection>!

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self

        let request = ExpenseSection.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "myCustomName", ascending: true)]

        resultsController = NSFetchedResultsController(
            fetchRequest: request,
            managedObjectContext: DataManager.shared.context,
            sectionNameKeyPath: nil,
            cacheName: nil)
        resultsController.delegate = self

        do {
            try resultsController.performFetch()
        } catch {
            print("Error fetching initial data", error)
        }
    }

    @IBAction func addNewExpenseSection() {
        let alert = UIAlertController(title: "New Expense Section", message: "Enter the name of the new Expense Section", preferredStyle: .alert)

        alert.addTextField()
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Add", style: .default, handler: { _ in
            guard let fieldText = alert.textFields?.first?.text,
                  !fieldText.isEmpty
            else { return }

            DataManager.shared.addExpenseSection(name: fieldText)
        }))

        present(alert, animated: true)
    }
}

extension ExpenseSectionViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        resultsController.fetchedObjects?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let expenseSection = resultsController.object(at: indexPath)

        let cell = UITableViewCell()
        cell.textLabel?.text = expenseSection.myCustomName

        return cell
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let expenseSection = resultsController.object(at: indexPath)
            DataManager.shared.deleteExpenseSections(expenseSection)
        }
    }
}

extension ExpenseSectionViewController: NSFetchedResultsControllerDelegate {
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }

    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }

    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            tableView.insertRows(at: [newIndexPath!], with: .automatic)
        case .delete:
            tableView.deleteRows(at: [indexPath!], with: .automatic)
        case .move:
            tableView.deleteRows(at: [indexPath!], with: .automatic)
            tableView.insertRows(at: [newIndexPath!], with: .automatic)
        case .update:
            tableView.reloadRows(at: [indexPath!], with: .automatic)
        default:
            break
        }
    }
}

