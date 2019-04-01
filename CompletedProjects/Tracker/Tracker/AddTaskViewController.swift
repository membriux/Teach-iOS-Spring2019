//
//  AddTaskViewController.swift
//  Tracker
//
//  Created by Hermain Hanif on 3/31/19.
//  Copyright © 2019 Hermain Hanif. All rights reserved.
//

import UIKit
import Parse

class AddTaskViewController: UIViewController {

    @IBOutlet weak var enterTaskName: UITextField!
    @IBOutlet weak var enterTaskDetail: UITextField!
    
    var task: PFObject!
    var tasks_list: [PFObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let user = PFUser.current()!
        
        if user["tasks"] != nil {
            tasks_list = user["tasks"] as! [PFObject]
        }

        // Do any additional setup after loading the view.
    }
    
    @IBAction func addTask(_ sender: Any) {
        let user = PFUser.current()!
        task = PFObject(className: "Tasks")
        task["name"] = enterTaskName.text
        task["details"] = enterTaskDetail.text
        
        user.add(task, forKey: "tasks");
        
        user.saveInBackground { (success, error) in
            if success {
                print("task saved")
            } else {
                print("Error saving task")
            }
        }
        
        clear()
    }
    
    func clear()
    {
        enterTaskName.text = ""
        enterTaskDetail.text = ""
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
