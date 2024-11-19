//
//  Encodable+Extension.swift
//  Flicker
//
//  Created by Anusha Gattamaneni 11/19/24.
//

import Foundation

extension Encodable {
    
    func toDictionary() throws -> [String:Any] {
        let encoder = JSONEncoder()
        
        do {
            let data = try encoder.encode(self)
            if let jsonData = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] {
                return jsonData
            }
        } catch {
            throw NSError(domain: "Invalid Request", code: 0)
        }
        return [:]
    }
}

