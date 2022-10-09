//
//  ForecastData.swift
//  WeatherApp
//
//  Created by Mihai Petrenco on 10.10.2022.
//

import SwiftUI
import ComposableArchitecture
import WeatherService

// MARK: - State

struct ForecastState: Equatable {}

// MARK: - Actions

enum ForecastAction {}

// MARK: - Environment

struct ForecastEnvironment {
    let weatherService: WeatherService
}

// MARK: - Reducer

typealias ForecastReducer = Reducer<ForecastState, ForecastAction, ForecastEnvironment>

// MARK: - Store

typealias ForecastStore = Store<ForecastState, ForecastAction>
