//
//  ForecastData.swift
//  WeatherApp
//
//  Created by Mihai Petrenco on 10.10.2022.
//

import SwiftUI
import ComposableArchitecture
import WeatherService

// MARK: - State

struct ForecastState: Equatable {
    var weather: Weather?
    var errorMessage: String?
    var isLoading = false
}

// MARK: - Actions

enum ForecastAction {
    case fetchWeather(latitude: Double, longitude: Double)
    case handleWeatherResponse(Result<Weather, Error>)
}

// MARK: - Environment

struct ForecastEnvironment {
    let weatherService: WeatherService
}

// MARK: - Reducer

typealias ForecastReducer = Reducer<ForecastState, ForecastAction, ForecastEnvironment>

// MARK: - Store

typealias ForecastStore = Store<ForecastState, ForecastAction>
