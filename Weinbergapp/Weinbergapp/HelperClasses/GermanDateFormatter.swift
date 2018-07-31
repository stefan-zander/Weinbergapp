//
//  GermanDateFormatter.swift
//  Weinbergapp
//
//  Created by Stefan Zander on 30.07.18.
//  Copyright © 2018 TH Bingen. All rights reserved.
//

import Foundation

/**
 Formats a date according to german date formats.
 */
public class GermanDateFormatter {

    /// Returns the singleton formatting instance
    public static let shared = GermanDateFormatter()

    private let dateFormatter: DateFormatter

    private init() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        dateFormatter.locale = Locale.init(identifier: "de_DE")
        self.dateFormatter = dateFormatter
    }

    /**
     Returns a string representation of a given date formatted using the german date format.

     - Parameter date: The date to format.
     - Returns: A string representation of date formatted using the german date format.
    */
    public func string(from date: Date) -> String {
        return dateFormatter.string(from: date)
    }

    /**
     Returns a date representation of a given string interpreted using the german date format.

     - Parameter string: The string to parse.
     - Returns: A date representation of string interpreted using the german date format. If date(from:) can not parse
                the string, returns nil.
     */
    public func date(from string: String) -> Date? {
        return dateFormatter.date(from: string)
    }
}
