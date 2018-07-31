//
//  FertilizationViewController.swift
//  Weinbergapp
//
//  Created by Stefan Zander on 14.07.18.
//  Copyright © 2018 TH Bingen. All rights reserved.
//

import UIKit

class FertilizationViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!

    let fertilizations = RealmPersistentCollection<Fertilization>()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self

        do {
            try fertilizations.reload()
        } catch let error as NSError {
            OperationDialogs.presentLoadFailed(error: error, controller: self)
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fertilizations.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(
            withIdentifier: "FertilizationViewCell",
            for: indexPath)

        if let cell = cell as? FertilizationTableViewCell {
            let fertilization = fertilizations[indexPath.row]

            cell.setField(field: "Feld: \(fertilization.field)")
            cell.setDate(date: "Datum: \(GermanDateFormatter.shared.string(from: fertilization.date))")
            cell.setUser(user: "Benutzer: \(fertilization.user)")
        }

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)

        if let editFertilization = storyboard.instantiateViewController(withIdentifier: "AddFertilization")
            as? AddFertilizationViewController {
            let editingElement = fertilizations[indexPath.row]

            editFertilization.onLoad = {
                editFertilization.applyChanges(from: editingElement)
            }

            editFertilization.onSave = {
                do {
                    try self.fertilizations.update {
                        editFertilization.applyChanges(to: editingElement)
                    }

                    self.tableView.reloadData()
                    return true
                } catch let error as NSError {
                    OperationDialogs.presentSaveFailed(error: error, controller: editFertilization)
                    return false
                }
            }

            self.present(editFertilization, animated: true)
        }
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCellEditingStyle,
                   forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            do {
                try fertilizations.delete(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            } catch let error as NSError {
                OperationDialogs.presentDeletionFailed(error: error, controller: self)
            }
        }
    }

    @IBAction func add(_ sender: UIBarButtonItem) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)

        if let addFertilization = storyboard.instantiateViewController(withIdentifier: "AddFertilization")
            as? AddFertilizationViewController {
            addFertilization.onSave = {
                do {
                    let fertilization = Fertilization()
                    addFertilization.applyChanges(to: fertilization)
                    try self.fertilizations.add(fertilization)

                    self.tableView.reloadData()
                    return true
                } catch let error as NSError {
                    OperationDialogs.presentSaveFailed(error: error, controller: addFertilization)
                    return false
                }
            }

            self.present(addFertilization, animated: true)
        }
    }

    @IBAction func back(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
}
