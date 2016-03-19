//
//  ForgotPasswordViewController.swift
//  PawsAlert
//
//  Created by PALLE SAIPRASANNA  on 3/17/16.
//  Copyright © 2016 Rohit Nutalapati. All rights reserved.
//

import UIKit

class ForgotPasswordViewController: UIViewController {

    @IBOutlet weak var EmailTextfield: UITextField!
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
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func retrievePassword(sender: AnyObject) {
        let email = self.EmailTextfield.text
        let finalEmail = email!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
        
        // Send a request to reset a password
        PFUser.requestPasswordResetForEmailInBackground(finalEmail)
        
        var alert = UIAlertController (title: "Password Reset", message: "An email containing information on how to reset your password has been sent to " + finalEmail + ".", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
        let attributedString = NSAttributedString(string: "Title", attributes: [
            NSFontAttributeName : UIFont.systemFontOfSize(12)])
        alert.setValue(attributedString, forKey: "attributedTitle")
        self.presentViewController(alert, animated: true, completion: nil)
        EmailTextfield.text = ""
        
    }
}
