//
//  PlantProtectionLocalizationTests.swift
//  WeinbergappTests
//
//  Created by VM on 01.08.18.
//  Copyright © 2018 TH Bingen. All rights reserved.
//

import XCTest
@testable import Weinbergapp

class PlantProtectionLocalizationTests: XCTestCase {
    
    func testFungicidal1() {
        // given
        let fungicidal = FungicidalPlantProtection()
        
        // when
        let localized = PlantProtectionLocalization.localize(fungicidal)
        
        // then
        XCTAssertEqual("", localized)
    }
    
    func testFungicidal2() {
        // given
        let fungicidal = FungicidalPlantProtection()
        fungicidal.botrytis = true
        
        // when
        let localized = PlantProtectionLocalization.localize(fungicidal)
        
        // then
        XCTAssertEqual("Botrytis", localized)
    }
    
    func testFungicidal3() {
        // given
        let fungicidal = FungicidalPlantProtection()
        fungicidal.acidRot = true
        fungicidal.oidium = true
        
        // when
        let localized = PlantProtectionLocalization.localize(fungicidal)
        
        // then
        XCTAssertEqual("Essigfäule, Oidium", localized)
    }
    
    func testFungicidal4() {
        // given
        let fungicidal = FungicidalPlantProtection()
        fungicidal.peronospora = true
        fungicidal.phomopsis = true
        fungicidal.redBurner = true
        
        // when
        let localized = PlantProtectionLocalization.localize(fungicidal)
        
        // then
        XCTAssertEqual("Peronospora, Phomopsis, Roter Brenner", localized)
    }
    
    func testHerbicide1() {
        // given
        let herbicide = HerbicidePlantProtection()
        
        // when
        let localized = PlantProtectionLocalization.localize(herbicide)
        
        // then
        XCTAssertEqual("", localized)
    }
    
    func testHerbicide2() {
        // given
        let herbicide = HerbicidePlantProtection()
        herbicide.monocotyledonousAndDicotyledonous = true
        
        // when
        let localized = PlantProtectionLocalization.localize(herbicide)
        
        // then
        XCTAssertEqual("Ein- und Zweikeimblättrige", localized)
    }
    
    func testHerbicide3() {
        // given
        let herbicide = HerbicidePlantProtection()
        herbicide.bindweed = true
        herbicide.monocotyledonousAndDicotyledonous = true
        
        // when
        let localized = PlantProtectionLocalization.localize(herbicide)
        
        // then
        XCTAssertEqual("Ackerwinde, Ein- und Zweikeimblättrige", localized)
    }
    
    func testInsecticidalOrAcaricidal1() {
        // given
        let insecticidalOrAcaricidal = InsecticidalOrAcaricidalPlantProtection()
        
        // when
        let localized = PlantProtectionLocalization.localize(insecticidalOrAcaricidal)
        
        // then
        XCTAssertEqual("", localized)
    }
    
    func testInsecticidalOrAcaricidal2() {
        // given
        let insecticidalOrAcaricidal = InsecticidalOrAcaricidalPlantProtection()
        insecticidalOrAcaricidal.cicadas = true
        
        // when
        let localized = PlantProtectionLocalization.localize(insecticidalOrAcaricidal)
        
        // then
        XCTAssertEqual("Zikaden", localized)
    }
    
    func testInsecticidalOrAcaricidal3() {
        // given
        let insecticidalOrAcaricidal = InsecticidalOrAcaricidalPlantProtection()
        insecticidalOrAcaricidal.drosophilaSpecies = true
        insecticidalOrAcaricidal.springWorm = true
        
        // when
        let localized = PlantProtectionLocalization.localize(insecticidalOrAcaricidal)
        
        // then
        XCTAssertEqual("Drosophila-Arten, Springwurm", localized)
    }
    
    func testInsecticidalOrAcaricidal4() {
        // given
        let insecticidalOrAcaricidal = InsecticidalOrAcaricidalPlantProtection()
        insecticidalOrAcaricidal.grapevineRustMites = true
        insecticidalOrAcaricidal.willowBeauty = true
        insecticidalOrAcaricidal.spiderMites = true
        insecticidalOrAcaricidal.grape = true
        
        // when
        let localized = PlantProtectionLocalization.localize(insecticidalOrAcaricidal)
        
        // then
        XCTAssertEqual("Kräuselmilben, Rhombenspanner, Spinnmilben, Traubenwickler (Heu- und Sauerwurm)", localized)
    }
    
    func testPesticides1() {
        // given
        let pesticides = PlantProtectionPesticides()
        
        // when
        let localized = PlantProtectionLocalization.localize(pesticides)
        
        // then
        XCTAssertEqual("", localized)
    }
    
    func testPesticides2() {
        // given
        let pesticides = PlantProtectionPesticides()
        pesticides.regalisPlus = true
        
        // when
        let localized = PlantProtectionLocalization.localize(pesticides)
        
        // then
        XCTAssertEqual("Regalis Plus", localized)
    }
    
    func testPesticides3() {
        // given
        let pesticides = PlantProtectionPesticides()
        pesticides.gibbb3 = true
        pesticides.cantus = true
        pesticides.botector = true
        
        // when
        let localized = PlantProtectionLocalization.localize(pesticides)
        
        // then
        XCTAssertEqual("Botector, Cantus, Gibbb 3", localized)
    }
    
    func testPesticides4() {
        // given
        let pesticides = PlantProtectionPesticides()
        pesticides.melodyCombi = true
        pesticides.pyrusBabel = true
        
        // when
        let localized = PlantProtectionLocalization.localize(pesticides)
        
        // then
        XCTAssertEqual("Melody Combi, Pyrus; Babel", localized)
    }
    
    func testPesticides5() {
        // given
        let pesticides = PlantProtectionPesticides()
        pesticides.switch = true
        pesticides.teldor = true
        pesticides.scala = true
        pesticides.prolectus = true
        
        // when
        let localized = PlantProtectionLocalization.localize(pesticides)
        
        // then
        XCTAssertEqual("Prolectus, Scala, Switch, Teldor", localized)
    }
}
