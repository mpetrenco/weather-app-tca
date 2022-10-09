//
//  Forecast.swift
//  WeatherApp
//
//  Created by Mihai Petrenco on 09.10.2022.
//

import Foundation

public struct Forecast: Codable, Equatable {
    
    // MARK: - Properties
    
    public var city: City
    public var weatherBundle: [Weather]

    // MARK: - Codable
    
    enum CodingKeys: String, CodingKey {
        case city
        case weatherBundle = "list"
    }
}
