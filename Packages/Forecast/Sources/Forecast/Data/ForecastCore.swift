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

public struct ForecastState: Equatable {
    public var weather: Weather?
    public var forecast: Forecast?
    public var coordinates: CGPoint?
    public var networkErrorMessage: String?
    public var locationErrorMessage: String?
    public var isLoading = false
    
    public init() { }
}

// MARK: - Actions

public enum ForecastAction {
    case fetchUserLocation
    case determineLocationAvailability
    case fetchWeather
    case fetchForecast
    case handleWeatherResponse(Result<Weather, Error>)
    case handleForecastResponse(Result<Forecast, Error>)
    case locationManager(LocationManager.Action)
}

// MARK: - Environment

public struct ForecastEnvironment {
    public let weatherService: WeatherService
    public let locationManager: LocationManager
    
    public init(
        weatherService: WeatherService,
        locationManager: LocationManager
    ) {
        self.weatherService = weatherService
        self.locationManager = locationManager
    }
}

// MARK: - Reducer

public typealias ForecastReducer = Reducer<ForecastState, ForecastAction, ForecastEnvironment>

// MARK: - Store

public typealias ForecastStore = Store<ForecastState, ForecastAction>
