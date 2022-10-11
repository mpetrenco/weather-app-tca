# Forecast

A package which contains the Forecast module of the app.

## Details:

- **Minimum target:** iOS 15
- **Current coverage:** 98.64%

## Usage:

The package provides the `ForecastView`, as well as the related `ForecastState`, `ForecastAction`, `ForecastEnvironment` and `forecastReducer` implementation, so that you can plug it in your own modules/apps.

The `ForecastState` is defined as such:

```swift
struct ForecastState: Equatable {

    /**
     * Describes the current weather forecast.
     * If set, will display today's weather information.
     */
    var weather: Weather?

    /**
     * Describes the next 5-day forecast in 3 hour intervals.
     * If set, will display a sectioned list of forecast items.
     */
    var forecast: Forecast?

    /**
     * The user coordinates fetched from CoreLocation.
     * Used as parameters for the `WeatherService` calls.
     */
    var coordinates: CGPoint?

    /**
     * Describes potential network errors.
     * If set, will display the message on screen with a "Retry" button.
     */
    var networkErrorMessage: String?

    /**
     * Describes potential location permission errors.
     * If set, will display the message on screen.
     */
    var locationErrorMessage: String?

    /**
     * Describes the loading state of the view.
     * If set, will display a loading spinner on screen.
     */
    var isLoading = false
}
```

The `ForecastAction` is defined as such:

```swift
enum ForecastAction {

    /**
     * Called on view appear.
     * Connects the `LocationManager` and triggers `determineLocationAvailability`
     */
    case fetchUserLocation

    /**
     * Checks current location authorization status and reacts accordingly.
     * If location permission is granted, will trigger a user location fetch.
     * If location permission is unknown, will trigger a permission request.
     * If location permission is denied, will display a location error message.
     */
    case determineLocationAvailability

    /**
     * Fetches the current weather from the `WeatherService`.
     * Calls `handleWeatherResponse` with the result afterwards.
     */
    case fetchWeather

    /**
     * Fetches the 5-day forecast from the `WeatherService`.
     * Calls `handleForecastResponse` with the result afterwards.
     */
    case fetchForecast

    /**
     * Handles the response or error of the `fetchWeather` request.
     * Sets the correct state, which updates the UI accordingly.
     */
    case handleWeatherResponse(Result<Weather, Error>)

    /**
     * Handles the response or error of the `fetchForecast` request.
     * Sets the correct state, which updates the UI accordingly.
     */
    case handleForecastResponse(Result<Forecast, Error>)

    /**
     * Contains all `LocationManager` actions provided by the `ComposableCoreLocation` package.
     * Handles all location-related actions.
     */
    case locationManager(LocationManager.Action)
}
```

The `ForecastEnvironment` is defined as such:

```swift
struct ForecastEnvironment {

    /**
     * The weather service protocol used to fetch the weather forecast.
     */
    let weatherService: WeatherService

    /**
     * The wrapper around `CLLocationManager`, provided by the `ComposableCoreLocation` package.
     */
    let locationManager: LocationManager
}
```
