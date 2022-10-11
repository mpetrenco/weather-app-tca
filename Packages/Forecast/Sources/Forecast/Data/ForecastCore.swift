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

// MARK: - Models

public struct ForecastError: Equatable {
    
    // MARK: - Type
    
    enum `Type`: Equatable {
        case location
        case network
    }
    
    // MARK: - Properties
    
    let type: `Type`
    let title: String
    let message: String
    
    // MARK: - Convenience Properties
    
    static let permissionDenied = ForecastError(
        type: .location,
        title: "Permissions denied!",
        message: "Please go to Settings to manually grant location permissions."
    )
    
    static let networkError = ForecastError(
        type: .location,
        title: "Something went wrong!",
        message: "Fetching weather forecasts failed."
    )
    
    static func requestFailed(with statusCode: Int) -> ForecastError {
        ForecastError(
            type: .network,
            title: "Request failed with \(statusCode)!",
            message: "Did you forget to set your API key?"
        )
    }
}

// MARK: - State

public struct ForecastState: Equatable {
    public var weather: Weather?
    public var forecast: Forecast?
    public var coordinates: CGPoint?
    public var error: ForecastError?
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

extension ForecastAction: Equatable {
    var value: String? {
        String(describing: self).components(separatedBy: "(").first
    }
    
    public static func == (lhs: ForecastAction, rhs: ForecastAction) -> Bool {
        lhs.value == rhs.value
    }
}

// MARK: - Environment

public struct ForecastEnvironment {
    public var weatherService: WeatherService
    public var locationManager: LocationManager
    
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
