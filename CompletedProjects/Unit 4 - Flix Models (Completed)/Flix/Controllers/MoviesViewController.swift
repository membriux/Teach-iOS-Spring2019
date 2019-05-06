//
//  MoviesViewController.swift
//  Flix
//
//  Created by Derek Chang on 1/12/19.
//  Copyright © 2019 Derek Chang. All rights reserved.
//

import UIKit
import AlamofireImage

class MoviesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {


    var movies = [Movie]()
    
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        
        //Extends the cells to fit the larger 'synopsis label'
        //Estimated row height comes from the image view ( height=130, top constraint=8,
        //bottom constraint=8)  -> 130 + 8 + 8
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 130 + 8 + 8
        
        
        
        
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            // This will run when the network request returns
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                
                let moviesJSON = dataDictionary["results"] as! [[String:Any]]
                
                for movieDict in moviesJSON{
                    // Poster URL
                    let basePosterUrl = "https://image.tmdb.org/t/p/w185"
                    let posterPath = movieDict["poster_path"] as! String
                    let posterUrl = URL(string: basePosterUrl + posterPath)!
                    
                    // Backdrop URL
                    let baseBackdropUrl = "https://image.tmdb.org/t/p/w780"
                    let backdropPath = movieDict["backdrop_path"] as! String
                    let backdropURL = URL(string: baseBackdropUrl + backdropPath)!
                    
                    let movie = Movie(
                        title: movieDict["title"] as! String,
                        overview: movieDict["overview"] as! String,
                        posterURL: posterUrl,
                        backdropURL: backdropURL
                    )
                    
                    self.movies.append(movie)
                }
                
                print(self.movies)
                //Call the functions again after downloading the data
                self.tableView.reloadData()
                
                
                // TODO: Get the array of movies
                // TODO: Store the movies in a property to use elsewhere
                // TODO: Reload your table view data
                
            }
        }
        task.resume()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Cell.MovieCell.rawValue) as! MovieCell
        
        let movie = movies[indexPath.row]
        
        cell.titleLabel.text = movie.title
        cell.synopsisLabel.text = movie.overview
        
        cell.posterView.af_setImage(withURL: movie.posterURL)
        
        return cell
    }
    
    
     //MARK: - Navigation

     //In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         //Get the new view controller using segue.destination.
         //Pass the selected object to the new view controller.
        
        //Find the selected movie
        let cell = sender as! UITableViewCell
        let indexPath = tableView.indexPath(for: cell)!
        let movie = movies[indexPath.row]
        
        //Pass the selected movie to the details movies controller
        let detailsViewController = segue.destination as! MovieDetailsViewController
        
        //There is a variable in the class that we want to send stuff to that we define here
        detailsViewController.movie = movie
        
        //Deselects the row after you come back to the view
        tableView.deselectRow(at: indexPath, animated: true)
    }
    

}
