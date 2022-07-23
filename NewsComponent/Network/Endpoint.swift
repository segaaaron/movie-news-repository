//
//  Endpoint.swift
//  NewsComponent
//
//  Created by Miguel Angel Saravia Belmonte on 7/5/22.
//

import Foundation

enum ENDPOINT {
    case user
    case search
    var path: String {
        switch self {
        case .user:
            return "/users"
        case .search:
            return "/3/search/movie"
        }
    }
}

enum HTTPMETHOD: String {
    case GET = "get"
    case POST = "post"
}
