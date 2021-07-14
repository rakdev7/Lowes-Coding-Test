//
//  SearchResults.swift
//  MovieBrowser
//
//  Created by Rakesh on 16/06/21.
//  Copyright © 2021 Lowe's Home Improvement. All rights reserved.
//

import Foundation

struct SearchResults: Codable {
    let page: Int
    let total_pages: Int
    let total_results: Int
    let results: [Result]
}

struct Result: Codable {
    let id: Int
    let original_language: String
    let original_title: String
    let overview : String
    let poster_path : String?
    let release_date: String
    let title: String
    let vote_average : Double
}
