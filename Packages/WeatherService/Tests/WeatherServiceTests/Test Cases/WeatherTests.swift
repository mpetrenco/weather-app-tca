//
//  WeatherTests.swift
//
//  Created by Mihai Petrenco on 09.10.2022.
//

import XCTest
@testable import WeatherService

final class WeatherTests: XCTestCase {
    
    // MARK: - Test Cases
    
    /*
     *  GIVEN: A weather object is initialized
     *   WHEN: The weather data has a valid name
     *   THEN: Return the correct weather type
     */
    func test_OnValidWeatherDataName_ReturnCorrectType() {
        XCTAssertEqual(getWeather(named: "Clear").type, .sunny)
        XCTAssertEqual(getWeather(named: "Clouds").type, .cloudy)
        XCTAssertEqual(getWeather(named: "Rain").type, .rainy)
    }
    
    /*
     *  GIVEN: A weather object is initialized
     *   WHEN: The weather data has a valid name
     *   THEN: Return the correct weather type
     */
    func test_OnInvalidWeatherDataName_ReturnDefaultType() {
        XCTAssertEqual(getWeather(named: "Invalid").type, .sunny)
        XCTAssertEqual(getEmptyWeather().type, .sunny)
    }
    
    // MARK: - Helper Methods
    
    private func getWeather(named name: String) -> Weather {
        Weather(dateTime: 0,
                data: [WeatherData(name: name)],
                temperature: Temperature(current: 0, min: 0, max: 0))
    }
    
    private func getEmptyWeather() -> Weather {
        Weather(dateTime: 0,
                data: [],
                temperature: Temperature(current: 0, min: 0, max: 0))
    }
}
