import XCTest
@testable import WeatherService
@testable import Forecast

@MainActor
final class ForecastUtilsTests: XCTestCase {
    
    // MARK: - Properties
    
    private var timeFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter
    }
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }
    
    // MARK: - Test Cases
    
    /*
     *  GIVEN: The `weatherFormattedValue` method is called
     *   THEN: The returned value must be a valid weather format
     */
    func test_OnWeatherFormatting_ReturnValidValue() {
        XCTAssertEqual(weatherFormattedValue(20), "20°")
        XCTAssertEqual(weatherFormattedValue(0), "0°")
        XCTAssertEqual(weatherFormattedValue(-0), "0°")
        XCTAssertEqual(weatherFormattedValue(0.14), "0°")
        XCTAssertEqual(weatherFormattedValue(-24.14), "-24°")
    }
    
    /*
     *  GIVEN: The `formattedDate` method is called
     *   THEN: The returned value must be a valid [EEEE, MMMM d] format
     */
    func test_OnFormattedDate_ReturnCorrectFormat() {
        let date = Date(timeIntervalSince1970: 0)
        XCTAssertEqual("Thursday, January 1", formattedDate(date))
    }
    
    /*
     *  GIVEN: The `timeFormattedDate` method is called
     *   THEN: The returned value must be a valid [HH:mm] format
     *    AND: Display the date at the correct timezone
     */
    func test_OnTimeFormattedDate_ReturnCorrectFormat() {
        let date = Date(timeIntervalSince1970: 41400)
        let expectedFormat = timeFormatter.string(from: date)
        
        XCTAssertEqual(expectedFormat, timeFormattedDate(date))
    }
    
    /*
     *  GIVEN: The `timeFormattedDateTime` method is called
     *   THEN: The returned value must be a valid [HH:mm] format
     *    AND: Display the date at the correct timezone
     */
    func test_OnTimeFormattedDateTime_ReturnCorrectFormat() {
        let date = Date(timeIntervalSince1970: 41400)
        let expectedFormat = timeFormatter.string(from: date)
        
        XCTAssertEqual(expectedFormat, timeFormattedDateTime(41400))
    }
    
    /*
     *  GIVEN: The `groupWeatherByDay` method is called
     *   THEN: The returned dictionary should correctly group the Weather elements
     */
    func test_OnGroupWeatherByDay_ReturnCorrectStructure() {
                
        let groupedWeather = groupWeatherByDay([
            getWeather(at: 0),     // 1970-01-01 at 00:00 GMT+0
            getWeather(at: 3600),  // 1970-01-01 at 01:00 GMT+0
            getWeather(at: 7200),  // 1970-01-01 at 02:00 GMT+0
            getWeather(at: 86400), // 1970-01-02 at 00:00 GMT+0
            getWeather(at: 90000), // 1970-01-02 at 01:00 GMT+0
        ])
        
        XCTAssertEqual(groupedWeather.keys.count, 2)
        
        let firstDate = dateFormatter.date(from: "1970-01-01")!
        XCTAssertEqual(groupedWeather[firstDate]?.count, 3)
        
        let secondDate = dateFormatter.date(from: "1970-01-02")!
        XCTAssertEqual(groupedWeather[secondDate]?.count, 2)
    }
    
    /*
     *  GIVEN: The `backgroundImage(for:)` method is called with a weather type
     *   THEN: The correct image asset should be returned
     */
    func test_OnGetImageByWeatherType_ReturnCorrectImage() {
        XCTAssertEqual(backgroundImage(for: .sunny), .forecastSunny)
        XCTAssertEqual(backgroundImage(for: .rainy), .forecastRainy)
        XCTAssertEqual(backgroundImage(for: .cloudy), .forecastCloudy)
    }
    
    /*
     *  GIVEN: The `icon(for:)` method is called with a weather type
     *   THEN: The correct icon should be returned
     */
    func test_OnGetIconByWeatherType_ReturnCorrectIcon() {
        XCTAssertEqual(icon(for: .sunny), .iconSunny)
        XCTAssertEqual(icon(for: .rainy), .iconRainy)
        XCTAssertEqual(icon(for: .cloudy), .iconCloudy)
    }
    
    /*
     *  GIVEN: The `color(for:)` method is called with a weather type
     *   THEN: The correct color should be returned
     */
    func test_OnGetColorByWeatherType_ReturnCorrectColor() {
        XCTAssertEqual(color(for: .sunny), .forecastSunny)
        XCTAssertEqual(color(for: .rainy), .forecastRainy)
        XCTAssertEqual(color(for: .cloudy), .forecastCloudy)
    }
    
    // MARK: - Helper Methods
    
    private func getWeather(at dateTime: Double) -> Weather {
        Weather(
            dateTime: dateTime,
            data: [],
            temperature: Temperature(current: 0, min: 0, max: 0)
        )
    }
}
