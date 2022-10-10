//
//  ForecastHeaderView.swift
//
//  Created by Mihai Petrenco on 10.10.2022.
//

import SwiftUI

struct ForecastHeaderView: View {
    
    // MARK: - Properties
    
    let state: ForecastState
    
    // MARK: - UI Rendering
    
    var body: some View {
        
        ZStack {
            
            backgroundImage(for: state.weather?.type ?? .sunny)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .background(Color.red)
            
            if let name = state.forecast?.city.name {
                Text(name)
                    .foregroundColor(.appText)
                    .font(.appTitle)
            }
        }
    }
}
