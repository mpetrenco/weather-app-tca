//
//  Temperature.swift
//  WeatherApp
//
//  Created by Mihai Petrenco on 09.10.2022.
//

import Foundation

public struct Temperature: Codable, Equatable {
    
    // MARK: - Properties
    
    public let current: Double
    public let min: Double
    public let max: Double
    
    // MARK: - Codable
    
    enum CodingKeys: String, CodingKey {
        case current = "temp"
        case min = "temp_min"
        case max = "temp_max"
    }
}
