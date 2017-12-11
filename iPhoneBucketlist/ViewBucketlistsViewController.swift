//
//  CreateBucketlistViewController.swift
//  bucketlist
//
//  Created by david mukiibi on 19/07/2017.
//  Copyright © 2017 david mukiibi. All rights reserved.
//

import UIKit

class ViewBucketlistsViewController: UIViewController {
    
    @IBAction func viewBuckets(_ sender: Any) {
        
        // Instantiating the app delegate so as to extract our stored token.
        let appDel = UIApplication.shared.delegate as? AppDelegate
        
        // Assigning the stored token to the constant token.
        let token = appDel?.userdefaults.value(forKey: "access_token") as! String
    
        var request = URLRequest(url:URL(string:"http://127.0.0.1:5000/api/v1/bucketlists/")!) // Creating a request object with API url route for creating a bucketlist.

        request.httpMethod = "GET" // Adding required fields to the post request being constructed.
        
        request.addValue("Bearer \(String(describing: token))", forHTTPHeaderField: "Authorization")  // Adding the authentication token to the request.
        let session = URLSession.shared
        let task = session.dataTask(with: request){data, response, error in
                
            guard(error == nil) else {
                print("\(String(describing: error))")
                return
            }
                
            do{
                let bucketlists = try JSONSerialization.jsonObject(with: data!, options: []) as! NSArray
                let responseCode: NSInteger = bucketlists[1] as! NSInteger
                if (responseCode == 200) {
                    for bucketlist in bucketlists[0] as! NSDictionary {
                        print(bucketlist.value)
                    }
                } else { print("this has refused to work, this error code: \(bucketlists[1])") }
            } catch {
                print("Could not parse data as Json \(error)")
            }

        }
        task.resume()
    }
    
    @IBOutlet weak var bucketlistsView: UILabel!
    
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
