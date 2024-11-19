//
//  String+Extension.swift
//  Flicker
//
//  Created by Anusha Gattamaneni 11/19/24.
//

import Foundation

extension String {
    func asUrl() throws ->  URL {
        guard let url = URL(string: self) else {
            throw NSError(domain: "Invalid Url", code: 0)
        }
        return url
    }
}
