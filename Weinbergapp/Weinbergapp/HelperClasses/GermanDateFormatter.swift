//
//  GermanDateFormatter.swift
//  Weinbergapp
//
//  Created by VM on 30.07.18.
//  Copyright © 2018 TH Bingen. All rights reserved.
//

import Foundation

public class GermanDateFormatter {
    
    public static let shared = GermanDateFormatter()
    
    private let dateFormatter: DateFormatter
    
    private init() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        dateFormatter.locale = Locale.init(identifier: "de_DE")
        self.dateFormatter = dateFormatter
    }
    
    public func string(from date: Date) -> String {
        return dateFormatter.string(from: date)
    }
    
    public func date(from string: String) -> Date? {
        return dateFormatter.date(from: string)
    }
    
}
