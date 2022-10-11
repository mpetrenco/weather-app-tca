//
//  Weather.swift
//  WeatherApp
//
//  Created by Mihai Petrenco on 09.10.2022.
//

import Foundation

public enum WeatherType: String {
    case sunny = "Clear"
    case cloudy = "Clouds"
    case rainy = "Rain"
}

public struct Weather: Codable, Equatable {
    
    // MARK: - Properties
    
    public let dateTime: Double
    public let data: [WeatherData]
    public let temperature: Temperature
        
    // MARK: - Convenience Properties
    
    public var type: WeatherType {
        guard let name = data.first?.name else { return .sunny }
        return WeatherType(rawValue: name) ?? .sunny
    }
    
    // MARK: - CodingKeys
    
    enum CodingKeys: String, CodingKey {
        case dateTime = "dt"
        case data = "weather"
        case temperature = "main"
    }
}
