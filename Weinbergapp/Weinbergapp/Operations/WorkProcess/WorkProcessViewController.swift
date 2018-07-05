//
//  WorkProcessViewController.swift
//  Weinbergapp
//
//  Created by Benutzer on 22.06.18.
//  Copyright © 2018 TH Bingen. All rights reserved.
//

import UIKit

class WorkProcessesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var processes: [WorkProcess] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return processes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "WorkProcessViewCell")
        
        cell?.textLabel?.text = processes[indexPath.row].field
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        
        if let addProcess = storyBoard.instantiateViewController(withIdentifier: "AddWorkProcess") as? AddWorkProcessViewController {
            addProcess.source = self
            addProcess.editIndex = indexPath.row
            
            self.present(addProcess, animated: false, completion: {
                addProcess.date.date = self.processes[indexPath.row].date
                addProcess.field.text = self.processes[indexPath.row].field
                addProcess.user.text = self.processes[indexPath.row].user
                addProcess.time.text = String(self.processes[indexPath.row].time)
            })
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            processes.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    @IBAction func add(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        
        if let addProcess = storyBoard.instantiateViewController(withIdentifier: "AddWorkProcess") as? AddWorkProcessViewController {
            addProcess.source = self
            self.present(addProcess, animated: false, completion: nil)
        }
    }
    
}
