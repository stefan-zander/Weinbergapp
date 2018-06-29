//
//  VintageTableViewController.swift
//  Weinbergapp
//
//  Created by Benutzer on 29.06.18.
//  Copyright © 2018 TH Bingen. All rights reserved.
//

import UIKit

class VintageTableViewController: UITableViewController {
    
    var vintages: [Vintage] = []

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return vintages.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        cell.textLabel?.text = vintages[indexPath.row].field

        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            vintages.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    @IBAction func add(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        
        if let addVintage = storyBoard.instantiateViewController(withIdentifier: "AddVintage") as? AddVintageViewController {
            addVintage.source = self
            self.present(addVintage, animated: false, completion: nil)
        }
    }
}
