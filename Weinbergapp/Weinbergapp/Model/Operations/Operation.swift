//
//  Operation.swift
//  Weinbergapp
//
//  Created by Benutzer on 28.06.18.
//  Copyright © 2018 TH Bingen. All rights reserved.
//

import UIKit

struct Operation {
    let name: String
    let image: UIImage
    let storyboardIdentifier: String

    init(name: String, image: UIImage, storyboardIdentifier: String) {
        self.name = name
        self.image = image
        self.viewName = storyboardIdentifier
    }
}
