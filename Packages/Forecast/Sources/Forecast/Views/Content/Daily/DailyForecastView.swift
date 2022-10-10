//
//  DailyForecastView.swift
//  WeatherApp
//
//  Created by Mihai Petrenco on 10.10.2022.
//

import SwiftUI
import Resources

struct DailyForecastView: View {
    
    // MARK: - Properties
    
    let minTemperature: Double
    let currentTemperature: Double
    let maxTemperature: Double
    
    // MARK: - UI Rendering
    
    var body: some View {
        HStack {
            
            VStack {
                Text(weatherFormattedValue(minTemperature))
                    .foregroundColor(.appText)
                    .font(.appBodyBold)
                
                Text("min")
                    .foregroundColor(.appText)
                    .font(.appBody)
            }
            
            Spacer()
            
            VStack {
                Text(weatherFormattedValue(currentTemperature))
                    .foregroundColor(.appText)
                    .font(.appBodyBold)
                
                Text("Current")
                    .foregroundColor(.appText)
                    .font(.appBody)
            }
            
            Spacer()
            
            VStack {
                Text(weatherFormattedValue(maxTemperature))
                    .foregroundColor(.appText)
                    .font(.appBodyBold)
                
                Text("max")
                    .foregroundColor(.appText)
                    .font(.appBody)
            }
            
        }
    }
}
