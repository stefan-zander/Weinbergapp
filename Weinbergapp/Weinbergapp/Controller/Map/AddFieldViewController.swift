//
//  AddFieldViewController.swift
//  Weinbergapp
//
//  Created by VM on 24.07.18.
//  Copyright © 2018 TH Bingen. All rights reserved.
//

import UIKit
import CoreLocation

class AddFieldViewController: UIViewController {

    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var vineVarietyField: UITextField!

    var coordinates: [CLLocationCoordinate2D] = []
    var completion: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    public var name: String {
        get {
            return nameField.text ?? ""
        }
        set(newName) {
            nameField.text = newName
        }
    }

    public var vineVariety: String {
        get {
            return vineVarietyField.text ?? ""
        }
        set(newVineVariety) {
            vineVarietyField.text = newVineVariety
        }
    }

    @IBAction func save(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: completion)
    }

    @IBAction func cancel(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
}
