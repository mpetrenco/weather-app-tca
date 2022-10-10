//
//  ForecastItemView.swift
//  WeatherApp
//
//  Created by Mihai Petrenco on 10.10.2022.
//

import SwiftUI

struct ForecastItemView: View {
    
    // MARK: - Properties
    
    let dateTime: Double
    let temperature: Double
    
    // MARK: - UI Rendering
    
    var body: some View {
        
        HStack {
            
            Text(timeFormattedDateTime(dateTime))
                .foregroundColor(.appText)
                .font(.appBody)
            
            Spacer()
            
            Text(weatherFormattedValue(temperature))
                .foregroundColor(.appText)
                .font(.appBodyBold)
        }
    }
}
