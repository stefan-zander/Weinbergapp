//
//  OperationsTableViewController.swift
//  Weinbergapp
//
//  Created by Stefan Zander on 28.06.18.
//  Copyright © 2018 TH Bingen. All rights reserved.
//

import UIKit
import RealmSwift

class OperationsTableViewController: UITableViewController {
    
    let operations = [
        Operation(name: "Düngung",
                  image: UIImage(named: "FertilizationLogo")!,
                  storyboardIdentifier: "Fertilization"),

        Operation(name: "Entlauben",
                  image: UIImage(named: "DefoliationLogo")!,
                  storyboardIdentifier: "Defoliation"),

        Operation(name: "Pflanzenschutz",
                  image: UIImage(named: "PlantProtectionLogo")!,
                  storyboardIdentifier: "PlantProtection"),

        Operation(name: "Traubenlese",
                  image: UIImage(named: "VintageLogo")!,
                  storyboardIdentifier: "Vintage")
    ]
    
    var realm: Realm!

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
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let view = storyboard.instantiateViewController(
            withIdentifier: operations[indexPath.row].storyboardIdentifier)
        
        do {
            switch view {
            case let fertilization as FertilizationViewController:
                fertilization.fertilizations = try RealmPersistentCollection(dataSource: RealmDataSource(realm: realm))
            case let defoliation as DefoliationViewController:
                defoliation.defoliations = try RealmPersistentCollection(dataSource: RealmDataSource(realm: realm))
            case let plantProtection as PlantProtectionViewController:
                plantProtection.plantProtections = try RealmPersistentCollection(dataSource: RealmDataSource(realm: realm))
            case let vintage as VintageViewController:
                vintage.vintages = try RealmPersistentCollection(dataSource: RealmDataSource(realm: realm))
            default:
                break
            }
            
            self.present(view, animated: true)
        } catch let error as NSError {
            // TODO HANDLE ME
        }
    }
}
