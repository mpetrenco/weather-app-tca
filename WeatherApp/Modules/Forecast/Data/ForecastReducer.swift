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
    state.weather = nil
    state.errorMessage = nil
    
    switch action {

    case let .fetchWeather(latitude, longitude):
        return .task {
            let result = await environment.weatherService.fetchCurrentWeather(
                latitude: latitude,
                longitude: longitude
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
                state.errorMessage = "Weather fetch failed with status \(statusCode)"
            default:
                state.errorMessage = "Something went wrong!"
            }
        } else {
            state.errorMessage = "Something went wrong!"
        }
        
        state.isLoading = false
        return .none
    }
}
