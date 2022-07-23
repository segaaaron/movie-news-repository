//
//  MovieFeature.swift
//  NewsComponent
//
//  Created by Miguel Angel Saravia Belmonte on 7/7/22.
//

import Foundation

struct MovieGT: Decodable {
    let page: Int
    let results: [MovieResult]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

struct MovieResult: Decodable {
    let adult: Bool?
    let backdrop_path: String?
    let id: Int?
    let original_language: String?
    let original_title: String?
    let overview: String?
    let popularity: Double?
    let poster_path: String?
    let release_date: String?
    let title: String?
    let video: Bool?
    let genre_ids: [Int]?
    let vote_average: Double?
    let vote_count: Double?
}
