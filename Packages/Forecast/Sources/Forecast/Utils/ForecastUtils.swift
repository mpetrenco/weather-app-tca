//
//  ForecastUtils.swift
//  WeatherApp
//
//  Created by Mihai Petrenco on 10.10.2022.
//

import Foundation
import WeatherService
import Resources
import SwiftUI

// MARK: - Formatters

private let numberFormatter = NumberFormatter()
private let dateFormatter = DateFormatter()

// MARK: - Formatting Methods

func weatherFormattedValue(_ value: Double) -> String {
    numberFormatter.maximumFractionDigits = 1
    
    let number = NSNumber(floatLiteral: value)
    
    guard let stringValue = numberFormatter.string(from: number) else {
        return "N/A"
    }
    
    return stringValue + "°"
}

func formattedDate(_ date: Date) -> String {
    dateFormatter.dateFormat = "EEEE, MMMM d"
    return dateFormatter.string(from: date)
}

func timeFormattedDateTime(_ dateTime: Double) -> String {
    let date = Date(timeIntervalSince1970: dateTime)
    return timeFormattedDate(date)
}

func timeFormattedDate(_ date: Date) -> String {
    dateFormatter.dateFormat = "HH:mm"
    return dateFormatter.string(from: date)
}

// MARK: - Forecast Mapping

func groupWeatherByDay(_ weatherBundle: [Weather]) -> [Date: [Weather]] {
    return Dictionary(grouping: weatherBundle) { weather in
        let components = Calendar.current.dateComponents(
            [.day, .month, .year],
            from: Date(timeIntervalSince1970: weather.dateTime)
        )
        return Calendar.current.date(from: components) ?? .now
    }
}

func image(for weatherType: WeatherType) -> Image {
    switch weatherType {
    case .sunny:
        return .forecastSunny
    case .cloudy:
        return .forecastCloudy
    case .rainy:
        return .forecastRainy
    }
}

func color(for weatherType: WeatherType) -> Color {
    switch weatherType {
    case .sunny:
        return .forecastSunny
    case .cloudy:
        return .forecastCloudy
    case .rainy:
        return .forecastRainy
    }
}
