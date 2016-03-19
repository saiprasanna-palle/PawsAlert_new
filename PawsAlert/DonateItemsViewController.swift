//
//  DonateItemsViewController.swift
//  PawsAlert
//
//  Created by KASUVAJJALA DEEPTHI  on 3/16/16.
//  Copyright © 2016 Rohit Nutalapati. All rights reserved.
//
import UIKit

class DonateItemsViewController: UIViewController{
    
    @IBOutlet weak var message: UITextView!
    
    @IBOutlet weak var address1: UITextView!
    
    @IBOutlet weak var address2: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
     
        UIGraphicsBeginImageContext(self.view.frame.size)
        UIImage(named: "bg4.jpg")?.drawInRect(self.view.bounds)
        let image: UIImage! = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.view.backgroundColor = UIColor(patternImage: image)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func OKtoDonate(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
}
