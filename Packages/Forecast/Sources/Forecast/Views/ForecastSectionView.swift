//
//  ForecastSectionView.swift
//  WeatherApp
//
//  Created by Mihai Petrenco on 10.10.2022.
//

import SwiftUI
import WeatherService

struct ForecastSectionView: View {
    
    // MARK: - Properties
    
    let date: Date
    let weatherBundle: [Weather]
    
    // MARK: - UI Rendering
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 16.0) {
            
            Text(formattedDate(date))
                .font(.appBodyBold)
                .foregroundColor(.appText)
            
            ForEach(weatherBundle, id: \.dateTime) { weather in
                ForecastItemView(dateTime: weather.dateTime,
                                 temperature: weather.temperature.current)
            }
        }
    }
}
