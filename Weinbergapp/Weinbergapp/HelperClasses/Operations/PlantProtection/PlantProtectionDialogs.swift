//
//  PlantProtectionDialogs.swift
//  Weinbergapp
//
//  Created by VM on 22.07.18.
//  Copyright © 2018 TH Bingen. All rights reserved.
//

import UIKit

public class PlantProtectionDialogs {

    public static func present(fungicidal: FungicidalPlantProtection,
                               controller: UIViewController,
                               completion: @escaping () -> Void) {
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
                fungicidal.botrytis = switchTable.getItemState(index: 0)
                fungicidal.acidRot = switchTable.getItemState(index: 1)
                fungicidal.oidium = switchTable.getItemState(index: 2)
                fungicidal.peronospora = switchTable.getItemState(index: 3)
                fungicidal.phomopsis = switchTable.getItemState(index: 4)
                fungicidal.redBurner = switchTable.getItemState(index: 5)

                completion()
            }

            controller.present(switchTable, animated: true)
        }
    }

    public static func present(herbicide: HerbicidePlantProtection,
                               controller: UIViewController,
                               completion: @escaping () -> Void) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)

        if let switchTable = storyboard.instantiateViewController(withIdentifier: "SwitchTableViewController")
            as? SwitchTableViewController {

            switchTable.setItems(items: [
                ("Ackerwinde", herbicide.bindweed),
                ("Ein- und Zweikeimblättrige", herbicide.monocotyledonousAndDicotyledonous)
                ])

            switchTable.completion = {
                herbicide.bindweed = switchTable.getItemState(index: 0)
                herbicide.monocotyledonousAndDicotyledonous = switchTable.getItemState(index: 1)

                completion()
            }

            controller.present(switchTable, animated: true)
        }
    }

    public static func present(insecticidalOrAcaricidal: InsecticidalOrAcaricidalPlantProtection,
                               controller: UIViewController,
                               completion: @escaping () -> Void) {
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
                insecticidalOrAcaricidal.drosophilaSpecies = switchTable.getItemState(index: 0)
                insecticidalOrAcaricidal.grapevineRustMites = switchTable.getItemState(index: 1)
                insecticidalOrAcaricidal.willowBeauty = switchTable.getItemState(index: 2)
                insecticidalOrAcaricidal.spiderMites = switchTable.getItemState(index: 3)
                insecticidalOrAcaricidal.springWorm = switchTable.getItemState(index: 4)
                insecticidalOrAcaricidal.grape = switchTable.getItemState(index: 5)
                insecticidalOrAcaricidal.cicadas = switchTable.getItemState(index: 6)
                
                completion()
            }

            controller.present(switchTable, animated: true)
        }
    }

    public static func present(pesticides: PlantProtectionPesticides,
                               controller: UIViewController,
                               completion: @escaping () -> Void) {
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

                completion()
            }

            controller.present(switchTable, animated: true)
        }
    }
}
