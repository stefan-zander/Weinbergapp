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

    var editingField: MKField?

    override func viewDidLoad() {
        super.viewDidLoad()

        if let editingField = editingField {
            nameField.text = editingField.field.name
            vineVarietyField.text = editingField.field.vineVariety
        }
    }

    public var name: String {
        return nameField.text ?? ""
    }

    public var vineVariety: String {
        return vineVarietyField.text ?? ""
    }

    @IBAction func save(_ sender: UIBarButtonItem) {
        guard MapFieldVerification.verify(name: nameField, self) != nil else { return }
        guard MapFieldVerification.verify(vineVariety: vineVarietyField, self) != nil else { return }

        self.dismiss(animated: true, completion: completion)
    }

    @IBAction func cancel(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
}