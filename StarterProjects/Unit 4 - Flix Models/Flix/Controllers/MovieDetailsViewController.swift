//
//  MovieDetailsViewController.swift
//  Flix
//
//  Created by Derek Chang on 1/27/19.
//  Copyright © 2019 Derek Chang. All rights reserved.
//

import UIKit
import AlamofireImage

class MovieDetailsViewController: UIViewController {

    @IBOutlet weak var backdropView: UIImageView!
    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var synopsisLabel: UILabel!
    
    //create dictionary with all movies. Will be populated in the sender class
    var movie: Movie!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = movie.title
        synopsisLabel.text = movie.overview
        //Prevents the text from getting cut-off with ...
        synopsisLabel.sizeToFit()
        
        posterView.af_setImage(withURL: movie.posterURL)
        
        backdropView.af_setImage(withURL: movie.backdropURL)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
