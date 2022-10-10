//
//  ForecastReducer.swift
//  WeatherApp
//
//  Created by Mihai Petrenco on 10.10.2022.
//

import Foundation
import Networking

// MARK: - Reducer

public let forecastReducer = ForecastReducer { state, action, environment in
    
    state.isLoading = true
    state.error = nil
    
    switch action {
        
    case .fetchUserLocation:
        return .merge(
            environment
                .locationManager
                .delegate()
                .map(ForecastAction.locationManager),
            
                .task {
                    .determineLocationAvailability
                }
        )
        
    case .determineLocationAvailability:
        switch environment.locationManager.authorizationStatus() {
        case .restricted, .denied:
            state.isLoading = false
            state.error = ForecastError.permissionDenied
            return .none
            
        case .authorizedAlways, .authorizedWhenInUse:
            return environment.locationManager
                .requestLocation()
                .fireAndForget()
            
        case .notDetermined:
            return environment.locationManager
                .requestWhenInUseAuthorization()
                .fireAndForget()
        @unknown default:
            preconditionFailure("Unknown location authorization status.")
        }
        
    case .locationManager(.didChangeAuthorization(.authorizedAlways)),
            .locationManager(.didChangeAuthorization(.authorizedWhenInUse)):
        
        return environment.locationManager
            .requestLocation()
            .fireAndForget()
        
    case .locationManager(.didChangeAuthorization(.denied)),
            .locationManager(.didChangeAuthorization(.restricted)):
        
        state.isLoading = false
        state.error = ForecastError.permissionDenied
        return .none
        
    case .locationManager(.didUpdateLocations(let locations)):
        guard let lastLocation = locations.last else { return .none }
        state.coordinates = CGPoint(
            x: lastLocation.coordinate.latitude,
            y: lastLocation.coordinate.longitude
        )
        
        return .run { send in
            await send(.fetchWeather)
            await send(.fetchForecast)
        }
        
    case .locationManager:
        return .none
        
    case .fetchWeather:
        guard let coordinates = state.coordinates else { return .none }
        
        return .task {
            let result = await environment.weatherService.fetchCurrentWeather(
                latitude: coordinates.x,
                longitude: coordinates.y
            )
            
            return .handleWeatherResponse(result)
        }
        
    case .fetchForecast:
        guard let coordinates = state.coordinates else { return .none }
        
        return .task {
            let result = await environment.weatherService.fetchForecast(
                latitude: coordinates.x,
                longitude: coordinates.y
            )
            
            return .handleForecastResponse(result)
        }
        
    case .handleWeatherResponse(.success(let response)):
        state.isLoading = false
        state.weather = response
        return .none
        
    case .handleWeatherResponse(.failure(let error)):
        updateState(&state, with: error)
        state.isLoading = false
        return .none
        
    case .handleForecastResponse(.success(let response)):
        state.isLoading = false
        state.forecast = response
        return .none

    case .handleForecastResponse(.failure(let error)):
        updateState(&state, with: error)
        state.isLoading = false
        return .none
    }
}

private func updateState(_ state: inout ForecastState, with error: Error) {
    if let networkError = error as? NetworkError {
        switch networkError {
        case .fail(let statusCode):
            state.error = ForecastError.requestFailed(with: statusCode)
        default:
            state.error = ForecastError.networkError
        }
    } else {
        state.error = ForecastError.networkError
    }
}
