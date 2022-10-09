//
//  OpenWeatherServiceTests.swift
//  
//  Created by Mihai Petrenco on 09.10.2022.
//

import XCTest
@testable import WeatherService

final class OpenWeatherServiceTests: XCTestCase {
    
    // MARK: - Properties
    
    var sut: OpenWeatherService!
    var networkClient: MockNetworkClient!
    
    // MARK: - Test Setup
    
    override func setUp() {
        super.setUp()
        
        networkClient = MockNetworkClient()
        
        sut = OpenWeatherService(
            networkClient: networkClient,
            apiKey: "T3ST4P1K3Y"
        )
    }
    
    override func tearDown() {
        networkClient = nil
        sut = nil
        
        super.tearDown()
    }
    
    // MARK: - Test Cases
    
    /*
     *  GIVEN: The `fetchCurrentWeather` method is called
     *   THEN: The correct URL path should be constructed
     *    AND: The valid API key should be provided
     *    AND: The valid lat and long values should be set
     *    AND: The units should be set to metric by default
     *    AND: The URL must be passed to the network client
     */
    func test_OnFetchCurrentWeather_ConstructValidURL() async {
        
        let _ = await sut.fetchCurrentWeather(
            latitude: 20,
            longitude: 40
        )
        
        guard let urlString = networkClient.receivedURL else {
            XCTFail("URL either failed to construct or was not sent to the network client")
            return
        }
        
        let expectedComponents = constructTestComponents(for: "weather")
        
        XCTAssertEqual(urlString, expectedComponents?.url)
    }
       
    /*
     *  GIVEN: The `fetchForecast` method is called
     *   THEN: The correct URL path should be constructed
     *    AND: The valid API key should be provided
     *    AND: The valid lat and long values should be set
     *    AND: The units should be set to metric by default
     *    AND: The URL must be passed to the network client
     */
    func test_OnFetchWeatherForecast_ConstructValidURL() async {
        
        let _ = await sut.fetchForecast(
            latitude: 20,
            longitude: 40
        )
        
        guard let urlString = networkClient.receivedURL else {
            XCTFail("URL either failed to construct or was not sent to the network client")
            return
        }
        
        let expectedComponents = constructTestComponents(for: "forecast")
        
        XCTAssertEqual(urlString, expectedComponents?.url)
    }
    
    // MARK: - Helper Methods
    
    private func constructTestComponents(for endpoint: String) -> URLComponents? {
        var expectedComponents = URLComponents(
            string: "https://api.openweathermap.org/data/2.5/\(endpoint)"
        )
        
        expectedComponents?.queryItems = [
            URLQueryItem(name: "appid", value: "T3ST4P1K3Y"),
            URLQueryItem(name: "lat", value: "20.0"),
            URLQueryItem(name: "lon", value: "40.0"),
            URLQueryItem(name: "units", value: "metric"),
        ]
        
        return expectedComponents
    }
}
