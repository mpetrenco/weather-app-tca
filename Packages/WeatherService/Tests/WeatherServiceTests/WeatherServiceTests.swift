import XCTest
@testable import WeatherService

final class WeatherServiceTests: XCTestCase {
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(WeatherService().text, "Hello, World!")
    }
}
