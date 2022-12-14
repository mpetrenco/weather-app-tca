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

private let dateFormatter = DateFormatter()

// MARK: - Formatting Methods

func weatherFormattedValue(_ value: Double) -> String {
    return "\(Int(value))°"
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

func backgroundImage(for weatherType: WeatherType) -> Image {
    switch weatherType {
    case .sunny:
        return .forecastSunny
    case .cloudy:
        return .forecastCloudy
    case .rainy:
        return .forecastRainy
    }
}

func icon(for weatherType: WeatherType) -> Image {
    switch weatherType {
    case .sunny:
        return .iconSunny
    case .cloudy:
        return .iconCloudy
    case .rainy:
        return .iconRainy
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
