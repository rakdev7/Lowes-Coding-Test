//
//  SearchViewController.swift
//  SampleApp
//
//  Created by Struzinski, Mark on 2/19/21.
//  Copyright © 2021 Lowe's Home Improvement. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var movies:[Result] = [Result](){
        didSet{
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    private let movieManager = MovieManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableView.automaticDimension
        customizeSearchTextField()
    }
    
    func customizeSearchTextField(){
        let searchTextField: UITextField? = searchBar.value(forKey: "searchField") as? UITextField
        if searchTextField!.responds(to: #selector(getter: UITextField.attributedPlaceholder)) {
            let attributeDict = [NSAttributedString.Key.foregroundColor: UIColor.gray]
            searchTextField!.attributedPlaceholder = NSAttributedString(string: "Search Movie", attributes: attributeDict)
        }
    }
    
    @IBAction func searchButtonTapped(_ sender: Any) {
        guard let text = searchBar.text, text.count != 0, !text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            self.showAlert(with: "Alert", and: "Please enter movie name to search.")
            return
        }
        sendSearchRequest(with: text)
    }
    
    func sendSearchRequest(with text:String) {
        movieManager.getMovieResults(with: text) { (results) in
            if let results = results {
                self.movies = results.results
                if results.results.count == 0{
                    self.showAlert(with: "Alert", and: "No Search results found for the search criteria.")
                    return
                }
            } else {
                self.showAlert(with: "Error", and: "Search request failed.")
            }
        }
    }
    
    func showAlert(with title: String, and message: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            
            self.present(alert, animated: true)
        }
    }
    
}

//MARK: SearchBar delegate

extension SearchViewController: UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        if let text = searchBar.text,text.count != 0,!text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            sendSearchRequest(with: text)
        } else {
            self.showAlert(with: "Alert", and: "Please enter movie name to start search.")
        }
    }
}

//MARK: Tableview Delegate & Datasources
extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SearchResultTableViewCell", for: indexPath) as? SearchResultTableViewCell else{
            return UITableViewCell()
        }
        cell.configureCell(with: movies[indexPath.row])
        return cell
    }
}

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        showDetails(for: movies[indexPath.row])
    }
    
    private func showDetails(for movie: Result) {
        guard let viewController = storyboard?.instantiateViewController(
            identifier: "MovieDetails",
            creator: { coder in
                MovieDetailViewController(movie: movie, coder: coder)
            }
        ) else {
            fatalError("Failed to create Product Details VC")
        }
        show(viewController, sender: self)
    }
}
