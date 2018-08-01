//
//  PlantProtectionLocalization.swift
//  Weinbergapp
//
//  Created by Stefan Zander on 21.07.18.
//  Copyright © 2018 TH Bingen. All rights reserved.
//

import Foundation

class PlantProtectionLocalization {

    static let treatmentScheduleOptions = [
        "Austrieb",
        "Vorblüte",
        "1. Vorblüte",
        "2. Vorblüte",
        "3. Vorblüte",
        "Abgehende Blüte",
        "2. Nachblüte",
        "3. Nachblüte"
    ]

    static func localize(_ fungicidal: FungicidalPlantProtection) -> String {
        var choices: [String] = []

        if fungicidal.botrytis {
            choices.append("Botrytis")
        }

        if fungicidal.acidRot {
            choices.append("Essigfäule")
        }

        if fungicidal.oidium {
            choices.append("Oidium")
        }

        if fungicidal.peronospora {
            choices.append("Peronospora")
        }

        if fungicidal.phomopsis {
            choices.append("Phomopsis")
        }

        if fungicidal.redBurner {
            choices.append("Roter Brenner")
        }

        return choices.joined(separator: ", ")
    }

    static func localize(_ herbicide: HerbicidePlantProtection) -> String {
        var choices: [String] = []

        if herbicide.bindweed {
            choices.append("Ackerwinde")
        }
        if herbicide.monocotyledonousAndDicotyledonous {
            choices.append("Ein- und Zweikeimblättrige")
        }

        return choices.joined(separator: ", ")
    }

    static func localize(_ insecticidalOrAcaricidal: InsecticidalOrAcaricidalPlantProtection) -> String {
        var choices: [String] = []

        if insecticidalOrAcaricidal.drosophilaSpecies {
            choices.append("Drosophila-Arten")
        }

        if insecticidalOrAcaricidal.grapevineRustMites {
            choices.append("Kräuselmilben")
        }

        if insecticidalOrAcaricidal.willowBeauty {
            choices.append("Rhombenspanner")
        }

        if insecticidalOrAcaricidal.spiderMites {
            choices.append("Spinnmilben")
        }

        if insecticidalOrAcaricidal.springWorm {
            choices.append("Springwurm")
        }

        if insecticidalOrAcaricidal.grape {
            choices.append("Traubenwickler (Heu- und Sauerwurm)")
        }

        if insecticidalOrAcaricidal.cicadas {
            choices.append("Zikaden")
        }

        return choices.joined(separator: ", ")
    }

    static func localize(_ pesticides: PlantProtectionPesticides) -> String {
        var choices: [String] = []

        if pesticides.botector {
            choices.append("Botector")
        }

        if pesticides.cantus {
            choices.append("Cantus")
        }

        if pesticides.gibbb3 {
            choices.append("Gibbb 3")
        }

        if pesticides.melodyCombi {
            choices.append("Melody Combi")
        }

        if pesticides.prolectus {
            choices.append("Prolectus")
        }

        if pesticides.pyrusBabel {
            choices.append("Pyrus; Babel")
        }

        if pesticides.regalisPlus {
            choices.append("Regalis Plus")
        }

        if pesticides.scala {
            choices.append("Scala")
        }

        if pesticides.switch {
            choices.append("Switch")
        }

        if pesticides.teldor {
            choices.append("Teldor")
        }

        return choices.joined(separator: ", ")
    }
}
