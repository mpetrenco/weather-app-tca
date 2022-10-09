//
//  City.swift
//  WeatherApp
//
//  Created by Mihai Petrenco on 09.10.2022.
//

import Foundation

public struct City: Equatable, Codable {
    
    // MARK: - Parameters
    
    public let name: String
    public let country: String
    
    // MARK: - Initializers
    
    public init() {
        name = ""
        country = ""
    }
}
