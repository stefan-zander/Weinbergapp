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

    var plantProtections: [PlantProtection] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return plantProtections.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(
            withIdentifier: "PlantProtectionViewCell",
            for: indexPath)

        if let cell = cell as? PlantProtectionTableViewCell {
            let plantProtection = plantProtections[indexPath.row]

            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd.MM.yyyy"
            dateFormatter.locale = Locale.init(identifier: "de_DE")

            cell.setField(field: "Feld: \(plantProtection.field)")
            cell.setDate(date: "Datum: \(dateFormatter.string(from: plantProtection.date))")
            cell.setUser(user: "Benutzer: \(plantProtection.user)")
        }

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)

        if let addPlantProtection = storyboard.instantiateViewController(withIdentifier: "AddPlantProtection")
            as? AddPlantProtectionViewController {
            addPlantProtection.source = self
            addPlantProtection.editIndex = indexPath.row

            self.present(addPlantProtection, animated: true)
        }
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCellEditingStyle,
                   forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            plantProtections.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    @IBAction func add(_ sender: UIBarButtonItem) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)

        if let addPlantProtection = storyboard.instantiateViewController(withIdentifier: "AddPlantProtection")
            as? AddPlantProtectionViewController {
            addPlantProtection.source = self

            self.present(addPlantProtection, animated: true)
        }
    }

    @IBAction func back(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
}
