//
//  MovieServiceProtocol.swift
//  MovieBrowser
//
//  Created by Rakesh on 16/06/21.
//  Copyright © 2021 Lowe's Home Improvement. All rights reserved.
//

import Foundation

protocol MovieServiceProtocol
{
    func fetchMovieResults(success: @escaping((Data?)-> Void), failure: @escaping((Error?)-> Void))
    func fetchPosterImage(success: @escaping((Data?)-> Void), failure: @escaping((Error?)-> Void))
}
