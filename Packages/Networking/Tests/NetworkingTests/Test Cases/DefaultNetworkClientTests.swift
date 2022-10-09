//
//  DefaultNetworkClientTests.swift
//
//  Created by Mihai Petrenco on 09.10.2022.
//

import XCTest
@testable import Networking

class DefaultNetworkClientTests: XCTestCase {
    
    // MARK: - Properties
    
    var sut: DefaultNetworkClient!
    
    // MARK: - Test Setup
    
    override func setUp() {
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [MockURLProtocol.self]
        
        let urlSession = URLSession(configuration: configuration)
        sut = DefaultNetworkClient(urlSession: urlSession)
    }
    
    override func tearDown() {
        sut = nil
    }
    
    // MARK: - Test Cases
    
    /*
     *  GIVEN: The `get` method of the DefaultNetworkClient is called
     *   WHEN: The passed URL is `nil`
     *   THEN: The response should be a failure of type `NetworkError.invalidURL`
     */
    func test_OnInvalidURL_FailWithCorrectError() async {
        
        MockURLProtocol.requestHandler = getHandler(
            statusCode: 200,
            jsonString: "{\"message\": \"Success\"}"
        )
        
        let result = await sut.get(
            url: nil,
            expecting: [String: String].self
        )
                
        switch result {
        case .success:
            XCTFail("Should not succeed when the URL is nil.")
        case .failure(let error):
            XCTAssertEqual((error as? NetworkError), NetworkError.invalidURL)
        }
    }
        
    /*
     *  GIVEN: The `get` method of the DefaultNetworkClient is called
     *   WHEN: The HTTP response has a status code different than 200
     *   THEN: The response should be a failure of type `NetworkError.fail(statusCode)`
     */
    func test_OnNon200Response_FailWithCorrectError() async {
        
        MockURLProtocol.requestHandler = getHandler(
            statusCode: 400,
            jsonString: "{\"message\": \"Success\"}"
        )
        
        let result = await sut.get(
            url: URL(string: "https://example.com"),
            expecting: [String: String].self
        )
                
        switch result {
        case .success:
            XCTFail("Should not succeed when the response is not 200.")
        case .failure(let error):
            XCTAssertEqual((error as? NetworkError), NetworkError.fail(400))
        }
    }
    
    /*
     *  GIVEN: The `get` method of the DefaultNetworkClient is called
     *   WHEN: The response is not a HTTPURLResponse for some reason
     *   THEN: The response should be a failure of type `NetworkError.invalidResponse`
     */
    func test_OnNoHTTPResponse_FailWithCorrectError() async {
        
        MockURLProtocol.requestHandler = getHandler(
            statusCode: 200,
            jsonString: "{\"message\": \"Success\"}",
            isHTTPResponse: false
        )
        
        let result = await sut.get(
            url: URL(string: "https://example.com"),
            expecting: [String: String].self
        )
                
        switch result {
        case .success:
            XCTFail("Should not succeed when the response is not an HTTP response.")
        case .failure(let error):
            XCTAssertEqual((error as? NetworkError), NetworkError.invalidResponse)
        }
    }
    
    /*
     *  GIVEN: The `get` method of the DefaultNetworkClient is called
     *   WHEN: The returned data could not be parsed correctly
     *   THEN: The response should be a failure of type `DecodingError`
     */
    func test_OnInvalidJSON_FailWithCorrectError() async {
        
        MockURLProtocol.requestHandler = getHandler(
            statusCode: 200,
            jsonString: ""
        )
        
        let result = await sut.get(
            url: URL(string: "https://example.com"),
            expecting: [String: String].self
        )
                
        switch result {
        case .success:
            XCTFail("Should not succeed when the JSON data could not be parsed.")
        case .failure(let error):
            XCTAssertTrue(error is DecodingError)
        }
    }
    
    /*
     *  GIVEN: The `get` method of the DefaultNetworkClient is called
     *   WHEN: The returned HTTP response is valid
     *   THEN: The response should be a success with the correctly mapped object
     */
    func test_OnValidResponse_SucceedWithValidMappedObject() async {
        
        MockURLProtocol.requestHandler = getHandler(
            statusCode: 200,
            jsonString: "{\"message\": \"Success\"}"
        )
        
        let result = await sut.get(
            url: URL(string: "https://example.com")!,
            expecting: [String: String].self
        )
        
        switch result {
        case .success(let response):
            XCTAssertEqual(response, ["message": "Success"])
        case .failure:
            XCTFail("Should not fail when response is valid.")
        }
    }
    
    // MARK: - Helper Properties

    private func getHandler(
        statusCode: Int,
        jsonString: String,
        isHTTPResponse: Bool = true
    ) -> ((URLRequest) throws -> (URLResponse, Data))? {
        
        return { request in
            let data = jsonString.data(using: .utf8)
            let response = isHTTPResponse
            ? HTTPURLResponse(
                url: request.url!,
                statusCode: statusCode,
                httpVersion: "1.0",
                headerFields: nil
            )
            : URLResponse(
                url: request.url!,
                mimeType: nil,
                expectedContentLength: 0,
                textEncodingName: nil
            )
            
            return (response!, data!)
        }
    }
}
