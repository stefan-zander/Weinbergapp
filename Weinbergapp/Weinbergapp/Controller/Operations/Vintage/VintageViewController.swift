//
//  VintageViewController.swift
//  Weinbergapp
//
//  Created by Stefan Zander on 14.07.18.
//  Copyright © 2018 TH Bingen. All rights reserved.
//

import UIKit

class VintageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!

    var vintages: RealmPersistentCollection<Vintage>!

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vintages.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "VintageViewCell", for: indexPath)

        if let cell = cell as? VintageTableViewCell {
            let vintage = vintages[indexPath.row]

            cell.setField(field: "Feld: \(vintage.field)")
            cell.setDate(date: "Datum: \(GermanDateFormatter.shared.string(from: vintage.date))")
            cell.setUser(user: "Benutzer: \(vintage.user)")
        }

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)

        if let editVintage = storyboard.instantiateViewController(withIdentifier: "AddVintage")
            as? AddVintageViewController {
            let editingElement = vintages[indexPath.row]

            editVintage.onLoad = {
                editVintage.applyChanges(from: editingElement)
            }

            editVintage.onSave = {
                do {
                    try self.vintages.update {
                        editVintage.applyChanges(to: editingElement)
                    }

                    self.tableView.reloadData()
                    return true
                } catch let error as NSError {
                    OperationDialogs.presentSaveFailed(error: error, controller: editVintage)
                    return false
                }
            }

            self.present(editVintage, animated: true)
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
                try vintages.delete(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            } catch let error as NSError {
                OperationDialogs.presentDeletionFailed(error: error, controller: self)
            }
        }
    }

    @IBAction func add(_ sender: UIBarButtonItem) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)

        if let addVintage = storyboard.instantiateViewController(withIdentifier: "AddVintage")
            as? AddVintageViewController {
            addVintage.onSave = {
                do {
                    let vintage = Vintage()
                    addVintage.applyChanges(to: vintage)
                    try self.vintages.add(vintage)

                    self.tableView.reloadData()
                    return true
                } catch let error as NSError {
                    OperationDialogs.presentSaveFailed(error: error, controller: addVintage)
                    return false
                }
            }

            self.present(addVintage, animated: true)
        }
    }

    @IBAction func back(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
}
