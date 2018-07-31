//
//  PlantProtectionViewController.swift
//  Weinbergapp
//
//  Created by VM on 14.07.18.
//  Copyright © 2018 TH Bingen. All rights reserved.
//

import UIKit

class PlantProtectionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    let collection = RealmPersistentCollection<PlantProtection>()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        do {
            try collection.reload()
        } catch let error as NSError {
            OperationDialogs.presentLoadFailed(error: error, controller: self)
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return collection.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(
            withIdentifier: "PlantProtectionViewCell",
            for: indexPath)

        if let cell = cell as? PlantProtectionTableViewCell {
            let plantProtection = collection[indexPath.row]

            cell.setField(field: "Feld: \(plantProtection.field)")
            cell.setDate(date: "Datum: \(GermanDateFormatter.shared.string(from: plantProtection.date))")
            cell.setUser(user: "Benutzer: \(plantProtection.user)")
        }

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)

        if let editPlantProtection = storyboard.instantiateViewController(withIdentifier: "AddPlantProtection")
            as? AddPlantProtectionViewController {
            let editingElement = collection[indexPath.row]
            
            editPlantProtection.onLoad = {
                editPlantProtection.applyChanges(from: editingElement)
            }
            
            editPlantProtection.onSave = {
                do {
                    try self.collection.update {
                        editPlantProtection.applyChanges(to: editingElement)
                    }
                    
                    self.tableView.reloadData()
                    return true
                } catch let error as NSError {
                    OperationDialogs.presentSaveFailed(error: error, controller: editPlantProtection)
                    return false
                }
            }
            
            self.present(editPlantProtection, animated: true)
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
                try collection.delete(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            } catch let error as NSError {
                OperationDialogs.presentDeletionFailed(error: error, controller: self)
            }
        }
    }

    @IBAction func add(_ sender: UIBarButtonItem) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)

        if let addPlantProtection = storyboard.instantiateViewController(withIdentifier: "AddPlantProtection")
            as? AddPlantProtectionViewController {
            addPlantProtection.onSave = {
                do {
                    let plantProtection = PlantProtection()
                    addPlantProtection.applyChanges(to: plantProtection)
                    try self.collection.add(plantProtection)
                    
                    self.tableView.reloadData()
                    return true
                } catch let error as NSError {
                    OperationDialogs.presentSaveFailed(error: error, controller: addPlantProtection)
                    return false
                }
            }
            
            self.present(addPlantProtection, animated: true)
        }
    }

    @IBAction func back(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
}
