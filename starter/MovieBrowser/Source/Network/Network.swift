//
//  Network.swift
//  SampleApp
//
//  Created by Struzinski, Mark - Mark on 9/17/20.
//  Copyright © 2020 Lowe's Home Improvement. All rights reserved.
//

import UIKit

struct Network {
    static let baseURL = "api.themoviedb.org"
    static let imageBaseURL = "image.tmdb.org"
    static let apiKey = "5885c445eab51c7004916b9c0313e2d3"
}

public protocol Endpoint{
    var baseURL: String { get }
    var path: String { get }
    var queryParameters: [String: String] { get }
}

public enum NetworkError: Error{
    case unknownError
    case missingDataError
    case serializationError
    case invalidDataError
    case invalidRequestError
}

public enum NetworkResult{
    case success(Data?, URLResponse?)
    case failure(NetworkError, URLResponse?)
}
