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
                
                VStack(spacing: 24.0) {
                    
                    Image.forecastSunny
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .background(Color.red)
                    
                    if viewStore.isLoading {
                        ForecastLoadingView()
                    }
                    
                    if let weather = viewStore.weather {
                        ForecastContentView(weather: weather)
                    }
                    
                    if let errorMessage = viewStore.errorMessage {
                        ForecastErrorView(
                            message: errorMessage,
                            onRetryTap: {
                                viewStore.send(
                                    .fetchWeather(latitude: 20.0, longitude: 20.0)
                                )
                            }
                        )
                    }
                    
                    Spacer()
                }
            }
            .ignoresSafeArea()
            .onAppear {
                viewStore.send(
                    .fetchWeather(latitude: 20.0, longitude: 20.0)
                )
            }
        }
    }
}
