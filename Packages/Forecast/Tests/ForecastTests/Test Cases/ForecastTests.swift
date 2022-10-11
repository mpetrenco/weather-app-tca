import XCTest
import Combine
import ComposableArchitecture
import ComposableCoreLocation
import CoreLocation
import Networking
import WeatherService

@testable import Forecast

@MainActor
final class ForecastTests: XCTestCase {
    
    // MARK: - Properties
    
    var locationManagerSubject: PassthroughSubject<LocationManager.Action, Never>!
    var environment: ForecastEnvironment!
    var store: TestStore<ForecastState, ForecastAction, ForecastState, ForecastAction, ForecastEnvironment>!
    var sut: ForecastReducer!
    
    // MARK: - Test Setup
    
    override func setUp() {
        super.setUp()
        
        sut = forecastReducer
        
        locationManagerSubject = PassthroughSubject<LocationManager.Action, Never>()
        
        environment = ForecastEnvironment(
            weatherService: MockWeatherService(),
            locationManager: .failing
        )
        
        store = TestStore(
            initialState: ForecastState(),
            reducer: sut,
            environment: environment
        )
    }
    
    override func tearDown() {
        locationManagerSubject = nil
        environment = nil
        sut = nil
        store = nil
        
        super.tearDown()
    }
    
    // MARK: - Test Cases
    
    /*
     *  GIVEN: The `fetchUserLocation` action has been sent
     *   WHEN: The location authorization status is "Restricted"
     *   THEN: The state should be set with a "Permission Denied" error.
     */
    func test_OnRestrictedAuthorization_UpdateStateWithError() async {
        await expectLocationAuthorizationError(for: .restricted)
    }
    
    /*
     *  GIVEN: The `fetchUserLocation` action has been sent
     *   WHEN: The location authorization status is "Denied"
     *   THEN: The state should be set with a "Permission Denied" error.
     */
    func test_OnDeniedAuthorization_UpdateStateWithError() async {
        await expectLocationAuthorizationError(for: .denied)
    }
    
    /*
     *  GIVEN: The `fetchUserLocation` action has been sent
     *   WHEN: The location authorization status is "When In Use"
     *    AND: The weather service fails with a status code of 401
     *   THEN: The state should be set with a "401 Status Code" error.
     */
    func test_OnWhenInUseAuthorization_WhenWeatherServiceFailsWith401_UpdateStateWithError() async {
        await expectForecastResult(
            networkError: .fail(401),
            expectedError: .requestFailed(with: 401),
            for: .authorizedWhenInUse
        )
    }
    
    /*
     *  GIVEN: The `fetchUserLocation` action has been sent
     *   WHEN: The location authorization status is "Always"
     *    AND: The weather service fails with a status code of 401
     *   THEN: The state should be set with a "401 Status Code" error.
     */
    func test_OnAuthorizationAlways_WhenWeatherServiceFailsWith401_UpdateStateWithError() async {
        await expectForecastResult(
            networkError: .fail(401),
            expectedError: .requestFailed(with: 401),
            for: .authorizedAlways
        )
    }
    
    /*
     *  GIVEN: The `fetchUserLocation` action has been sent
     *   WHEN: The location authorization status is "When In Use"
     *    AND: The weather service fails with "Invalid Data"
     *   THEN: The state should be set with a "Something went wrong" error.
     */
    func test_OnWhenInUseAuthorization_WhenWeatherServiceFailsWithInvalidData_UpdateStateWithError() async {
        store.environment.weatherService = MockWeatherService(error: .invalidData)
        
        await expectForecastResult(
            networkError: .invalidData,
            expectedError: .networkError,
            for: .authorizedWhenInUse
        )
    }
    
    /*
     *  GIVEN: The `fetchUserLocation` action has been sent
     *   WHEN: The location authorization status is "Always"
     *    AND: The weather service fails with "Invalid Data"
     *   THEN: The state should be set with a "Something went wrong" error.
     */
    func test_OnAuthorizationAlways_WhenWeatherServiceFailsWithInvalidData_UpdateStateWithError() async {
        store.environment.weatherService = MockWeatherService(error: .invalidData)
        
        await expectForecastResult(
            networkError: .invalidData,
            expectedError: .networkError,
            for: .authorizedAlways
        )
    }
    
    /*
     *  GIVEN: The `fetchUserLocation` action has been sent
     *   WHEN: The location authorization status is "When In Use"
     *    AND: The weather service succeeds with data
     *   THEN: The state should be set with the correct weather and forecast
     */
    func test_OnAuthorizationWhenInUse_WhenWeatherServiceSucceeds_UpdateStateWithResult() async {
        await expectForecastResult(
            weather: mockWeather,
            forecast: mockForecast,
            for: .authorizedAlways
        )
    }
    
    /*
     *  GIVEN: The `fetchUserLocation` action has been sent
     *   WHEN: The location authorization status is "Not Determined"
     *    AND: The user denies the location permissions
     *   THEN: The state should be set with a "Permission Denied" error.
     */
    func test_OnNotDeterminedAuthorization_WhenPermissionsNotGranted_UpdateStateWithError() async {
        
        setupStore(
            authorizationStatus: .notDetermined,
            networkError: .fail(401)
        )
        
        let _ = await store.send(.fetchUserLocation) {
            $0.isLoading = true
        }
        
        await store.receive(.determineLocationAvailability)
        
        locationManagerSubject.send(.didChangeAuthorization(.denied))
        
        await store.receive(.locationManager(.didChangeAuthorization(.denied))) {
            $0.isLoading = false
            $0.error = .permissionDenied
        }
        
        locationManagerSubject.send(completion: .finished)
    }
    
    /*
     *  GIVEN: The `fetchUserLocation` action has been sent
     *   WHEN: The location authorization status is "Not Determined"
     *    AND: The user denies the location permissions
     *   THEN: The state should be set with a "Permission Denied" error.
     */
    func test_OnNotDeterminedAuthorization_WhenPermissionsGranted_FetchLocationAndWeatherData() async {

        setupStore(
            authorizationStatus: .notDetermined,
            networkError: .fail(401)
        )
        
        let _ = await store.send(.fetchUserLocation) {
            $0.isLoading = true
        }
        
        await store.receive(.determineLocationAvailability)
        
        locationManagerSubject.send(.didChangeAuthorization(.authorizedWhenInUse))
        
        await store.receive(.locationManager(.didChangeAuthorization(.authorizedWhenInUse)))
        
        await expectLocationUpdate()

        await expectNetworkResult(
            networkError: .fail(401),
            expectedError: .requestFailed(with: 401)
        )

        locationManagerSubject.send(completion: .finished)
    }
    
    // MARK: - Helper Methods
    
    private func setupStore(
        authorizationStatus: CLAuthorizationStatus = .denied,
        weather: Weather? = nil,
        forecast: Forecast? = nil,
        networkError: NetworkError? = nil,
        forecastError: ForecastError? = nil
    ) {
    
        store.environment.weatherService = MockWeatherService(
            weather: weather,
            forecast: forecast,
            error: networkError
        )
        
        store.environment.locationManager.delegate = { [unowned self] in
            self.locationManagerSubject.eraseToEffect()
        }

        store.environment.locationManager.authorizationStatus = {
            authorizationStatus
        }
        
        store.environment.locationManager.requestLocation = {
            .none
        }
        
        store.environment.locationManager.requestWhenInUseAuthorization = {
            .none
        }
        
        store.environment.locationManager.requestAlwaysAuthorization = {
            .none
        }
    }
    
    private func expectLocationAuthorizationError(
        for status: CLAuthorizationStatus
    ) async {
        
        setupStore(authorizationStatus: status)
        
        let _ = await store.send(.fetchUserLocation) {
            $0.isLoading = true
        }
        
        await store.receive(.determineLocationAvailability) {
            $0.isLoading = false
            $0.error = .permissionDenied
        }
        
        locationManagerSubject.send(completion: .finished)
    }
    
    private func expectLocationUpdate() async {
        let currentLocation = Location(
              altitude: 0,
              coordinate: CLLocationCoordinate2D(latitude: 10, longitude: 20),
              course: 0,
              horizontalAccuracy: 0,
              speed: 0,
              timestamp: Date(timeIntervalSince1970: 1_234_567_890),
              verticalAccuracy: 0
            )
        
        locationManagerSubject.send(.didUpdateLocations([currentLocation]))
        
        await store.receive(.locationManager(.didUpdateLocations([currentLocation]))) {
            $0.isLoading = true
            $0.error = nil
            $0.coordinates = CGPoint(x: 10, y: 20)
        }
    }
    
    private func expectNetworkResult(
        weather: Weather? = nil,
        forecast: Forecast? = nil,
        networkError: NetworkError? = nil,
        expectedError: ForecastError?
    ) async {
        await store.receive(.fetchWeather)
        await store.receive(.fetchForecast)
        
        if let error = networkError {
            
            await store.receive(.handleWeatherResponse(.failure(error))) {
                $0.isLoading = false
                $0.error = expectedError
                $0.weather = weather
                $0.forecast = forecast
            }

            await store.receive(.handleForecastResponse(.failure(error)))
            
        } else {
            
            await store.receive(.handleWeatherResponse(.success(weather!))) {
                $0.isLoading = false
                $0.error = expectedError
                $0.weather = weather
            }

            await store.receive(.handleForecastResponse(.success(forecast!))) {
                $0.isLoading = false
                $0.error = expectedError
                $0.forecast = forecast
            }
        }
    }
    
    private func expectForecastResult(
        weather: Weather? = nil,
        forecast: Forecast? = nil,
        networkError: NetworkError? = nil,
        expectedError: ForecastError? = nil,
        for authorizationStatus: CLAuthorizationStatus
    ) async {
        
        setupStore(
            authorizationStatus: .authorizedWhenInUse,
            weather: weather,
            forecast: forecast,
            networkError: networkError
        )
                
        let _ = await store.send(.fetchUserLocation) {
            $0.isLoading = true
        }
        
        await store.receive(.determineLocationAvailability)

        await expectLocationUpdate()

        await expectNetworkResult(
            weather: weather,
            forecast: forecast,
            networkError: networkError,
            expectedError: expectedError
        )
        
        locationManagerSubject.send(completion: .finished)
    }
}
