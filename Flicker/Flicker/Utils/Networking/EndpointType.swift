//
//  EndpointType.swift
//  Flicker
//
//  Created by Anusha Gattamaneni 11/19/24.
//

import Foundation

enum EndpointType {
    case posts(PostQuery)
}


extension EndpointType: TargetType{
    
    var baseUrl: String {
        return "https://api.flickr.com/services/feeds/"
    }
    
    var path: String {
        switch self {
        case .posts:
            return "photos_public.gne"
        }
    }
    
    var method: HttpMethods {
        switch self {
        case .posts:
            return .get
        }
    }
    
    var param: RequestParams {
        switch self {
        case .posts(let query):
            return .query(query)
        }
    }
    
    var headers: [String : String] {
        switch self {
        case .posts:
            return [
                HttpHeaderFields.contentType.rawValue:ContentType.json.rawValue
            ]
        }
    }
}
