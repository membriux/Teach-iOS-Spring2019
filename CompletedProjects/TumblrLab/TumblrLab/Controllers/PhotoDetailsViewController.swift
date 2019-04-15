//
//  PhotoDetailsViewController.swift
//  TumblrLab
//
//  Created by Lily Pham on 4/15/19.
//  Copyright © 2019 Lily Pham. All rights reserved.
//

import UIKit

class PhotoDetailsViewController: UIViewController {

    @IBOutlet weak var photoView: UIImageView!
    
    var image: UIImage!

    override func viewDidLoad() {
        super.viewDidLoad()

        photoView.image = image
    }


}
