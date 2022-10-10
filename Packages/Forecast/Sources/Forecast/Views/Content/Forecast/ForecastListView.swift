//
//  ForecastListView.swift
//  WeatherApp
//
//  Created by Mihai Petrenco on 10.10.2022.
//

import SwiftUI
import WeatherService

struct ForecastListView: View {
    
    // MARK: - Properties
    
    var weatherBundle: [Weather]
    
    // MARK: - UI Rendering
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            
            VStack(spacing: 24.0) {
                
                let groupedWeather = groupWeatherByDay(weatherBundle)
                
                ForEach(Array(groupedWeather.keys.sorted(by: <)), id: \.self) { date in
                    ForecastSectionView(
                        date: date,
                        weatherBundle: groupedWeather[date] ?? []
                    )
                    
                }
            }
        }
    }
}
