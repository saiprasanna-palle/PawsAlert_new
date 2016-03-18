//
//  TempViewController.swift
//  PawsAlert
//
//  Created by PALLE SAIPRASANNA  on 3/18/16.
//  Copyright © 2016 Rohit Nutalapati. All rights reserved.
//

import UIKit

class TempViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
      /*  var query = PFQuery(className: "PA")
        query.getObjectInBackgroundWithId("fTsc3fdHMf", block: {
            (questionObject: PFObject?, error: NSError?) -> Void in
            if error == nil {
                print(questionObject)
                //if there's info in the console you know the object was retrieved
                let name = questionObject!["Name"] as? String
                
                questionObject!["fromUser"] = PFUser.currentUser()
                
                print(name)

                questionObject!.saveInBackgroundWithBlock {
                    (success: Bool, error: NSError?) -> Void in
                    if error != nil {
                        print("Error saving vote object: \(error!)")
                    } else {
                       print("Object saved")
                    }
                }
                
                
            } else {
                print("Error occurred retrieving object")
            }
        })        // Do any additional setup after loading the view.

*/
        
        
        var query = PFQuery(className:"PA")
        query.whereKey("fromUser", equalTo:PFUser.currentUser()!)
      //  query.includeKey("user.objectId"); // Is this what is needed to access user info ?
        
        query.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            
            if error == nil {
                
                for object in objects! {
                    print(object["Name"]) // See sample object below
            }
                
            }
                
                else
                {
                    print("Error")
                }
            }

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

}
