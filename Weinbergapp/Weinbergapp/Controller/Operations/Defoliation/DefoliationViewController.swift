//
//  DefoliationViewController.swift
//  Weinbergapp
//
//  Created by VM on 14.07.18.
//  Copyright © 2018 TH Bingen. All rights reserved.
//

import UIKit

class DefoliationViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var defoliations: [Defoliation] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return defoliations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "DefoliationViewCell")
        
        cell?.textLabel?.text = defoliations[indexPath.row].field
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard = UIStoryboard(name: "View", bundle: nil)
        
        if let addDefoliation = storyBoard.instantiateViewController(withIdentifier: "AddDefoliation") as? AddDefoliationViewController {
            addDefoliation.source = self
            addDefoliation.editIndex = indexPath.row
            
            self.present(addDefoliation, animated: true, completion: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            defoliations.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    @IBAction func add(_ sender: UIBarButtonItem) {
        let storyBoard = UIStoryboard(name: "View", bundle: nil)
        
        if let addDefoliation = storyBoard.instantiateViewController(withIdentifier: "AddDefoliation") as? AddDefoliationViewController {
            addDefoliation.source = self
            
            self.present(addDefoliation, animated: true, completion: nil)
        }
    }
    
    @IBAction func back(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
}
