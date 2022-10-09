//
//  WeatherData.swift
//  WeatherApp
//
//  Created by Mihai Petrenco on 09.10.2022.
//

import Foundation

public struct WeatherData: Codable, Equatable {
    
    // MARK: - Properties
    
    public let name: String
    
    // MARK: - Codable
    
    enum CodingKeys: String, CodingKey {
        case name = "main"
    }
}
