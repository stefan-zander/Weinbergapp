//
//  OperationsTableViewController.swift
//  Weinbergapp
//
//  Created by Benutzer on 28.06.18.
//  Copyright © 2018 TH Bingen. All rights reserved.
//

import UIKit

class OperationsTableViewController: UITableViewController {
    
    let operations = [
        Operation(name: "", image: UIImage(named: "add")!, viewName: ""),
        Operation(name: "Arbeitsgänge", image: UIImage(named: "add")!, viewName: ""),
        Operation(name: "Entlauben", image: UIImage(named: "Defoliate")!, viewName: "WorkProcesses"),
        Operation(name: "Traubenlese", image: UIImage(named: "Vintage")!, viewName: "Vintage"),
        Operation(name: "Duengung", image: UIImage(named: "Fertilization")!, viewName: ""),
        Operation(name: "Pflanzenschutz", image: UIImage(named: "PlantProtection")!, viewName: ""),
        Operation(name: "", image: UIImage(named: "add")!, viewName: ""),
        Operation(name: "Aufwenfungen", image: UIImage(named: "add")!, viewName: ""),
        Operation(name: "Elektrische Aufwendung", image: UIImage(named: "add")!, viewName: ""),
        Operation(name: "Thermische Aufwendung", image: UIImage(named: "add")!, viewName: ""),
        Operation(name: "Stoffströme", image: UIImage(named: "add")!, viewName: "")
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return operations.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OperationCell", for: indexPath)
        
        if let operationCell = cell as? OperationTableViewCell {
            operationCell.initCell(operation: operations[indexPath.row])
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let view = storyBoard.instantiateViewController(withIdentifier: operations[indexPath.row].viewName)
        
        self.present(view, animated: true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
