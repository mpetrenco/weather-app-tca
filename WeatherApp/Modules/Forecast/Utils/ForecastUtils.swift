//
//  ForecastUtils.swift
//  WeatherApp
//
//  Created by Mihai Petrenco on 10.10.2022.
//

import Foundation

// MARK: - Formatters

private var weatherFormatter: NumberFormatter = {
    let numberFormatter = NumberFormatter()
    numberFormatter.maximumFractionDigits = 1
    return numberFormatter
}()

// MARK: - Formatting Methods

func weatherFormattedValue(_ value: Double) -> String {
    let number = NSNumber(floatLiteral: value)
    
    guard let stringValue = weatherFormatter.string(from: number) else {
        return "N/A"
    }
    
    return stringValue + "°"
}
