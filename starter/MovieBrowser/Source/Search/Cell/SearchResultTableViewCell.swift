//
//  SearchResultTableViewCell.swift
//  MovieBrowser
//
//  Created by Rakesh on 16/06/21.
//  Copyright © 2021 Lowe's Home Improvement. All rights reserved.
//

import UIKit

class SearchResultTableViewCell: UITableViewCell {

    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var ratingsLabel: UILabel!
    
    func configureCell(with movie: Result) {
        movieNameLabel.text = movie.original_title
        
        let dateFormatter = ISO8601DateFormatter()
        dateFormatter.formatOptions = [.withYear,.withMonth,.withDay,.withDashSeparatorInDate]
        
        if let date = dateFormatter.date(from: movie.release_date) {
            releaseDateLabel.text = date.string(withFormat: "MMMM dd, yyyy")
        } else {
            releaseDateLabel.text = movie.release_date
        }
        ratingsLabel.text = String(movie.vote_average)
    }
}
