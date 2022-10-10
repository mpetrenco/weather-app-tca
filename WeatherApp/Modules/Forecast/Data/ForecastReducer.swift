//
//  ForecastReducer.swift
//  WeatherApp
//
//  Created by Mihai Petrenco on 10.10.2022.
//

import Foundation
import Networking

// MARK: - Reducer

let forecastReducer = ForecastReducer { state, action, environment in
    
    state.isLoading = true
    state.networkErrorMessage = nil
    state.locationErrorMessage = nil
    
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
            state.locationErrorMessage = "Location permissions have not been granted. Please go to Settings and grant them manually."
            return .none
            
        case .authorizedAlways, .authorizedWhenInUse:
            return environment.locationManager
                .requestLocation()
                .fireAndForget()
            
        case .notDetermined:
            return environment.locationManager
                .requestWhenInUseAuthorization()
                .fireAndForget()
            
        default:
            state.isLoading = false
            state.locationErrorMessage = "Unknown location error"
            return .none
        }
        
    case .locationManager(.didChangeAuthorization(.authorizedAlways)),
            .locationManager(.didChangeAuthorization(.authorizedWhenInUse)):
        
        return environment.locationManager
            .requestLocation()
            .fireAndForget()
        
    case .locationManager(.didChangeAuthorization(.denied)),
            .locationManager(.didChangeAuthorization(.restricted)):
        
        state.isLoading = false
        state.locationErrorMessage = "Location permissions have not been granted. Please go to Settings and grant them manually."
        return .none
        
    case .locationManager(.didUpdateLocations(let locations)):
        guard let lastLocation = locations.last else { return .none }
        state.coordinates = CGPoint(
            x: lastLocation.coordinate.latitude,
            y: lastLocation.coordinate.longitude
        )
        
        return .task {
            return .fetchWeather
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
        
    case .handleWeatherResponse(.success(let response)):
        state.isLoading = false
        state.weather = response
        return .none
        
    case .handleWeatherResponse(.failure(let error)):
        
        if let networkError = error as? NetworkError {
            switch networkError {
            case .fail(let statusCode):
                state.networkErrorMessage = "Weather fetch failed with status \(statusCode)"
            default:
                state.networkErrorMessage = "Something went wrong!"
            }
        } else {
            state.networkErrorMessage = "Something went wrong!"
        }
        
        state.isLoading = false
        return .none
    }
}
