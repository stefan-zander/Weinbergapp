//
//  VintageViewController.swift
//  Weinbergapp
//
//  Created by VM on 14.07.18.
//  Copyright © 2018 TH Bingen. All rights reserved.
//

import UIKit

class VintageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var vintages: [Vintage] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vintages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "VintageViewCell")
        
        cell?.textLabel?.text = vintages[indexPath.row].field
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard = UIStoryboard(name: "View", bundle: nil)
        
        if let addVintage = storyBoard.instantiateViewController(withIdentifier: "AddVintage") as? AddVintageViewController {
            addVintage.source = self
            addVintage.editIndex = indexPath.row
            
            self.present(addVintage, animated: true, completion: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            vintages.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    @IBAction func add(_ sender: UIBarButtonItem) {
        let storyBoard = UIStoryboard(name: "View", bundle: nil)
        
        if let addVintage = storyBoard.instantiateViewController(withIdentifier: "AddVintage") as? AddVintageViewController {
            addVintage.source = self
            
            self.present(addVintage, animated: true, completion: nil)
        }
    }
    
    @IBAction func back(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
}
