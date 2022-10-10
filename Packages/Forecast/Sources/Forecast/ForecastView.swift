//
//  ForecastView.swift
//  WeatherApp
//
//  Created by Mihai Petrenco on 10.10.2022.
//

import SwiftUI
import ComposableArchitecture

public struct ForecastView: View {
    
    // MARK: - Propeties
    
    public let store: ForecastStore
    
    // MARK: - Initializers
    
    public init(store: ForecastStore) {
        self.store = store
    }
    
    // MARK: - UI Rendering
    
    public var body: some View {
        
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
                    
                    if let error = viewStore.error, error.type == .location {
                        ForecastErrorView(
                            title: error.title,
                            message: error.message,
                            onRetryTap: { viewStore.send(.fetchUserLocation) }
                        )
                        .padding(24.0)
                    }
                    
                    if let error = viewStore.error, error.type == .network {
                        ForecastErrorView(
                            title: error.title,
                            message: error.message,
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
