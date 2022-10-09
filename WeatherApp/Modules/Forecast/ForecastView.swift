//
//  ForecastView.swift
//  WeatherApp
//
//  Created by Mihai Petrenco on 10.10.2022.
//

import SwiftUI
import ComposableArchitecture

struct ForecastView: View {
    
    let store: ForecastStore
    
    var body: some View {
        
        WithViewStore(store, observe: { $0 }) { viewStore in
            
            ZStack {
                
                Color.weatherSunny
                    .ignoresSafeArea()
                
                VStack(spacing: 24.0) {
                    
                    Image.forecastSunny
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .edgesIgnoringSafeArea(.all)
                    
                    Color.weatherSunny
                }
                
            }
            
        }
    }
}
