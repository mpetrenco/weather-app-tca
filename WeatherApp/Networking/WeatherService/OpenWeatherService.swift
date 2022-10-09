//
//  OpenWeatherService.swift
//  WeatherApp
//
//  Created by Mihai Petrenco on 09.10.2022.
//

import Foundation

enum URLRequestError: Error {
    case unknown
}

struct OpenWeatherService: WeatherService {
    
    func fetchCurrentWeather(
        latitude: Double,
        longitude: Double
    ) async -> Result<Weather, Error> {
        
        // TODO: Implement method
        return .failure(URLRequestError.unknown)
    }
    
    func fetchForecast(
        latitude: Double,
        longitude: Double
    ) async -> Result<Forecast, Error> {
        
        // TODO: Implement method
        return .failure(URLRequestError.unknown)
    }
    
}
