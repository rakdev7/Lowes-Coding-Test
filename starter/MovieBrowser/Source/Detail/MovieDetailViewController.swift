//
//  MovieDetailViewController.swift
//  SampleApp
//
//  Created by Struzinski, Mark on 2/26/21.
//  Copyright © 2021 Lowe's Home Improvement. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var posterImage: UIImageView!
    
    private let movieItem:Result
    
    private let movieManager = MovieManager()
    
    init?(movie: Result, coder: NSCoder) {
        self.movieItem = movie
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = movieItem.title
        releaseDateLabel.text = movieItem.release_date
        let dateFormatter = ISO8601DateFormatter()
        dateFormatter.formatOptions = [.withYear,.withMonth,.withDay,.withDashSeparatorInDate]
        
        if let date = dateFormatter.date(from: movieItem.release_date) {
            releaseDateLabel.text = "Release Date : " + date.string(withFormat: "MM/dd/yy")
        } else {
            releaseDateLabel.text = movieItem.release_date
        }
        
        overviewLabel.text = movieItem.overview
        self.getPosterImage()
    }
    
    func getPosterImage()  {
        guard let posterPath = movieItem.poster_path else { return  }
        movieManager.getPosterImage(for: posterPath) { (image) in
            if let image = image{
                DispatchQueue.main.async{
                    self.posterImage.image = image
                }
            }
        }
    }
}
