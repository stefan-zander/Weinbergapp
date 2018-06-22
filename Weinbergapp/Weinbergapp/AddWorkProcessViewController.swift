//
//  AddWorkProcessViewController.swift
//  Weinbergapp
//
//  Created by Benutzer on 22.06.18.
//  Copyright © 2018 TH Bingen. All rights reserved.
//

import UIKit

class AddWorkProcessViewController: UIViewController {
    
    @IBOutlet weak var date: UIDatePicker!
    
    @IBOutlet weak var field: UITextField!
    
    @IBOutlet weak var user: UITextField!
    
    @IBOutlet weak var time: UITextField!
    
    @IBOutlet weak var addButton: UIButton!
    
    
    var editIndex: Int?
    var source: WorkProcessesViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if editIndex != nil {
            addButton.setTitle("Editieren", for: UIControlState.normal)
        }
    }
    
    
    @IBAction func add(_ sender: Any) {
        if let editIndex = editIndex {
            source.processes[editIndex].date = date.date
            source.processes[editIndex].field = field.text!
            source.processes[editIndex].user = user.text!
            source.processes[editIndex].time = Double(time.text!)!
        } else {
            let process = WorkProcess(date: date.date, field: field.text!, user: user.text!, time: Double(time.text!)!)
            
            source.processes.append(process)
        }
        
        source.tableView.reloadData()
        self.dismiss(animated: false, completion: nil)
    }
    
    @IBAction func cancel(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
}
