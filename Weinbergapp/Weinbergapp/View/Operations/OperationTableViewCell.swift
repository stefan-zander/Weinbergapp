//
//  OperationTableViewCell.swift
//  Weinbergapp
//
//  Created by Stefan Zander on 28.06.18.
//  Copyright © 2018 TH Bingen. All rights reserved.
//

import UIKit

class OperationTableViewCell: UITableViewCell {

    @IBOutlet weak var labelOperationName: UILabel!
    @IBOutlet weak var imageThumbnailOperation: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func set(name: String) {
        labelOperationName.text = name
    }

    func set(image: UIImage) {
        imageThumbnailOperation.image = image
    }
}
