//
//  FertilizationLocalization.swift
//  Weinbergapp
//
//  Created by VM on 27.07.18.
//  Copyright © 2018 TH Bingen. All rights reserved.
//

import Foundation

class FertilizationLocalization {
    
    static func localizeFertilizerCategory(index: Int) -> String? {
        switch index {
        case 0:
            return "Mineralisch"
        case 1:
            return "Organisch"
        default:
            return nil
        }
    }
    
    static func localizeMineralFertilizer(index: Int) -> String? {
        switch index {
        case 0:
            return "Entec perfekt"
        case 1:
            return "Entec 26"
        case 2:
            return "Hyperphosphat - fein (Rohphosphat)"
        case 3:
            return "Mg-Kalke"
        case 4:
            return "Kornkali mit MgO"
        case 5:
            return "Kalimagnesia (Parent-Kali)"
        case 6:
            return "Kaliumsulfat fein u. granuliert"
        case 7:
            return "Kalksalpeter"
        default:
            return nil
        }
    }
    
    static func getOrganicFertilizer(index: Int) -> String? {
        switch index {
        case 0:
            return "Terragon"
        case 1:
            return "Weinhefen filtriert"
        case 2:
            return "Trester"
        case 3:
            return "Legehennen (22,5% TS)"
        case 4:
            return "Rinder"
        case 5:
            return "Bio(Abfall)kompost"
        case 6:
            return "Baumrinde (1m3 = 0,4 t)"
        case 7:
            return "Weinhefe Flüssig (1m² = 1t)"
        default:
            return nil
        }
    }
}
