//
//  OperationTableViewCell.swift
//  Weinbergapp
//
//  Created by Stefan Zander on 28.06.18.
//  Copyright © 2018 TH Bingen. All rights reserved.
//

import UIKit

class OperationTableViewCell: UITableViewCell {

    @IBOutlet weak var imageThumbnailOperation: UIImageView!
    @IBOutlet weak var labelOperationName: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func initCell(operation: Operation) {
        imageThumbnailOperation.image = operation.image
        labelOperationName.text = operation.name
    }

}
