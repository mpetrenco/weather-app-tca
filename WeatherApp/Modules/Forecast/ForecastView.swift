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
                    
                    if let forecast = viewStore.forecast {
                        ForecastListView(weatherBundle: forecast.weatherBundle)
                            .padding(.horizontal, 24.0)
                    }
                    
                    if let errorMessage = viewStore.locationErrorMessage {
                        ForecastErrorView(message: errorMessage)
                            .padding(24.0)
                    }
                    
                    if let errorMessage = viewStore.networkErrorMessage {
                        ForecastErrorView(
                            message: errorMessage,
                            onRetryTap: { viewStore.send(.fetchWeather) }
                        )
                        .padding(24.0)
                    }
                    
                    Spacer()
                }
            }
            .ignoresSafeArea()
            .onAppear {
                viewStore.send(.fetchUserLocation)
            }
        }
    }
}
