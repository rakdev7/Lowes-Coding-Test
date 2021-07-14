//
//  MovieManager.swift
//  MovieBrowser
//
//  Created by Rakesh on 16/06/21.
//  Copyright © 2021 Lowe's Home Improvement. All rights reserved.
//

import Foundation
import UIKit

class MovieManager {
    
    func getMovieResults(with title: String, completionHandler: @escaping(SearchResults?) -> Void) {
        let serviceProvider = MovieService(networkAdapter: NetworkAdapter(), endpoint: .searchMovie(searchText: title))
        serviceProvider.fetchMovieResults { (data) in
            if let data = data {
                do {
                    if let str = data.prettyPrintedJSON { print(str)}
                    let response:SearchResults = try JSONDecoder().decode(SearchResults.self, from: data)
                    completionHandler(response)
                } catch {
                    print(error)
                    completionHandler(nil)
                }
            }
        } failure: { (error) in
            completionHandler(nil)
        }
    }
    
    func getPosterImage(for path:String, completionHandler: @escaping ((UIImage?) -> Void)) {
        let serviceProvider = MovieService(networkAdapter: NetworkAdapter(), endpoint: .getMovieDetails( posterPath: path))
        serviceProvider.fetchPosterImage { (data) in
            if let data = data, let image = UIImage(data: data){
                completionHandler(image)
            } else {
                completionHandler(nil)
            }
        } failure: { (error) in
            completionHandler(nil)
        }
    }
}


extension Data{
    var prettyPrintedJSON: NSString? {
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []), let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
              let prettyPrintedString = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
        else { return nil }
        return prettyPrintedString
    }
}

extension Date{
    public func string(withFormat format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}
