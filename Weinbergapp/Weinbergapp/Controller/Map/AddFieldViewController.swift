//
//  AddFieldViewController.swift
//  Weinbergapp
//
//  Created by Stefan Zander on 24.07.18.
//  Copyright © 2018 TH Bingen. All rights reserved.
//

import UIKit
import CoreLocation

class AddFieldViewController: UIViewController {

    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var vineVariety: UITextField!
    @IBOutlet weak var deleteFieldButton: UIButton!

    var fields: FieldCollection!
    var coordinates: [CLLocationCoordinate2D] = []
    var editingField: MapField?

    override func viewDidLoad() {
        super.viewDidLoad()

        if let editingField = editingField {
            name.text = editingField.name
            vineVariety.text = editingField.vineVariety
            deleteFieldButton.isHidden = false
        }
    }

    @IBAction func deleteField(_ sender: UIButton) {
        guard let editingField = editingField else {
            assert(false, "Ability to delete fields should never be present on non-editing uses of this controller.")
        }
        
        MapDialogs.presentDeletionConfirmation(controller: self, field: editingField, onConfirmation: { _ in
            do {
                try self.fields.delete(editingField.field)
                self.dismiss(animated: true, completion: nil)
            } catch let error as NSError {
                MapDialogs.presentDatabaseDeletionError(error, controller: self)
            }
        })
        
    }

    @IBAction func save(_ sender: UIBarButtonItem) {
        guard MapFieldVerification.verify(name: name, self) != nil else { return }
        guard MapFieldVerification.verify(vineVariety: vineVariety, self) != nil else { return }

        if let editingField = editingField {
            do {
                try editingField.changeText(name: name.text ?? "",
                                            vineVariety: vineVariety.text ?? "")
            } catch let error as NSError {
                MapDialogs.presentDatabaseUpdateError(error, controller: self)
                return
            }
        } else {
            let field = Field()

            field.name = name.text ?? ""
            field.vineVariety = vineVariety.text ?? ""
            field.setCoordinates(coordinates)

            do {
                try fields.add(field)
            } catch let error as NSError {
                MapDialogs.presentDatabaseAddError(error, controller: self)
                return
            }
        }

        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func cancel(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
}
