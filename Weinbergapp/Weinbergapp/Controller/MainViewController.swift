//
//  MainViewController.swift
//  Weinbergapp
//
//  Created by Stefan Zander on 31.07.18.
//  Copyright © 2018 TH Bingen. All rights reserved.
//

import UIKit
import RealmSwift

class MainViewController: UITabBarController {

    var realm: Realm!

    override func viewDidLoad() {
        super.viewDidLoad()

        if let viewControllers = viewControllers {
            let fields = FieldCollection(realm: realm)

            if let map = viewControllers[0] as? MapViewController {
                map.fields = fields
            }

            if let operations = viewControllers[1] as? OperationsTableViewController {
                operations.realm = realm
                operations.fields = fields
            }
        }
    }
}
