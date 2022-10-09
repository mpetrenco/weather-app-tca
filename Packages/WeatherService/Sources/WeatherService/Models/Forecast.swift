//
//  Forecast.swift
//  WeatherApp
//
//  Created by Mihai Petrenco on 09.10.2022.
//

import Foundation

public struct Forecast: Codable, Equatable {
    public let city: City
    public let weatherBundle: [Weather]
    
    public init() {
        city = City()
        weatherBundle = []
    }
    
    // MARK: - Codable
    
    enum CodingKeys: String, CodingKey {
        case city
        case weatherBundle = "list"
    }
}
