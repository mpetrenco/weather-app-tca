//
//  WeatherService.swift
//  WeatherApp
//
//  Created by Mihai Petrenco on 09.10.2022.
//

import Foundation

public protocol WeatherService {
        
    func fetchCurrentWeather(
        latitude: Double,
        longitude: Double
    ) async -> Result<Weather, Error>
    
    func fetchForecast(
        latitude: Double,
        longitude: Double
    ) async -> Result<Forecast, Error>

}
