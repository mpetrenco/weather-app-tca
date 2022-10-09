//
//  ForecastReducer.swift
//  WeatherApp
//
//  Created by Mihai Petrenco on 10.10.2022.
//

import Foundation

// MARK: - Reducer

let forecastReducer = ForecastReducer { state, action, environment in
    switch action {
    case let .fetchWeather(latitude, longitude):
        print("Called")
        return .none
    }
}
