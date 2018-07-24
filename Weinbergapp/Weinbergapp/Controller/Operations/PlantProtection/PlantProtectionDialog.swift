//
//  PlantProtectionDialogs.swift
//  Weinbergapp
//
//  Created by VM on 22.07.18.
//  Copyright © 2018 TH Bingen. All rights reserved.
//

import UIKit

public class PlantProtectionDialog {

    public static func open(fungicidal: FungicidalPlantProtection,
                            controller: UIViewController,
                            completion: @escaping (FungicidalPlantProtection) -> Void) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)

        if let switchTable = storyboard.instantiateViewController(withIdentifier: "SwitchTableViewController")
            as? SwitchTableViewController {

            switchTable.setItems(items: [
                ("Botrytis", fungicidal.botrytis),
                ("Essigfäule", fungicidal.acidRot),
                ("Oidium", fungicidal.oidium),
                ("Peronospora", fungicidal.peronospora),
                ("Phomopsis", fungicidal.phomopsis),
                ("Roter Brenner", fungicidal.redBurner)
                ])

            switchTable.completion = {
                let newFungicidal = FungicidalPlantProtection(
                    botrytis: switchTable.getItemState(index: 0),
                    acidRot: switchTable.getItemState(index: 1),
                    oidium: switchTable.getItemState(index: 2),
                    peronospora: switchTable.getItemState(index: 3),
                    phomopsis: switchTable.getItemState(index: 4),
                    redBurner: switchTable.getItemState(index: 5))

                completion(newFungicidal)
            }

            controller.present(switchTable, animated: true, completion: nil)
        }
    }

    public static func open(herbicide: HerbicidePlantProtection,
                            controller: UIViewController,
                            completion: @escaping (HerbicidePlantProtection) -> Void) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)

        if let switchTable = storyboard.instantiateViewController(withIdentifier: "SwitchTableViewController")
            as? SwitchTableViewController {

            switchTable.setItems(items: [
                ("Ackerwinde", herbicide.bindweed),
                ("Ein- und Zweikeimblättrige", herbicide.monocotyledonousAndDicotyledonous)
                ])

            switchTable.completion = {
                let newHerbicide = HerbicidePlantProtection(
                    bindweed: switchTable.getItemState(index: 0),
                    monocotyledonousAndDicotyledonous: switchTable.getItemState(index: 1))

                completion(newHerbicide)
            }

            controller.present(switchTable, animated: true, completion: nil)
        }
    }

    public static func open(insecticidalOrAcaricidal: InsecticidalOrAcaricidalPlantProtection,
                            controller: UIViewController,
                            completion: @escaping (InsecticidalOrAcaricidalPlantProtection) -> Void) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)

        if let switchTable = storyboard.instantiateViewController(withIdentifier: "SwitchTableViewController")
            as? SwitchTableViewController {

            switchTable.setItems(items: [
                ("Drosophila-Arten", insecticidalOrAcaricidal.drosophilaSpecies),
                ("Kräuselmilben", insecticidalOrAcaricidal.grapevineRustMites),
                ("Rhombenspanner", insecticidalOrAcaricidal.willowBeauty),
                ("Spinnmilben", insecticidalOrAcaricidal.spiderMites),
                ("Springwurm", insecticidalOrAcaricidal.springWorm),
                ("Traubenwickler (Heu- und Sauerwurm)", insecticidalOrAcaricidal.grape),
                ("Zikaden", insecticidalOrAcaricidal.cicadas)
                ])

            switchTable.completion = {
                let newInsecticidalOrAcaricidal = InsecticidalOrAcaricidalPlantProtection(
                    drosophilaSpecies: switchTable.getItemState(index: 0),
                    grapevineRustMites: switchTable.getItemState(index: 1),
                    willowBeauty: switchTable.getItemState(index: 2),
                    spiderMites: switchTable.getItemState(index: 3),
                    springWorm: switchTable.getItemState(index: 4),
                    grape: switchTable.getItemState(index: 5),
                    cicadas: switchTable.getItemState(index: 6))

                completion(newInsecticidalOrAcaricidal)
            }

            controller.present(switchTable, animated: true, completion: nil)
        }
    }

    public static func open(pesticides: PlantProtectionPesticides,
                            controller: UIViewController,
                            completion: @escaping (PlantProtectionPesticides) -> Void) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)

        if let switchTable = storyboard.instantiateViewController(withIdentifier: "SwitchTableViewController")
            as? SwitchTableViewController {

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

            switchTable.completion = {
                let newPesticides = PlantProtectionPesticides(
                    botector: switchTable.getItemState(index: 0),
                    cantus: switchTable.getItemState(index: 1),
                    gibbb3: switchTable.getItemState(index: 2),
                    melodyCombi: switchTable.getItemState(index: 3),
                    prolectus: switchTable.getItemState(index: 4),
                    pyrusBabel: switchTable.getItemState(index: 5),
                    regalisPlus: switchTable.getItemState(index: 6),
                    scala: switchTable.getItemState(index: 7),
                    switch: switchTable.getItemState(index: 8),
                    teldor: switchTable.getItemState(index: 9))

                completion(newPesticides)
            }

            controller.present(switchTable, animated: true, completion: nil)
        }
    }
}
