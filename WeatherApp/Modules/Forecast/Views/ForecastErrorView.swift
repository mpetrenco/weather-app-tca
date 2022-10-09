//
//  ForecastErrorView.swift
//  WeatherApp
//
//  Created by Mihai Petrenco on 10.10.2022.
//

import SwiftUI
import WeatherService

struct ForecastErrorView: View {
    
    // MARK: - Property
    
    let message: String
    let onRetryTap: () -> Void
    
    // MARK: - UI Rendering
    
    var body: some View {
        
        VStack(spacing: 16.0) {
                    
            Text(message)
                .foregroundColor(.appText)
                .font(.appBody)
            
            Button(action: onRetryTap) {
                Text("Retry?")
                    .foregroundColor(.appText)
                    .font(.appBodyBold)
            }
        }
    }
}
