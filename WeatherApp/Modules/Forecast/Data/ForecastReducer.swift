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
        return .task {
            let result = await environment.weatherService.fetchCurrentWeather(
                latitude: latitude,
                longitude: longitude
            )
            
            return .handleWeatherResponse(result)
        }
        
    case .handleWeatherResponse(.success(let response)):
        state.weather = response
        return .none
        
    case .handleWeatherResponse(.failure(let error)):
        // TODO: Handle error
        print(error)
        return .none
    }
}
