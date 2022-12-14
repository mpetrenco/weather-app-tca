//
//  ForecastContentView.swift
//  WeatherApp
//
//  Created by Mihai Petrenco on 10.10.2022.
//

import SwiftUI
import WeatherService

struct ForecastContentView: View {
    
    // MARK: - Property
    
    let weather: Weather
    
    // MARK: - UI Rendering
    
    var body: some View {
        
        VStack(spacing: 24.0) {
            
            DailyForecastView(
                minTemperature: weather.temperature.min,
                currentTemperature: weather.temperature.current,
                maxTemperature: weather.temperature.max
            )
            .padding(.horizontal, 24.0)
            
            Divider()
                .frame(height: 1)
                .overlay(Color.appText)
        }
    }
}
