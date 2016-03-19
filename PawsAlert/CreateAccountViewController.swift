//
//  CreateAccountViewController.swift
//  PawsAlert
//
//  Created by PALLE SAIPRASANNA  on 3/17/16.
//  Copyright © 2016 Rohit Nutalapati. All rights reserved.
//

import UIKit
import ParseUI

class CreateAccountViewController: UIViewController {

    @IBOutlet weak var UsernameTextField: UITextField!
    @IBOutlet weak var PasswordTextField: UITextField!
    @IBOutlet weak var EmailtextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func createAccount(sender: AnyObject) {
        
        let username = self.UsernameTextField.text
        let password = self.PasswordTextField.text
        let email = self.EmailtextField.text
        let finalEmail = email!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
        
        // Validate the text fields
        if (username?.characters.count) < 5 {
            let alert = UIAlertView(title: "Invalid", message: "Username must be greater than 5 characters", delegate: self, cancelButtonTitle: "OK")
            let attributedString = NSAttributedString(string: "Title", attributes: [
                NSFontAttributeName : UIFont.systemFontOfSize(12)])
            alert.setValue(attributedString, forKey: "attributedTitle")
            alert.show()
            self.UsernameTextField.text = ""
            self.UsernameTextField.highlighted = true
            
        }
        
        else if (username == "admin")
        {
            let alert = UIAlertView(title: "Invalid", message: "Username cannot be equal to admin", delegate: self, cancelButtonTitle: "OK")
            let attributedString = NSAttributedString(string: "Title", attributes: [
                NSFontAttributeName : UIFont.systemFontOfSize(12)])
            alert.setValue(attributedString, forKey: "attributedTitle")
            alert.show()
            UsernameTextField.text = ""
            PasswordTextField.highlighted = true
        }

        
        else if (password?.characters.count) < 8 {
            let alert = UIAlertView(title: "Invalid", message: "Password must be greater than 8 characters", delegate: self, cancelButtonTitle: "OK")
            let attributedString = NSAttributedString(string: "Title", attributes: [
                NSFontAttributeName : UIFont.systemFontOfSize(12)])
            alert.setValue(attributedString, forKey: "attributedTitle")
            alert.show()
            self.PasswordTextField.text = ""
             self.PasswordTextField.highlighted = true
            
        } else if (email?.characters.count) < 8 {
            let alert = UIAlertView(title: "Invalid", message: "Please enter a valid email address", delegate: self, cancelButtonTitle: "OK")
            let attributedString = NSAttributedString(string: "Title", attributes: [
                NSFontAttributeName : UIFont.systemFontOfSize(12)])
            alert.setValue(attributedString, forKey: "attributedTitle")
            alert.show()
             self.EmailtextField.text = ""
            self.EmailtextField.highlighted = true
            
        } else {
            // Run a spinner to show a task in progress
            
             self.UsernameTextField.highlighted = false
                self.PasswordTextField.highlighted = false
             self.EmailtextField.highlighted = false
            
            
            let spinner: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRectMake(0, 0, 150, 150)) as UIActivityIndicatorView
            spinner.startAnimating()
            
            let newUser = PFUser()
            
            newUser.username = username
            newUser.password = password
            newUser.email = finalEmail
            
            // Sign up the user asynchronously
            newUser.signUpInBackgroundWithBlock({ (succeed, error) -> Void in
                
                // Stop the spinner
                spinner.stopAnimating()
                if ((error) != nil) {
                    let alert = UIAlertView(title: "Error", message: "\(error)", delegate: self, cancelButtonTitle: "OK")
                    let attributedString = NSAttributedString(string: "Title", attributes: [
                        NSFontAttributeName : UIFont.systemFontOfSize(12)])
                    alert.setValue(attributedString, forKey: "attributedTitle")
                    alert.show()
                    
                } else {
                    let alert = UIAlertView(title: "Success", message: "Signed Up", delegate: self, cancelButtonTitle: "OK")
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        let attributedString = NSAttributedString(string: "Title", attributes: [
                            NSFontAttributeName : UIFont.systemFontOfSize(12)])
                        alert.setValue(attributedString, forKey: "attributedTitle")
                        alert.show()
                        let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("main") as! UIViewController
                        self.presentViewController(viewController, animated: true, completion: nil)
                    })
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
