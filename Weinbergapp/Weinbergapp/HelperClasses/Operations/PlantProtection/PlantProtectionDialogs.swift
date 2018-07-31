//
//  PlantProtectionDialogs.swift
//  Weinbergapp
//
//  Created by Stefan Zander on 22.07.18.
//  Copyright © 2018 TH Bingen. All rights reserved.
//

import UIKit

class PlantProtectionDialogs {
    
    static func presentPlantProtection(controller: AddPlantProtectionViewController) {
        switch controller.currentCategory {
        case .fungicidal:
            presentFungicidal(controller: controller)
        case .herbicide:
            presentHerbicide(controller: controller)
        case .insecticidalOrAcaricidal:
            presentInsecticidalOrAcaricidal(controller: controller)
        }
    }

    private static func presentFungicidal(controller: AddPlantProtectionViewController) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)

        guard let switchTable = storyboard.instantiateViewController(withIdentifier: "SwitchTableViewController")
            as? SwitchTableViewController else { return }
        
        let fungicidal = controller.currentFungicidal

        switchTable.setItems(items: [
            ("Botrytis", fungicidal.botrytis),
            ("Essigfäule", fungicidal.acidRot),
            ("Oidium", fungicidal.oidium),
            ("Peronospora", fungicidal.peronospora),
            ("Phomopsis", fungicidal.phomopsis),
            ("Roter Brenner", fungicidal.redBurner)
            ])

        switchTable.onSave = {
            fungicidal.botrytis = switchTable.getItemState(index: 0)
            fungicidal.acidRot = switchTable.getItemState(index: 1)
            fungicidal.oidium = switchTable.getItemState(index: 2)
            fungicidal.peronospora = switchTable.getItemState(index: 3)
            fungicidal.phomopsis = switchTable.getItemState(index: 4)
            fungicidal.redBurner = switchTable.getItemState(index: 5)

            controller.plantProtectionKind.text = PlantProtectionLocalization.localize(fungicidal)
        }

        controller.present(switchTable, animated: true)
    }

    private static func presentHerbicide(controller: AddPlantProtectionViewController) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)

        guard let switchTable = storyboard.instantiateViewController(withIdentifier: "SwitchTableViewController")
            as? SwitchTableViewController else { return }
        
        let herbicide = controller.currentHerbicide

        switchTable.setItems(items: [
            ("Ackerwinde", herbicide.bindweed),
            ("Ein- und Zweikeimblättrige", herbicide.monocotyledonousAndDicotyledonous)
            ])

        switchTable.onSave = {
            herbicide.bindweed = switchTable.getItemState(index: 0)
            herbicide.monocotyledonousAndDicotyledonous = switchTable.getItemState(index: 1)

            controller.plantProtectionKind.text = PlantProtectionLocalization.localize(herbicide)
        }

        controller.present(switchTable, animated: true)
    }

    private static func presentInsecticidalOrAcaricidal(controller: AddPlantProtectionViewController) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)

        guard let switchTable = storyboard.instantiateViewController(withIdentifier: "SwitchTableViewController")
            as? SwitchTableViewController else { return }
        
        let insecticidalOrAcaricidal = controller.currentInsecticidalOrAcaricidal

        switchTable.setItems(items: [
            ("Drosophila-Arten", insecticidalOrAcaricidal.drosophilaSpecies),
            ("Kräuselmilben", insecticidalOrAcaricidal.grapevineRustMites),
            ("Rhombenspanner", insecticidalOrAcaricidal.willowBeauty),
            ("Spinnmilben", insecticidalOrAcaricidal.spiderMites),
            ("Springwurm", insecticidalOrAcaricidal.springWorm),
            ("Traubenwickler (Heu- und Sauerwurm)", insecticidalOrAcaricidal.grape),
            ("Zikaden", insecticidalOrAcaricidal.cicadas)
            ])

        switchTable.onSave = {
            insecticidalOrAcaricidal.drosophilaSpecies = switchTable.getItemState(index: 0)
            insecticidalOrAcaricidal.grapevineRustMites = switchTable.getItemState(index: 1)
            insecticidalOrAcaricidal.willowBeauty = switchTable.getItemState(index: 2)
            insecticidalOrAcaricidal.spiderMites = switchTable.getItemState(index: 3)
            insecticidalOrAcaricidal.springWorm = switchTable.getItemState(index: 4)
            insecticidalOrAcaricidal.grape = switchTable.getItemState(index: 5)
            insecticidalOrAcaricidal.cicadas = switchTable.getItemState(index: 6)
            
            controller.plantProtectionKind.text = PlantProtectionLocalization.localize(insecticidalOrAcaricidal)
        }

        controller.present(switchTable, animated: true)
    }

    static func presentPesticides(controller: AddPlantProtectionViewController) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        guard let switchTable = storyboard.instantiateViewController(withIdentifier: "SwitchTable")
            as? SwitchTableViewController else { return }

        let pesticides = controller.currentPesticides

        switchTable.setItems(items: [
            ("Botector", pesticides.botector),
            ("Cantus", pesticides.cantus),
            ("Gibbb 3", pesticides.gibbb3),
            ("Melody Combi", pesticides.melodyCombi),
            ("Prolectus", pesticides.prolectus),
            ("Pyrus; Babel", pesticides.pyrusBabel),
            ("Regalis Plus", pesticides.regalisPlus),
            ("Scala", pesticides.scala),
            ("Switch", pesticides.`switch`),
            ("Teldor", pesticides.teldor)
            ])

        switchTable.onSave = {
            pesticides.botector = switchTable.getItemState(index: 0)
            pesticides.cantus = switchTable.getItemState(index: 1)
            pesticides.gibbb3 = switchTable.getItemState(index: 2)
            pesticides.melodyCombi = switchTable.getItemState(index: 3)
            pesticides.prolectus = switchTable.getItemState(index: 4)
            pesticides.pyrusBabel = switchTable.getItemState(index: 5)
            pesticides.regalisPlus = switchTable.getItemState(index: 6)
            pesticides.scala = switchTable.getItemState(index: 7)
            pesticides.`switch` = switchTable.getItemState(index: 8)
            pesticides.teldor = switchTable.getItemState(index: 9)

            controller.pesticides.text = PlantProtectionLocalization.localize(pesticides)
        }

        controller.present(switchTable, animated: true)
    }
}
