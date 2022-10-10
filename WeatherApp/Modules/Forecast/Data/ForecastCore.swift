//
//  ForecastCore.swift
//  WeatherApp
//
//  Created by Mihai Petrenco on 10.10.2022.
//

import SwiftUI
import ComposableArchitecture
import ComposableCoreLocation
import WeatherService

// MARK: - State

struct ForecastState: Equatable {
    var weather: Weather?
    var coordinates: CGPoint?
    var networkErrorMessage: String?
    var locationErrorMessage: String?
    var isLoading = false
}

// MARK: - Actions

enum ForecastAction {
    case fetchUserLocation
    case determineLocationAvailability
    case fetchWeather
    case handleWeatherResponse(Result<Weather, Error>)
    case locationManager(LocationManager.Action)
}

// MARK: - Environment

struct ForecastEnvironment {
    let weatherService: WeatherService
    let locationManager: LocationManager
}

// MARK: - Reducer

typealias ForecastReducer = Reducer<ForecastState, ForecastAction, ForecastEnvironment>

// MARK: - Store

typealias ForecastStore = Store<ForecastState, ForecastAction>
