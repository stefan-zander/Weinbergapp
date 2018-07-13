//
//  WorkProcessViewController.swift
//  Weinbergapp
//
//  Created by Benutzer on 22.06.18.
//  Copyright © 2018 TH Bingen. All rights reserved.
//

import UIKit

class WorkProcessesTableViewController: UITableViewController, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    var processes: [WorkProcess] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        setUpSearchBar()
    }
    
    private func setUpSearchBar() {
        searchBar.delegate = self
        
    }
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return processes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "WorkProcessViewCell")
        
        cell?.textLabel?.text = processes[indexPath.row].field
        
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
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
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            processes.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
       
    }
    
    public func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        
    }
    
    @IBAction func add(_ sender: UIBarButtonItem) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        
        if let addProcess = storyBoard.instantiateViewController(withIdentifier: "AddWorkProcess") as? AddWorkProcessViewController {
            addProcess.source = self
            self.present(addProcess, animated: false, completion: nil)
        }
    }
    
    @IBAction func back(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
