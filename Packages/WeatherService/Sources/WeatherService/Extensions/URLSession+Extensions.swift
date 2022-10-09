
//
//  URLSession+Extensions.swift
//  WeatherApp
//
//  Created by Mihai Petrenco on 09.10.2022.
//

import Foundation

extension URLSession {
    
    enum URLRequestError: Error {
        case invalidURL
        case invalidData
        case unknown
        case fail(Int)
    }
    
    func request<T: Codable>(
        url: URL?,
        expecting type: T.Type
    ) async -> Result<T, Error> {
        
        guard let url = url else {
            return .failure(URLRequestError.invalidURL)
        }
        
        do {
            let (data, response) = try await data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                return .failure(URLRequestError.unknown)
            }
            
            guard httpResponse.statusCode == 200 else {
                return .failure(URLRequestError.fail(httpResponse.statusCode))
            }
            
            let object = try JSONDecoder().decode(type, from: data)
            return .success(object)

        } catch {
            return .failure(error)
        }
    }
    
}
