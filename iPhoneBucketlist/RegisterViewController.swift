//
//  RegisterViewController.swift
//
//
//  Created by david mukiibi on 19/07/2017.
//
//

import UIKit

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var first_name: UITextField!
    
    @IBOutlet weak var second_name: UITextField!
    
    @IBOutlet weak var email_address: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    @IBAction func register_button(_ sender: Any) {
        
        guard let first_name : String = self.first_name.text else { return }
        guard let second_name : String = self.second_name.text else { return }
        guard let email_address : String = self.email_address.text else { return }
        guard let password : String = self.password.text else { return }
        
        // Creating the required parameters for creating a bucketlist.
        let postString = ["first_name": first_name, "second_name": second_name, "email": email_address, "password": password] as [String: String]
        
        // Creating a request object with API url route for registering a new user.
        var request = URLRequest(url:URL(string:"http://127.0.0.1:5000/api/v1/auth/register/")!)
        
        // Adding required fields to the post request being constructed.
        request.httpMethod = "POST"
        request.addValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: postString, options: []) else { return }
        request.httpBody = httpBody
        
        // Creating an http session to deliver our request.
        let session = URLSession.shared
        let task =  session.dataTask(with: request){data, response, error in
            
            // Check if there was an error.
            guard (error == nil) else {
                print("this is the error: \(String(describing: error))")
                return
            }
            // Check if there was any data returned.
            guard let data = data else {
                print("no data returned")
                return
            }
            // Convert Json data to an Object that is readable and friendly to work with.
            let parseResult: [String: Any]?
            do{
                parseResult = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any]
                print("this is the message \(String(describing: parseResult?["message"]!))")
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
