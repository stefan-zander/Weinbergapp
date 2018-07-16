//
//  PlantProtectionSwitchListViewController.swift
//  Weinbergapp
//
//  Created by VM on 14.07.18.
//  Copyright © 2018 TH Bingen. All rights reserved.
//

import UIKit

class SwitchListViewController: UIViewController {
    
    var items: [(String, Bool)] = []

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func initialize(labels: [String]) {
        items = labels.map { ($0, false) }
    }
    
    func getItemLabels() -> [String] {
        return items.map { $0.0 }
    }
    
    func getItemStates() -> [Bool] {
        return items.map { $0.1 }
    }
    
    func getItemLabel(index: Int) -> String {
        return items[index].0
    }
    
    func getItemState(index: Int) -> Bool {
        return items[index].1
    }
    
    func setItemLabels(labels: [String]) {
        for i in 0..<items.count {
            items[i].0 = labels[i]
        }
    }
    
    func setItemStates(states: [Bool]) {
        for i in 0..<items.count {
            items[i].1 = states[i]
        }
    }
    
    func setItemLabel(index: Int, label: String) {
        items[index].0 = label
    }
    
    func setItemState(index: Int, state: Bool) {
        items[index].1 = state
    }

}
