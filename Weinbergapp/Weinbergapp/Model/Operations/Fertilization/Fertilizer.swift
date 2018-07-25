//
//  Fertilizer.swift
//  Weinbergapp
//
//  Created by VM on 19.07.18.
//  Copyright © 2018 TH Bingen. All rights reserved.
//

import Foundation

/**
 A mineral or organic fertilizer.
 
 ````
 case mineral(MineralFertilizer)
 case organic(OrganicFertilizer)
 ````
 */
public enum Fertilizer {
    
    /// A mineral fertilizer
    case mineral(MineralFertilizer)
    
    /// An organic fertilizer
    case organic(OrganicFertilizer)
}
