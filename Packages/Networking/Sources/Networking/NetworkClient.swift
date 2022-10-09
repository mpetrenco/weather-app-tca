//
//  NetworkClient.swift
//  
//  Created by Mihai Petrenco on 09.10.2022.
//

import Foundation

public protocol NetworkClient {
    
    func get<T: Codable>(
        url: URL?,
        expecting type: T.Type
    ) async -> Result<T, Error>
    
}
