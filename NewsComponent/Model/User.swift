//
//  User.swift
//  NewsComponent
//
//  Created by Miguel Angel Saravia Belmonte on 7/5/22.
//

import Foundation

struct User: Decodable {
    let name: String
    let username: String
    let email: String
    let phone: String
    let website: String
}

struct NewsList: Decodable {
    let name: String
}
