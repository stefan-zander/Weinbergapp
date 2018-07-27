//
//  FertilizationViewController.swift
//  Weinbergapp
//
//  Created by VM on 14.07.18.
//  Copyright © 2018 TH Bingen. All rights reserved.
//

import UIKit

class FertilizationViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!

    var fertilizations: [Fertilization] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
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

            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd.MM.yyyy"
            dateFormatter.locale = Locale.init(identifier: "de_DE")

            cell.setField(field: "Feld: \(fertilization.field)")
            cell.setDate(date: "Datum: \(dateFormatter.string(from: fertilization.date))")
            cell.setUser(user: "Benutzer: \(fertilization.user)")
        }

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)

        if let addFertilization = storyboard.instantiateViewController(withIdentifier: "AddFertilization")
            as? AddFertilizationViewController {
            addFertilization.source = self
            addFertilization.editIndex = indexPath.row

            self.present(addFertilization, animated: true)
        }
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCellEditingStyle,
                   forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            fertilizations.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    @IBAction func add(_ sender: UIBarButtonItem) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)

        if let addFertilization = storyboard.instantiateViewController(withIdentifier: "AddFertilization")
            as? AddFertilizationViewController {
            addFertilization.source = self

            self.present(addFertilization, animated: true)
        }
    }

    @IBAction func back(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
}
