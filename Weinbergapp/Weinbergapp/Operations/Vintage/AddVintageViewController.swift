//
//  AddVintageViewController.swift
//  Weinbergapp
//
//  Created by Benutzer on 29.06.18.
//  Copyright © 2018 TH Bingen. All rights reserved.
//

import UIKit

class AddVintageViewController: UIViewController, UIPickerViewDelegate {
    @IBOutlet weak var date: UIDatePicker!
    
    @IBOutlet weak var field: UITextField!
    
    @IBOutlet weak var user: UITextField!
    
    @IBOutlet weak var workingHours: UITextField!
    
    @IBOutlet weak var execution: UIPickerView!
    
    var editIndex: Int?
    var source: VintageTableViewController!
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "test"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        execution.delegate = self
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
