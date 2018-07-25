//
//  OrganicFertilizer.swift
//  Weinbergapp
//
//  Created by VM on 19.07.18.
//  Copyright © 2018 TH Bingen. All rights reserved.
//

import Foundation

/**
 An organic fertilizer.
 
 ````
 case terragon
 case wineYeastsFiltered
 case marc
 case layingHens
 case bovine
 case biowasteCompost
 case bark
 case wineYeastLiquid
 ````
 */
public enum OrganicFertilizer: Int {
    
    /// The organic fertilizer "Terragon".
    case terragon
    
    /// The organic fertilizer "Wine yeasts filtered".
    case wineYeastsFiltered
    
    /// The organic fertilizer "Marc".
    case marc
    
    /// The organic fertilizer "Laying hens".
    case layingHens
    
    /// The organic fertilizer "Bovine".
    case bovine
    
    /// The organic fertilizer "Biowaste compost".
    case biowasteCompost
    
    /// The organic fertilizer "Bark".
    case bark
    
    /// The organic fertilizer "Wine yeast liquid".
    case wineYeastLiquid
}
