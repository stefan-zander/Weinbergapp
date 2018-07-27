//
//  VintageLocalization.swift
//  Weinbergapp
//
//  Created by VM on 27.07.18.
//  Copyright © 2018 TH Bingen. All rights reserved.
//

import Foundation

class VintageLocalization {
    
    static func getExecution(index: Int) -> String? {
        switch index {
        case 0:
            return "Händisch"
        case 1:
            return "Mechanisch"
        default:
            return nil
        }
    }
}
