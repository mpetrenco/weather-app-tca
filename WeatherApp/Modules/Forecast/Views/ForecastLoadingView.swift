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
        ProgressView()
            .progressViewStyle(CircularProgressViewStyle(tint: .appText))
    }
}
