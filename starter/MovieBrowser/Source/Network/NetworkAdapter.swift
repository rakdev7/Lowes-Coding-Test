//
//  NetworkAdapter.swift
//  MovieBrowser
//
//  Created by Rakesh on 16/06/21.
//  Copyright © 2021 Lowe's Home Improvement. All rights reserved.
//

import Foundation

public class NetworkAdapter {
    
    private let session: URLSession
    public init(session: URLSession = URLSession.shared){
        self.session = session
    }
    
    public func sendRequest(to endpoint: Endpoint, completionHandler: @escaping(NetworkResult) -> Void) {
        var components = URLComponents()
        components.scheme = "https"
        components.host = endpoint.baseURL
        components.path = endpoint.path
        var queryItemsArray = [URLQueryItem]()
        for item in endpoint.queryParameters {
            queryItemsArray.append(URLQueryItem(name: item.key, value: item.value))
        }
        components.queryItems = queryItemsArray
        guard let url = components.url else {
            completionHandler(NetworkResult.failure(.invalidRequestError, nil))
            return
        }
        
        let task = session.dataTask(with: url) { (data, response, _) in
            completionHandler(NetworkResult.success(data, response))
        }
        task.resume()
    }
}
