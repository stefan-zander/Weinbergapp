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
    
    /*
 
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
 }*/
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return vintages.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VintageViewCell", for: indexPath)

        cell.textLabel?.text = vintages[indexPath.row].field

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        
        if let addVintage = storyBoard.instantiateViewController(withIdentifier: "AddVintage") as? AddVintageViewController {
            addVintage.source = self
            addVintage.editIndex = indexPath.row
            
            self.present(addVintage, animated: false, completion: {
                addVintage.date.date = self.vintages[indexPath.row].date
                addVintage.field.text = self.vintages[indexPath.row].field
                addVintage.user.text = self.vintages[indexPath.row].user
                addVintage.workingHours.text = String(self.vintages[indexPath.row].workingHours)
                addVintage.execution.selectRow(self.vintages[indexPath.row].execution == VintageExecution.Manual ? 0 : 1, inComponent: 0, animated: false)
            })
        }
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
    
    
    @IBAction func add(_ sender: UIBarButtonItem) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        
        if let addVintage = storyBoard.instantiateViewController(withIdentifier: "AddVintage") as? AddVintageViewController {
            addVintage.source = self
            self.present(addVintage, animated: false, completion: nil)
        }
    }
    
    @IBAction func back(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
}
