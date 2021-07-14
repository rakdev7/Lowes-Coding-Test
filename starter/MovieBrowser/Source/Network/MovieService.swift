//
//  MovieService.swift
//  MovieBrowser
//
//  Created by Rakesh on 16/06/21.
//  Copyright © 2021 Lowe's Home Improvement. All rights reserved.
//

import Foundation

class MovieService: MovieServiceProtocol {
    
    private let networkAdapter: NetworkAdapter
    private let endpoint: MovieEndPoints
    
    required init(networkAdapter:NetworkAdapter, endpoint: MovieEndPoints) {
        self.networkAdapter = networkAdapter
        self.endpoint = endpoint
    }
    
    func fetchMovieResults(success: @escaping ((Data?) -> Void), failure: @escaping ((Error?) -> Void)) {
        networkAdapter.sendRequest(to: endpoint) { (result) in
            switch result{
            case let .success(data, _):
                if let data = data{
                    success(data)
                } else{
                    failure(NetworkError.missingDataError)
                }
            case let .failure(error, _):
                failure(error)
            }
        }
    }
    
    func fetchPosterImage(success: @escaping ((Data?) -> Void), failure: @escaping ((Error?) -> Void)) {
        networkAdapter.sendRequest(to: endpoint) { (result) in
            switch result{
            case let .success(data, _):
                if let data = data{
                    success(data)
                } else{
                    failure(NetworkError.missingDataError)
                }
            case let .failure(error, _):
                failure(error)
            }
        }
    }
}
