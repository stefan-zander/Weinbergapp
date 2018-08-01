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

    var coordinates: [CLLocationCoordinate2D] = []

    var source: MapViewController!
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
            assert(false)
        }

        MapDialogs.presentFieldDeletionConfirmation(controller: self,
                                                    fieldName: editingField.name,
                                                    onConfirmation: { _ in
            do {
                if let index = self.source.fields.index(where: { $0 === editingField }) {
                    try self.source.fieldDataSource.delete(editingField.field)
                    editingField.displayedOnMap = false
                    self.source.fields.remove(at: index)
                }
            } catch let error as NSError {
                MapDialogs.presentDeletionInDatabaseFailed(controller: self, error: error)
                return
            }

            self.dismiss(animated: true, completion: nil)
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
                MapDialogs.presentUpdateInDatabaseFailed(controller: self, error: error)
                return
            }
        } else {
            let field = Field()

            field.name = name.text ?? ""
            field.vineVariety = vineVariety.text ?? ""
            field.setCoordinates(coordinates)

            do {
                try source.fieldDataSource.add(field)
            } catch let error as NSError {
                MapDialogs.presentAddToDatabaseFailed(controller: self, error: error)
                return
            }

            let mapField = MapField(field: field,
                                    fieldDataSource: source.fieldDataSource,
                                    mapView: source.mapView)
            mapField.displayedOnMap = true
            source.fields.append(mapField)
        }

        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func cancel(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
}
