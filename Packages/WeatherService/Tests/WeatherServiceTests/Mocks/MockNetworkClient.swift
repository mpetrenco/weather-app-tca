//
//  File.swift
//  
//
//  Created by Mihai Petrenco on 09.10.2022.
//

import Foundation
import Networking

final class MockNetworkClient: NetworkClient {
    
    // MARK: - Properties
    
    var receivedURL: URL?
    var expectedType: Any?
    
    // MARK: - Protocol Methods
    
    func get<T>(
        url: URL?,
        expecting type: T.Type
    ) async -> Result<T, Error> where T : Decodable, T : Encodable {
        
        receivedURL = url
        expectedType = type

        return .failure(NSError())
    }
}
