//
//  StringExtensions.swift
//  WeatherApp
//
//  Created by Hyvärinen Santtu on 11.10.2021.
//

import Foundation

extension String {
    func formatToAPI() -> String {
        return self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? ""
    }
    
    func localize() -> String {
        return NSLocalizedString(self, comment: "")
    }
}

