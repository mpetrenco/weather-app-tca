//
//  MockWeatherService.swift
//
//  Created by Mihai Petrenco on 11.10.2022.
//

import Foundation
import WeatherService
import Networking

struct MockWeatherService: WeatherService {
    
    // MARK: - Properties
    
    var error: NetworkError?
    var weather: Weather?
    var forecast: Forecast?
    
    // MARK: - Initializers
    
    init(weather: Weather? = nil,
         forecast: Forecast? = nil,
         error: NetworkError? = nil) {
        
        self.weather = weather
        self.forecast = forecast
        self.error = error
    }
    
    // MARK: - Protocol Methods
    
    func fetchCurrentWeather(
        latitude: Double,
        longitude: Double
    ) async -> Result<Weather, Error> {
        if let error = error {
            return .failure(error)
        }
        
        if let weather = weather {
            return .success(weather)
        }
        
        preconditionFailure()
    }
    
    func fetchForecast(
        latitude: Double,
        longitude: Double
    ) async -> Result<Forecast, Error> {
        if let error = error {
            return .failure(error)
        }
        
        if let forecast = forecast {
            return .success(forecast)
        }
        
        preconditionFailure()
    }
}
