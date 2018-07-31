//
//  MockableRealm.swift
//  Weinbergapp
//
//  Created by Stefan Zander on 31.07.18.
//  Copyright © 2018 TH Bingen. All rights reserved.
//

import Foundation
import RealmSwift

protocol MockableRealm {
    func objects<Element: Object>(_ type: Element.Type) -> Results<Element>
    func write(_ block: (() throws -> Void)) throws
    func add(_ object: Object)
    func delete(_ object: Object)
}
