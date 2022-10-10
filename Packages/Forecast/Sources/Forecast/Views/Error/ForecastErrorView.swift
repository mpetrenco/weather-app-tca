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
    
    let title: String
    let message: String
    var onRetryTap: () -> Void
    
    // MARK: - UI Rendering
    
    var body: some View {
        
        VStack(spacing: 24.0) {
    
            Text(title)
                .foregroundColor(.appText)
                .multilineTextAlignment(.center)
                .font(.appBodyBold)
            
            Text(message)
                .foregroundColor(.appText)
                .multilineTextAlignment(.center)
                .font(.appBody)
            
            Spacer()
            
            Button(action: onRetryTap) {
                Text("Retry?")
                    .foregroundColor(.appText)
                    .font(.appBodyBold)
                    .frame(height: 60.0)
                    .frame(maxWidth: .infinity)
                    .background(Color.appAccent)
                    .cornerRadius(8.0)
                    .padding(.horizontal, 24.0)
            }
        }
    }
}
