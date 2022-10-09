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
                
                VStack {
                    
                    Image.forecastSunny
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .background(Color.red)
                    
                    VStack {
                        
                        DailyForecastView(
                            minTemperature: 19,
                            currentTemperature: 20,
                            maxTemperature: 21
                        )
                        .padding(24.0)
                        
                        Divider()
                            .frame(height: 1)
                            .overlay(Color.appText)
                        
                        Spacer()
                    }
                    
                }
            }
            .ignoresSafeArea()
            .onAppear {
                viewStore.send(
                    .fetchWeather(
                        latitude: 20.0,
                        longitude: 20.0
                    )
                )
            }
        }
    }
}
