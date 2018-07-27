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
public enum FertilizerCategory: Int {

    /// A mineral fertilizer.
    case mineral

    /// An organic fertilizer.
    case organic
}
