//
//  PlantProtectionSwitchListTableViewCell.swift
//  Weinbergapp
//
//  Created by VM on 14.07.18.
//  Copyright © 2018 TH Bingen. All rights reserved.
//

import UIKit

class SwitchListTableViewCell: UITableViewCell {

    @IBOutlet weak var checked: UISwitch!
    @IBOutlet weak var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setText(text: String) {
        label.text = text
    }
    
    func setChecked(checked: Bool) {
        self.checked.isOn = checked
    }
}
