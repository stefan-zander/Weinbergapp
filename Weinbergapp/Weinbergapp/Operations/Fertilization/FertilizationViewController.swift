//
//  FertilizationViewController.swift
//  Weinbergapp
//
//  Created by VM on 14.07.18.
//  Copyright © 2018 TH Bingen. All rights reserved.
//

import UIKit

class FertilizationViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var fertilizations: [Fertilization] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func add(_ sender: UIBarButtonItem) {
    }
    
    @IBAction func back(_ sender: UIBarButtonItem) {
    }
    
}
