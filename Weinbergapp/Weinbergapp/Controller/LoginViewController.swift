//
//  LoginViewController.swift
//  Weinbergapp
//
//  Created by Nina Kirilmaz on 08.06.18.
//  Copyright © 2018 TH Bingen. All rights reserved.
//

import UIKit
import Foundation
import RealmSwift

class LoginViewController: UIViewController {

    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func passwordVisibilityToggled(_ sender: UISwitch) {
        password.isSecureTextEntry = !sender.isOn
    }

    @IBAction func login(_ sender: Any) {
        // TODO change username and password
        guard username.text == "" && password.text == "" else {
            LoginDialogs.presentLoginFailed(controller: self)
            return
        }
        
        do {
            let realm = try Realm()
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            
            if let controller = storyboard.instantiateViewController(withIdentifier: "Main")
                as? MainViewController {
                controller.realm = realm
                
                self.present(controller, animated: true)
            }
        } catch let error as NSError {
            LoginDialogs.presentDatabaseError(controller: self, error: error)
            return
        }
    }
}
