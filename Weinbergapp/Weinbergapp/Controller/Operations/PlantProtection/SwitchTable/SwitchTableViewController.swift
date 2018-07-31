//
//  PlantProtectionSwitchListViewController.swift
//  Weinbergapp
//
//  Created by Stefan Zander on 14.07.18.
//  Copyright © 2018 TH Bingen. All rights reserved.
//

import UIKit

class SwitchTableViewController: UITableViewController {

    public var onSave: (() -> Void)?

    var items: [(String, Bool)] = []

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        if let switchCell = cell as? SwitchTableViewCell {
            switchCell.setText(text: items[indexPath.row].0)
            switchCell.setChecked(checked: items[indexPath.row].1)
            switchCell.source = self
            switchCell.index = indexPath.row
        }

        return cell
    }

    func getItemLabels() -> [String] {
        return items.map { $0.0 }
    }

    func getItemStates() -> [Bool] {
        return items.map { $0.1 }
    }

    func getItemLabel(index: Int) -> String {
        return items[index].0
    }

    func getItemState(index: Int) -> Bool {
        return items[index].1
    }

    func getItems() -> [(String, Bool)] {
        return items
    }

    func setItemLabels(labels: [String]) {
        for index in 0..<items.count {
            items[index].0 = labels[index]
        }
    }

    func setItemStates(states: [Bool]) {
        for index in 0..<items.count {
            items[index].1 = states[index]
        }
    }

    func setItemLabel(index: Int, label: String) {
        items[index].0 = label
    }

    func setItemState(index: Int, state: Bool) {
        items[index].1 = state
    }

    func setItems(items: [(String, Bool)]) {
        self.items = items
    }

    @IBAction func save(_ sender: UIBarButtonItem) {
        if let onSave = onSave {
            onSave()
        }
        
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func cancel(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
}
