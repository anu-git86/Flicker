//
//  PostQuery.swift
//  Flicker
//
//  Created by Anusha Gattamaneni 11/19/24.
//

import Foundation

struct PostQuery: Encodable {
    let format: String
    let nojsoncallback: String
    let tags: String
}
