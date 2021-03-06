//
//  VintageTableViewCell.swift
//  Weinbergapp
//
//  Created by Stefan Zander on 21.07.18.
//  Copyright © 2018 TH Bingen. All rights reserved.
//

import UIKit

class VintageTableViewCell: UITableViewCell {

    @IBOutlet weak var field: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var user: UILabel!

    func setField(field: String) {
        self.field.text = field
    }

    func setDate(date: String) {
        self.date.text = date
    }

    func setUser(user: String) {
        self.user.text = user
    }
}
