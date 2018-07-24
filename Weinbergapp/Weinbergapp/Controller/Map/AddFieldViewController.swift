//
//  AddFieldViewController.swift
//  Weinbergapp
//
//  Created by VM on 24.07.18.
//  Copyright © 2018 TH Bingen. All rights reserved.
//

import UIKit

class AddFieldViewController: UIViewController {

    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var vineVariety: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func save(_ sender: UIBarButtonItem) {
    }

    @IBAction func cancel(_ sender: UIBarButtonItem) {
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
