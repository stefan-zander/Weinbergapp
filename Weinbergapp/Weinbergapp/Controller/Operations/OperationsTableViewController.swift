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
    
    private let operations = [
        OperationInfo(name: "Düngung",
                      image: UIImage(named: "FertilizationLogo")!,
                      identifier: "Fertilization"),
        
        OperationInfo(name: "Entlauben",
                      image: UIImage(named: "DefoliationLogo")!,
                      identifier: "Defoliation"),
        
        OperationInfo(name: "Pflanzenschutz",
                      image: UIImage(named: "PlantProtectionLogo")!,
                      identifier: "PlantProtection"),
        
        OperationInfo(name: "Traubenlese",
                      image: UIImage(named: "VintageLogo")!,
                      identifier: "Vintage")
    ]
    
    var realm: Realm!
    var fields: MapFieldCollection!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return operations.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OperationCell", for: indexPath)

        if let operationCell = cell as? OperationTableViewCell {
            let operationInfo = operations[indexPath.row]
            
            operationCell.set(name: operationInfo.name)
            operationCell.set(image: operationInfo.image)
        }

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard fields.count > 0 else {
            OperationDialogs.presentNoFields(controller: self)
            return
        }
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let view = storyboard.instantiateViewController(withIdentifier: operations[indexPath.row].identifier)
        
        switch view {
        case let fertilization as FertilizationViewController:
            fertilization.fertilizations = RealmPersistentCollection(realm: realm)
            fertilization.fields = fields
        case let defoliation as DefoliationViewController:
            defoliation.defoliations = RealmPersistentCollection(realm: realm)
            defoliation.fields = fields
        case let plantProtection as PlantProtectionViewController:
            plantProtection.plantProtections = RealmPersistentCollection(realm: realm)
            plantProtection.fields = fields
        case let vintage as VintageViewController:
            vintage.vintages = RealmPersistentCollection(realm: realm)
            vintage.fields = fields
        default:
            break
        }
        
        self.present(view, animated: true)
    }
    
    private struct OperationInfo {
        let name: String
        let image: UIImage
        let identifier: String
    }
}
