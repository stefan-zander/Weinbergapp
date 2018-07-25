//
//  MineralFertilizer.swift
//  Weinbergapp
//
//  Created by VM on 19.07.18.
//  Copyright © 2018 TH Bingen. All rights reserved.
//

import Foundation

/**
 A mineral fertilizer.
 
 ````
 case entecPerfect
 case entec26
 case hyperphosphate
 case mgLimes
 case kornkali
 case kalimagnesia
 case potassiumSulfate
 case calciumNitrate
 ````
 */
public enum MineralFertilizer: Int {
    
    /// The mineral fertilizer "Entec Perfect".
    case entecPerfect
    
    /// The mineral fertilizer "Entec 26".
    case entec26
    
    /// The mineral fertilizer "Hyperphosphate".
    case hyperphosphate
    
    /// The mineral fertilizer "MG-Limes".
    case mgLimes
    
    /// The mineral fertilizer "Kornkali".
    case kornkali
    
    /// The mineral fertilizer "Kalimagnesia".
    case kalimagnesia
    
    /// The mineral fertilizer "Potassium sulfate".
    case potassiumSulfate
    
    /// The mineral fertilizer "Calcium nitrate".
    case calciumNitrate
}
