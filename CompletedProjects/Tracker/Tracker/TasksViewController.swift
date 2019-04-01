//
//  TasksViewController.swift
//  Tracker
//
//  Created by Hermain Hanif on 3/31/19.
//  Copyright © 2019 Hermain Hanif. All rights reserved.
//

import UIKit
import Parse

class TasksViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!
    
    let user = PFUser.current()!
    var tasks_list: [PFObject] = []
    var tasks_info: [PFObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        self.tasks_list.removeAll()
        tasks_info.removeAll()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if user["tasks"] != nil {
            self.tasks_list.removeAll()
            tasks_list.removeAll()
            self.tasks_list = user["tasks"] as! [PFObject]
            print(tasks_list.count)
            getUserTasks()
        }
        tableView.reloadData()
    }
    
    func getUserTasks() {
        
        print("TASKS")
        tasks_info.removeAll()
        if self.tasks_list != [] {
            tasks_info.removeAll()
            for task in self.tasks_list {
                print("taskID", task.objectId!)
                let query = PFQuery(className: "Tasks")
                query.whereKey("objectId", equalTo: task.objectId!)
                
                query.findObjectsInBackground { (task, error) in
                    if error != nil {
                        print(error!.localizedDescription)
                    } else {
                        let task = task![0]
                        self.tasks_info.append(task)
                        self.tableView.reloadData()
                    }
                    
                }
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.tasks_list.count != 0 {
            return tasks_info.count
        }
        else {
            tasks_info.removeAll()
            self.tasks_list.removeAll()
            print(tasks_list.count)
            print(tasks_info.count)
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskTableViewCell") as! TaskTableViewCell
        
        if tasks_info.count != 0 {
            let task = self.tasks_info[indexPath.row]
            print(task)
            
            cell.taskNameLabel.text = task["name"] as? String
            cell.taskDetailLabel.text = task["details"] as? String
            
        }
        else {
            print( "in here" )
            cell.taskNameLabel.text = ""
            cell.taskDetailLabel.text = "Add tasks!"
            
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tasks_info.count != 0 {
            if tableView.cellForRow(at: indexPath)?.accessoryType == UITableViewCell.AccessoryType.checkmark{
                tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.none
            }
            else {
                tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.checkmark
            }
        }
    }
    
    @IBAction func logoutClicked(_ sender: Any) {
        PFUser.logOut()
        
        let main = UIStoryboard(name: "Main", bundle: nil)
        let loginViewController = main.instantiateViewController(withIdentifier: "LoginViewController")
        
        let delegate = UIApplication.shared.delegate as! AppDelegate
        
        delegate.window?.rootViewController = loginViewController 
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
