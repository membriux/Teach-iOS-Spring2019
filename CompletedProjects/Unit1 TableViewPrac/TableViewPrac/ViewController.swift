//
//  ViewController.swift
//  TableViewPrac
//
//  Created by Lily Pham on 4/4/19.
//  Copyright © 2019 Lily Pham. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    

    
    @IBOutlet weak var tableView: UITableView!
    
    let data = [("Japanese", ["Sushi", "Udon", "Yakitori", "Ramen"]),
                ("Vietnamese", ["Pho", "Banh Mi"]),
                ("Korean", ["Kimchi", "Bibimbap", "Soondubu", "Kimbap"]),
                ("Mexican", ["Tacos", "Enchiladas", "Quesadillas", "Aguas frescas"]),
                ("American", ["Burgers", "Mac n cheese"]),
                ("Italian", ["Spaghetti", "Pizza", "Carbonara"]),
                ("French", ["Croissants", "Baguettes", "Beignets", "Crepes", "Macarons", "Creme Brulee"])]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Make sure correct superclasses are included
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    // Should match number of categories of cuisines
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }

    // Number of rows in sections depends on how many foods items
    // are in a category
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data[section].1.count
    }
    
    // Changes text of cell to corresponding food item in data list
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FoodCell") as! FoodCell
        
        cell.foodLabel.text = data[indexPath.section].1[indexPath.row]
        
        return cell
    }
    
    // Creates the titles for each section
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return data[section].0
    }

}

