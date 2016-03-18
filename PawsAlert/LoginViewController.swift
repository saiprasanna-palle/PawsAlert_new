//
//  LoginViewController.swift
//  PawsAlert
//
//  Created by PALLE SAIPRASANNA  on 3/17/16.
//  Copyright © 2016 Rohit Nutalapati. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var Username: UITextField!
    @IBOutlet weak var Password: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func login(sender: AnyObject)
    {
        
    let username = self.Username.text
    let password = self.Password.text
    
    // Validate the text fields
    if (username?.characters.count) < 5 {
    let alert = UIAlertView(title: "Invalid", message: "Username must be greater than 5 characters", delegate: self, cancelButtonTitle: "OK")
    alert.show()
    Username.text = ""
    Username.highlighted = true
    
    } else if (password?.characters.count) < 8 {
    let alert = UIAlertView(title: "Invalid", message: "Password must be greater than 8 characters", delegate: self, cancelButtonTitle: "OK")
    alert.show()
    Password.text = ""
    Password.highlighted = true
    
    } else {
    // Run a spinner to show a task in progress
    
    Username.highlighted = false
    Password.highlighted = false
        
    let spinner: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRectMake(0, 0, 150, 150)) as UIActivityIndicatorView
    spinner.startAnimating()
    
    // Send a request to login
    PFUser.logInWithUsernameInBackground(username!, password: password!, block: { (user, error) -> Void in
    
    // Stop the spinner
    spinner.stopAnimating()
    
    if ((user) != nil) {
    let alert = UIAlertView(title: "Success", message: "Logged In", delegate: self, cancelButtonTitle: "OK")
    alert.show()
    
   // dispatch_async(dispatch_get_main_queue(), { () -> Void in
    let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("main") as! UIViewController
    self.presentViewController(viewController, animated: true, completion: nil)
  //  })
    
    } else {
    let alert = UIAlertView(title: "Error", message: "Cannot login. Please try again later!", delegate: self, cancelButtonTitle: "OK")
    alert.show()
    }
    })
    }
}
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
