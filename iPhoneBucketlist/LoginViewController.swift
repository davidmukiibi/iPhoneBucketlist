//
//  ViewController.swift
//  bucketlist
//
//  Created by david mukiibi on 13/07/2017.
//  Copyright © 2017 david mukiibi. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBAction func login(_ sender: Any) {
        
        let email : String = self.email.text!
        let password : String = self.password.text!
        
        // Constructing dictionary with required login parameters.
        let postString = ["email": email, "password": password]
        
        // Creating a request object with API login-user url.
        var request = URLRequest(url:URL(string:"http://127.0.0.1:5000/api/v1/auth/login/")!)
        
        // Adding required fields to the post request being constructed.
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application-idValue", forHTTPHeaderField: "secret-key")
        request.httpBody = try! JSONSerialization.data(withJSONObject: postString, options:.prettyPrinted)
        
        // Creating an http session to deliver our request.
        let session = URLSession.shared
        let task =  session.dataTask(with: request){data, response, error in
            
            // Check if there is an error.
            guard (error == nil) else {
                print("there was this error: \(error!)")
                return
            }
            
            // Check if any data was returned.
            guard response != nil else {
                print("there was no response")
                return
            }
            
            // Convert Json data to an Object that is readable and friendly to work with.
            do{
                let parseResult = try JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary
                
                guard let token = parseResult!["token"]! as? [String: Any] else { return }
                
                if let access_token = token["access_token"] {
                    print("\(String(describing: access_token))")
                    
                    // Creating an app delegate object so that we can use userdefaults
                    // to store login token generated after login.
                    let appDel = UIApplication.shared.delegate as? AppDelegate
                    
                    // Storing the received token to the user defaults.
                    appDel?.userdefaults.setValue(access_token, forKey: "access_token")
                }
                
            } catch {
                print("Could not parse data as Json \(String(describing: data))")
                return
            }
            
            
        }
        task.resume()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

