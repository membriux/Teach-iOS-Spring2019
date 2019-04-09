//
//  LoginViewController.swift
//  Tracker
//
//  Created by Hermain Hanif on 3/31/19.
//  Copyright © 2019 Hermain Hanif. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {
    
    // user name and password text fields
    @IBOutlet weak var userTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // if one already has account automatically sign them in
    @IBAction func signIn(_ sender: Any) {
        let username = userTextField.text!
        let password = passwordTextField.text!
        
        PFUser.logInWithUsername(inBackground: username, password: password) { (user, error) in
            if user != nil {
                self.performSegue(withIdentifier: "signInSegue", sender: nil)
            } else {
                print("Error: \(error?.localizedDescription)")
            }
        }
    }
    
    // when click create account, will create account in background 
    @IBAction func createAccount(_ sender: Any) {
        let user = PFUser()
        
        user.username = userTextField.text
        user.password = passwordTextField.text
                
        user.signUpInBackground { (success, error) in
            if success {
                self.performSegue(withIdentifier: "signInSegue", sender: nil)
            } else {
                print("Error: \(error?.localizedDescription)")
            }
            
        }
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
