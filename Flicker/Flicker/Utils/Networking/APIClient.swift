//
//  APIClient.swift
//  Flicker
//
//  Created by Anusha Gattamaneni 11/19/24.
//

import Foundation

class APIClient {
    
    private static let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        return decoder
    }()
    
    private static let session: URLSession = {
        let config = URLSessionConfiguration.default
        return URLSession(configuration: config)
    }()
    
    private static let sucessRange: Range = 200..<300
    
    static func sendRequest<T:Decodable>(endPoint:EndpointType) async throws -> T {
        let (data, response) = try await session.data(for: endPoint.asUrlRequest())
        let validData = try validData(data: data, response: response)
        return try decoder.decode(T.self, from: validData)
    }
    
    static private func validData(data:Data, response: URLResponse) throws -> Data {
        guard let code = (response as? HTTPURLResponse)?.statusCode else {
            throw NSError(domain: "Invalid Response", code: 0)
        }
        
        if sucessRange.contains(code) {
            return data
        } else {
            switch code {
            case 401:
                throw NSError(domain: "Unauthorized", code: code)
            case 404:
                throw NSError(domain: "Not Found", code: code)
            default:
                throw NSError(domain: "UnExpectedError", code: code)
            }
        }
    }
}
