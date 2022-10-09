# WeatherService

Contains the networking code needed to perform a HTTP request to the `OpenWeather API`.

## Details:

- **Minimum target:** iOS 15
- **Current coverage:** 100%

## Dependencies:

- `Networking` - contains the `NetworkClient` protocol which is called by the service;

## Usage:

The `WeatherService` package exposes the `WeatherService` protocol and associated models, as well as the `OpenWeatherService` implementation, which connects to the _OpenWeather API_ to fetch actual weather data.

The `WeatherService` protocol is defined as such:

```swift
func fetchCurrentWeather(
    latitude: Double,
    longitude: Double
) async -> Result<Weather, Error>

func fetchForecast(
    latitude: Double,
    longitude: Double
) async -> Result<Forecast, Error>
```
