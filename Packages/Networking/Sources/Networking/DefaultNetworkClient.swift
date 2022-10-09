//
//  DefaultNetworkClient.swift
//
//  Created by Mihai Petrenco on 09.10.2022.
//

import Foundation

public enum NetworkError: Error {
    case invalidURL
    case invalidData
    case unknown
    case fail(Int)
}

public struct DefaultNetworkClient: NetworkClient {
    
    public func get<T: Codable>(
        url: URL?,
        expecting type: T.Type
    ) async -> Result<T, Error> {
        
        guard let url = url else {
            return .failure(NetworkError.invalidURL)
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                return .failure(NetworkError.unknown)
            }
            
            guard httpResponse.statusCode == 200 else {
                return .failure(NetworkError.fail(httpResponse.statusCode))
            }
            
            let object = try JSONDecoder().decode(type, from: data)
            return .success(object)
            
        } catch {
            return .failure(error)
        }
    }
    
}
