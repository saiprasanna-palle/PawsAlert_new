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
     self.view.backgroundColor = UIColor(patternImage: UIImage(named: "bg4.jpg")!)
        message.layer.backgroundColor = UIColor(patternImage: UIImage(named: "bg4.jpg")!).CGColor
 address1.layer.backgroundColor = UIColor(patternImage: UIImage(named: "bg4.jpg")!).CGColor
         address2.layer.backgroundColor = UIColor(patternImage: UIImage(named: "bg4.jpg")!).CGColor
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func OKtoDonate(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
}
