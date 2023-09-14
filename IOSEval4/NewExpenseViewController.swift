//
//  NewExpenseViewController.swift
//  IOSEval4
//
//  Created by Raphael Fassotte on 14/09/2023.
//
import UIKit

class NewExpenseViewController: UIViewController {
    @IBOutlet var expenseSectionNameField: UITextField!
    @IBOutlet var expenseSectionDateField: UITextField!
    @IBOutlet var expenseSectionPriceField: UITextField!
    @IBOutlet var expenseSectionPicker: UIPickerView!
    
    private var expenseSections = [ExpenseSection]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        expenseSectionPicker.dataSource = self
        expenseSectionPicker.delegate = self
        
        let request = ExpenseSection.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "myCustomName", ascending: true)]
        
        do {
            expenseSections = try DataManager.shared.context.fetch(request)
        } catch {
            print("Unable to fetch section", error)
        }
    }
    
    @IBAction func cancel() {
        dismiss(animated: true)
    }
    
    @IBAction func saveExpense() {
        guard let myCustomName = expenseSectionNameField.text,
              let myCustomPriceText = expenseSectionPriceField.text,
              let myCustomDateText = expenseSectionDateField.text,
              let myCustomValue = Int(myCustomPriceText)  // Convertir la chaîne en entier
        else {
            return
        }
        
        let expenseSection = expenseSections[expenseSectionPicker.selectedRow(inComponent: 0)]
        
        dismiss(animated: true) {
            DataManager.shared.addExpense(myCustomDate: myCustomDateText, myCustomName: myCustomName, myCustomValue: myCustomValue, sections: expenseSection)
        }
    }
}

// Extensions pour conformer aux protocoles UIPickerViewDataSource et UIPickerViewDelegate
extension NewExpenseViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return expenseSections.count
    }
}

extension NewExpenseViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return expenseSections[row].myCustomName
    }
}
