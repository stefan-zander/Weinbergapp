//
//  PlantProtectionTreatmentSchedule.swift
//  Weinbergapp
//
//  Created by Stefan Zander on 16.07.18.
//  Copyright © 2018 TH Bingen. All rights reserved.
//

import Foundation

/**
 Represents the treatment schedule used for the plant protection operation.

 ````
 case proliferation
 case earlyFlowering
 case firstPreBloom
 case secondPreBloom
 case thirdPreBloom
 case outgoingFlowering
 case secondPostBloom
 case thirdPostBloom
 ````
 */
public enum PlantProtectionTreatmentSchedule: Int {

    /// Represents the treatment schedule "Proliferation".
    case proliferation

    /// Represents the treatment schedule "early flowering".
    case earlyFlowering

    /// Represents the treatment schedule "1st pre-bloom".
    case firstPreBloom

    /// Represents the treatment schedule "2nd pre-bloom".
    case secondPreBloom

    /// Represents the treatment schedule "3rd pre-bloom".
    case thirdPreBloom

    /// Represents the treatment schedule "outgoing flowering".
    case outgoingFlowering

    /// Represents the treatment schedule "2nd post-bloom".
    case secondPostBloom

    /// Represents the treatment schedule "3rd post-bloom".
    case thirdPostBloom
}
