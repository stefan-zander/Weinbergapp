//
//  Business.swift
//  Weinbergapp
//
//  Created by Stefan Zander on 02.08.18.
//  Copyright © 2018 TH Bingen. All rights reserved.
//

import Foundation
import RealmSwift

/**
 Represents a business that can be imported from a QR code.
 */
public class Business: Object {
    
    /// The name of the business
    @objc public dynamic var name: String = ""
    
    /// The url of the business server
    @objc public dynamic var url: String = ""
}
