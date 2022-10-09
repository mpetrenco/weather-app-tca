//
//  OpenWeatherService.swift
//  WeatherApp
//
//  Created by Mihai Petrenco on 09.10.2022.
//

import Foundation

private enum OpenWeatherEndpoint: String {
    case currentWeather = "weather"
    case forecast = "forecast"
}

public struct OpenWeatherService: WeatherService {
    
    // MARK: - Properties
    
    private let apiKey: String
    
    // MARK: - Initializers
    
    public init(with apiKey: String) {
        self.apiKey = apiKey
    }
    
    // MARK: - Protocol Methods
    
    public func fetchCurrentWeather(
        latitude: Double,
        longitude: Double
    ) async -> Result<Weather, Error> {
        
        await request(
            endpoint: .currentWeather,
            latitude: latitude,
            longitude: longitude,
            expecting: Weather.self
        )
    }
    
    public func fetchForecast(
        latitude: Double,
        longitude: Double
    ) async -> Result<Forecast, Error> {
        
        await request(
            endpoint: .forecast,
            latitude: latitude,
            longitude: longitude,
            expecting: Forecast.self
        )
    }
    
    // MARK: - Helper Methods
    
    private func request<T: Codable>(
        endpoint: OpenWeatherEndpoint,
        latitude: Double,
        longitude: Double,
        expecting type: T.Type
    ) async -> Result<T, Error> {
        
        var components = URLComponents(
            string: "https://api.openweathermap.org/data/2.5/\(endpoint.rawValue)"
        )
        
        components?.queryItems = [
            URLQueryItem(name: "appid", value: apiKey),
            URLQueryItem(name: "lat", value: "\(latitude)"),
            URLQueryItem(name: "lon", value: "\(longitude)"),
            URLQueryItem(name: "units", value: "metric"),
        ]
        
        return await URLSession.shared.request(
            url: components?.url,
            expecting: type.self
        )
    }
}

