//
//  WeatherAppApp.swift
//  WeatherApp
//
//  Created by Mihai Petrenco on 09.10.2022.
//

import SwiftUI
import Forecast
import WeatherService
import Networking

@main
struct WeatherAppApp: App {
    
    let store = ForecastStore(
        initialState: ForecastState(),
        reducer: forecastReducer,
        environment: ForecastEnvironment(
            weatherService: OpenWeatherService(
                networkClient: DefaultNetworkClient(),
                apiKey: "<#YOUR_API_KEY#>"
            ),
            locationManager: .live
        )
    )
    
    var body: some Scene {
        WindowGroup {
            ForecastView(store: store)
        }
    }
}
