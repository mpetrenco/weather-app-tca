//
//  ForecastLoadingView.swift
//  WeatherApp
//
//  Created by Mihai Petrenco on 10.10.2022.
//

import SwiftUI

struct ForecastLoadingView: View {
    
    // MARK: - UI Rendering
    
    var body: some View {
        
        VStack() {

            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: .appText))
                .padding(.top, 64.0)
            
            Spacer()
        }
    }
}
