//
//  MovieGridViewController.swift
//  Flix
//
//  Created by Derek Chang on 1/27/19.
//  Copyright © 2019 Derek Chang. All rights reserved.
//

import UIKit
import AlamofireImage

class MovieGridViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    

    @IBOutlet weak var collectionView: UICollectionView!
    
    var movies = [Movie]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        
        //Handles the layout of the movie grid cells
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        
        layout.minimumLineSpacing = 4
        layout.minimumInteritemSpacing = 4
        let width = (view.frame.size.width - layout.minimumInteritemSpacing * 2) / 3
        //makes the height bigger than the width
        layout.itemSize = CGSize(width: width, height: width * 1.5)
        
        let url = URL(string: Url.MoviesWebsite.rawValue)!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            // This will run when the network request returns
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                
                let moviesJSON = dataDictionary["results"] as! [[String:Any]]
                
                for movie in moviesJSON {
                    
                    // Create poster url
                    let posterBaseUrl = "https://image.tmdb.org/t/p/w185"
                    let posterPath = movie["poster_path"] as! String
                    let posterUrl = URL(string: posterBaseUrl + posterPath)!
                    
                    // Create backdrop url
                    let backdropPath = movie["backdrop_path"] as! String
                    let backdropURL = URL(string: "https://image.tmdb.org/t/p/w780" + backdropPath)!
                    
                    // Create Movie
                    let movie = Movie(
                        title: movie["title"] as! String,
                        overview: movie["overview"] as! String,
                        posterURL: posterUrl,
                        backdropURL: backdropURL)
                    
                    self.movies.append(movie)
                    
                }
                
                self.collectionView.reloadData()
                
                print(self.movies)
                
                // TODO: Get the array of movies
                // TODO: Store the movies in a property to use elsewhere
                // TODO: Reload your table view data
                
            }
        }
        task.resume()
        // Do any additional setup after loading the view.
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cell.MovieGridCell.rawValue, for: indexPath) as! MovieGridCell
        
        //What is the difference between .item and .row
        let movie = movies[indexPath.item]
        
        cell.posterView.af_setImage(withURL: movie.posterURL)
        
        return cell
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        let cell = sender as! UICollectionViewCell
        let indexPath = collectionView.indexPath(for: cell)!
        let movie = movies[indexPath.item]
        
        
        let detailsViewController = segue.destination as! MovieDetailsViewController
        
        detailsViewController.movie = movie
        
        collectionView.deselectItem(at: indexPath, animated: true)
        
        
    }
    

}
