//
//  MenuViewController.swift
//  PawsAlert
//
//  Created by PALLE SAIPRASANNA  on 2/22/16.
//  Copyright © 2016 Rohit Nutalapati. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        UIGraphicsBeginImageContext(self.view.frame.size)
        UIImage(named: "bg4.jpg")?.drawInRect(self.view.bounds)
        let image: UIImage! = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.view.backgroundColor = UIColor(patternImage: image)


        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
      
        if(segue.identifier == "Donation")
       {
         let destVC = segue.destinationViewController as! DonationViewController
        destVC.senderButton = "Donate Money"
       }
        if(segue.identifier == "Furless Fostering")
        {
             let destVC = segue.destinationViewController as! DonationViewController
            destVC.senderButton = "Furless Fostering"
        }
    }


}
