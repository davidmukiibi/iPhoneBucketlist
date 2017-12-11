//
//  CreateBucketlistViewController.swift
//  bucketlist
//
//  Created by david mukiibi on 19/07/2017.
//  Copyright © 2017 david mukiibi. All rights reserved.
//

import UIKit

class CreateBucketlistViewController: UIViewController {
    
    @IBOutlet weak var bucketlistName: UITextField!
    @IBAction func create(_ sender: Any) {
        
        guard let bucketlistNameText : String = self.bucketlistName.text else { return }
        
        // Instantiating the app delegate so as to extract our stored token.
        let appDel = UIApplication.shared.delegate as? AppDelegate
        
        // Assigning the stored token to the constant token.
        let token = appDel?.userdefaults.value(forKey: "access_token") as! String
        
        // Creating the required parameters for creating a bucketlist.
        let postString = ["name": bucketlistNameText] as [String: String]
        
        // Creating a request object with API url route for creating a bucketlist.
        var request = URLRequest(url:URL(string:"http://127.0.0.1:5000/api/v1/bucketlists/")!)
        
        // Adding required fields to the post request being constructed.
        request.httpMethod = "POST"
        
        // Adding the authentication token to the request.
        request.setValue("Bearer \(String(describing: token))", forHTTPHeaderField: "Authorization")
        request.addValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        
        guard let httpBody = try? JSONSerialization.data(withJSONObject: postString, options: []) else { return }
        request.httpBody = httpBody
        
        let session = URLSession.shared
        let task = session.dataTask(with: request){data, response, error in
            
            // Check if there was an error.
            guard (error == nil) else {
                print("\(String(describing: error))")
                return
            }
            // Check if there was any data returned.
            guard let data = data else {
                print("no data returned")
                return
            }
            // Convert Json data to an Object that is readable and friendly to work with.
            let parseResult: [String:Any]?
            do{
                parseResult = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any]
                print("\(String(describing: parseResult!))")
            } catch {
                print("Could not parse data as Json \(data)")
                return
            }
            
            
        }
        task.resume()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
