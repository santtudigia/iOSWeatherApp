//
//  StringExtensions.swift
//  WeatherApp
//
//  Created by Hyvärinen Santtu on 11.10.2021.
//

import Foundation

extension Double {
    func formatDigits(digits : Int) -> String {
        return String(format: "%.\(digits)f", self)
    }
}
