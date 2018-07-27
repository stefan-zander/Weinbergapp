//
//  VintageViewController.swift
//  Weinbergapp
//
//  Created by VM on 14.07.18.
//  Copyright © 2018 TH Bingen. All rights reserved.
//

import UIKit

class VintageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    let dataSource = OperationDataSource<Vintage>()

    var vintages: [Vintage] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        do {
            try dataSource.query(elements: &vintages)
        } catch let error as NSError {
            OperationDialogs.presentLoadFailed(error: error, controller: self)
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vintages.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "VintageViewCell", for: indexPath)

        if let cell = cell as? VintageTableViewCell {
            let vintage = vintages[indexPath.row]

            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd.MM.yyyy"
            dateFormatter.locale = Locale.init(identifier: "de_DE")

            cell.setField(field: "Feld: \(vintage.field)")
            cell.setDate(date: "Datum: \(dateFormatter.string(from: vintage.date))")
            cell.setUser(user: "Benutzer: \(vintage.user)")
        }

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)

        if let addVintage = storyboard.instantiateViewController(withIdentifier: "AddVintage")
            as? AddVintageViewController {
            addVintage.source = self
            addVintage.editIndex = indexPath.row

            self.present(addVintage, animated: true)
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
                try dataSource.delete(vintages[indexPath.row])
                vintages.remove(at: indexPath.row)
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
            addVintage.source = self

            self.present(addVintage, animated: true)
        }
    }

    @IBAction func back(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
}
