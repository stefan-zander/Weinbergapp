//
//  MoreViewController.swift
//  Weinbergapp
//
//  Created by Stefan Zander on 21.07.18.
//  Copyright © 2018 TH Bingen. All rights reserved.
//

import UIKit

class MoreViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func setupBusiness(_ sender: UIButton) {
        // TODO add QR scanner
    }

    @IBAction func logout(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
