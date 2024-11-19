//
//  Enums.swift
//  Flicker
//
//  Created by Anusha Gattamaneni 11/19/24.
//

import Foundation

enum HttpHeaderFields: String {
    case contentType = "Content-Type"
    case authentication = "Authorization"
}

enum ContentType: String {
    case json = "application/json"
}

enum HttpMethods: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

enum RequestParams{
    case query(_ request: Encodable?)
    case body(_ request: Encodable?)
}
