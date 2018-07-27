//
//  AddFertilizatinViewController.swift
//  Weinbergapp
//
//  Created by VM on 14.07.18.
//  Copyright © 2018 TH Bingen. All rights reserved.
//

import UIKit

class AddFertilizationViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var date: UIDatePicker!
    @IBOutlet weak var field: UITextField!
    @IBOutlet weak var user: UITextField!
    @IBOutlet weak var workingHours: UITextField!
    @IBOutlet weak var fertilizerCategory: UIPickerView!
    @IBOutlet weak var fertilizer: UIPickerView!
    @IBOutlet weak var appliedAmount: UITextField!

    var editingElement: Fertilization?
    var source: FertilizationViewController!

    override func viewDidLoad() {
        super.viewDidLoad()

        fertilizerCategory.delegate = self
        fertilizerCategory.dataSource = self
        fertilizer.delegate = self
        fertilizer.dataSource = self

        if let editingElement = editingElement {
            applyChanges(from: editingElement)
        }
    }
    
    func applyChanges(from: Fertilization) {
        date.date = from.date
        field.text = from.field
        user.text = from.user
        workingHours.text = String(from.workingHours)
        fertilizerCategory.selectRow(from.fertilizerCategoryRaw, inComponent: 0, animated: false)
        
        switch from.fertilizerCategoryRaw {
        case 0:
            fertilizer.selectRow(from.mineralFertilizerRaw, inComponent: 0, animated: false)
        case 1:
            fertilizer.selectRow(from.organicFertilizerRaw, inComponent: 0, animated: false)
        default:
            break
        }
        
        appliedAmount.text = String(from.appliedAmount)
    }
    
    func applyChanges(to: Fertilization) {
        to.date = date.date
        to.field = field.text ?? ""
        to.user = user.text ?? ""
        to.workingHours = Double(workingHours.text ?? "0") ?? 0.0
        to.fertilizerCategoryRaw = fertilizerCategory.selectedRow(inComponent: 0)
        
        switch to.fertilizerCategoryRaw {
        case 0:
            to.mineralFertilizerRaw = fertilizer.selectedRow(inComponent: 0)
        case 1:
            to.organicFertilizerRaw = fertilizer.selectedRow(inComponent: 0)
        default:
            break
        }
        
        to.appliedAmount = Double(appliedAmount.text ?? "0") ?? 0.0
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView {
        case fertilizerCategory:
            return 2
        case fertilizer:
            return 8
        default:
            return 0
        }
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == fertilizerCategory {
            fertilizer.reloadAllComponents()
        }
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView {
        case fertilizerCategory:
            return FertilizationLocalization.getFertilizerCategory(index: row)
        case fertilizer:
            switch fertilizerCategory.selectedRow(inComponent: 0) {
            case 0:
                return FertilizationLocalization.getMineralFertilizer(index: row)
            case 1:
                return FertilizationLocalization.getOrganicFertilizer(index: row)
            default:
                return nil
            }
        default:
            return nil
        }
    }
    
    @IBAction func save(_ sender: UIBarButtonItem) {
        guard OperationFieldVerification.verify(field: field, self) else { return }
        guard OperationFieldVerification.verify(user: user, self) else { return }
        guard OperationFieldVerification.verify(workingHours: workingHours, self) else { return }
        guard OperationFieldVerification.verify(appliedAmount: appliedAmount, self) else { return }
        
        do {
            if let editingElement = editingElement {
                try source.dataSource.update {
                    applyChanges(to: editingElement)
                }
            } else {
                let fertilization = Fertilization()
                applyChanges(to: fertilization)
                
                try source.dataSource.add(fertilization)
                source.fertilizations.append(fertilization)
            }
            
            source.tableView.reloadData()
            self.dismiss(animated: true, completion: nil)
        } catch let error as NSError {
            OperationDialogs.presentSaveFailed(error: error, controller: self)
        }
    }

    @IBAction func cancel(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
}
