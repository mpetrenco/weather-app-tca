//
//  ForecastStubs.swift
//
//  Created by Mihai Petrenco on 11.10.2022.
//

import Foundation
import WeatherService

// MARK: - Weather Mock

var weatherJSON: [String: Any] {
    [
        "dt": 123456,
        "weather": [],
        "main": [
            "temp": 0,
            "temp_min": 0,
            "temp_max": 0
        ],
    ]
}

var mockWeather: Weather {
    let weatherData = try! JSONSerialization.data(withJSONObject: weatherJSON)
    return try! JSONDecoder().decode(Weather.self, from: weatherData)
}

// MARK: - Forecast Mock

var forecastJSON: [String: Any] {
    [
        "city": [
            "name": "Hello",
            "country": "World"
        ],
        "list": [
            weatherJSON,
            weatherJSON,
            weatherJSON
        ]
    ]
}

var mockForecast: Forecast {
    let forecastData = try! JSONSerialization.data(withJSONObject: forecastJSON)
    return try! JSONDecoder().decode(Forecast.self, from: forecastData)
}

