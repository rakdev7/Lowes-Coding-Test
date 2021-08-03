//
//  MovieEndPoints.swift
//  MovieBrowser
//
//  Created by Rakesh on 16/06/21.
//  Copyright © 2021 Lowe's Home Improvement. All rights reserved.
//

import Foundation

enum MovieEndPoints: Endpoint {
    case searchMovie(searchText: String)
    case getMovieDetails(posterPath: String)
    
    var baseURL: String {
        switch self {
        case .searchMovie:
            return Network.baseURL
        case .getMovieDetails:
            return Network.imageBaseURL
        }
    }
    
    var path: String {
        switch self {
        case .searchMovie:
            return "/3/search/movie"
        case .getMovieDetails(let posterPath):
            return "/t/p/w500"+posterPath
        }
    }
    
    var queryParameters: [String : String] {
        let defaultParameters = [String: String]()
        var localParameters = [String: String]()
        
        switch self {
        case .searchMovie(let text):
            localParameters = ["query":text, "api_key":  Network.apiKey]
        case .getMovieDetails:
            return defaultParameters
        }
        return defaultParameters.merging(localParameters) {(_, new) in new }
    }
}
