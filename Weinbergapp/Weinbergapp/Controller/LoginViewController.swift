//
//  ViewController.swift
//  Weinbergapp
//
//  Created by Benutzer on 08.06.18.
//  Copyright © 2018 TH Bingen. All rights reserved.
//

import UIKit
import Foundation

class LoginViewController: UIViewController {
    
    @IBOutlet weak var _username: UITextField!
    @IBOutlet weak var _password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func login(_ sender: Any) {
        let username = self._username.text
        let password = self._password.text
        
        if(username == "" || password == "") {
            let storyBoard = UIStoryboard(name: "View", bundle: nil)
            if let controller = storyBoard.instantiateViewController(withIdentifier: "controller") as? UITabBarController {
                self.present(controller, animated: true, completion: nil)
            }            
        } else {
            let alert = UIAlertController(title: "Login fehlgeschlagen", message: "Ungültige Zugangsdaten. Bitte versuchen Sie es erneut", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                switch action.style {
                case .default:
                    print("default")
                    
                case .cancel:
                    print("cancel")
                    
                case .destructive:
                    print("destructive")
                }}))
            self.present(alert, animated: true, completion: nil)
        }
    }        
}
    













