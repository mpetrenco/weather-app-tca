//
//  ForecastItemView.swift
//  WeatherApp
//
//  Created by Mihai Petrenco on 10.10.2022.
//

import SwiftUI
import WeatherService

struct ForecastItemView: View {
    
    // MARK: - Properties
    
    let weather: Weather
    
    // MARK: - UI Rendering
    
    var body: some View {
        
        HStack {
            
            Text(timeFormattedDateTime(weather.dateTime))
                .foregroundColor(.appText)
                .font(.appBody)
            
            Spacer()
            
            icon(for: weather.type)
            
            Text(weatherFormattedValue(weather.temperature.current))
                .foregroundColor(.appText)
                .font(.appBodyBold)
                .frame(width: 80.0, alignment: .trailing)
        }
    }
}
