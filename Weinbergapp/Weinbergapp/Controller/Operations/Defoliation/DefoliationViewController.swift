//
//  DefoliationViewController.swift
//  Weinbergapp
//
//  Created by Stefan Zander on 14.07.18.
//  Copyright © 2018 TH Bingen. All rights reserved.
//

import UIKit

class DefoliationViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!

    var defoliations: RealmPersistentCollection<Defoliation>!
    var fields: FieldCollection!

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return defoliations.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(
            withIdentifier: "DefoliationViewCell",
            for: indexPath)

        if let cell = cell as? DefoliationTableViewCell {
            let defoliation = defoliations[indexPath.row]

            cell.setField(field: "Feld: \(defoliation.field!.name)")
            cell.setDate(date: "Datum: \(GermanDateFormatter.shared.string(from: defoliation.date))")
            cell.setUser(user: "Benutzer: \(defoliation.user)")
        }

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)

        if let editDefoliation = storyboard.instantiateViewController(withIdentifier: "AddDefoliation")
            as? AddDefoliationViewController {
            let editingElement = defoliations[indexPath.row]

            editDefoliation.onLoad = {
                editDefoliation.applyChanges(from: editingElement)
            }

            editDefoliation.onSave = {
                do {
                    try self.defoliations.update {
                        editDefoliation.applyChanges(to: editingElement)
                    }

                    self.tableView.reloadData()
                    return true
                } catch let error as NSError {
                    OperationDialogs.presentSaveError(error, controller: editDefoliation)
                    return false
                }
            }

            editDefoliation.fields = fields

            self.present(editDefoliation, animated: true)
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
                try defoliations.delete(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            } catch let error as NSError {
                OperationDialogs.presentDeletionError(error, controller: self)
            }
        }
    }

    @IBAction func add(_ sender: UIBarButtonItem) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)

        if let addDefoliation = storyboard.instantiateViewController(withIdentifier: "AddDefoliation")
            as? AddDefoliationViewController {
            addDefoliation.onSave = {
                do {
                    let defoliation = Defoliation()
                    addDefoliation.applyChanges(to: defoliation)
                    try self.defoliations.add(defoliation)

                    self.tableView.reloadData()
                    return true
                } catch let error as NSError {
                    OperationDialogs.presentAddError(error, controller: addDefoliation)
                    return false
                }
            }

            addDefoliation.fields = fields

            self.present(addDefoliation, animated: true)
        }
    }

    @IBAction func back(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
}
