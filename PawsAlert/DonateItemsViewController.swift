//
//  DonateItemsViewController.swift
//  PawsAlert
//
//  Created by KASUVAJJALA DEEPTHI  on 3/16/16.
//  Copyright © 2016 Rohit Nutalapati. All rights reserved.
//
import UIKit

class DonateItemsViewController: UIViewController{
    
        var data = [[String]]()
    
    override func viewDidLoad() {
        
        
        var number: CGFloat = 200
        var rows = 3
        
        
        
        let query = PFQuery(className:"Contact")
        var i : Int = 0
        print("In init main data")
        
        query.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            if error == nil {
                print("obj count : \(objects?.count)")
                
                rows = (objects?.count)!
                for x in objects! {
                    self.data.append([])
                    self.data[i].append(x.valueForKey("Organization") as! String!)
                    self.data[i].append(x.valueForKey("Street") as! String!)
                    self.data[i].append(x.valueForKey("City") as! String!)
                    self.data[i].append(x.valueForKey("State") as! String!)
                    self.data[i].append(x.valueForKey("Zip") as! String)
                    self.data[i].append(x.valueForKey("Contact") as! String!)
                    
                    var label = UILabel(frame: CGRectMake(25, number, 300, 200))
                    // label.center = CGPointMake(160, 284)
                    label.textAlignment = NSTextAlignment.Left
                    let a = "\(self.data[i][0]) \n \(self.data[i][1]) \n"
                    let b = "\(self.data[i][2]) , \(self.data[i][3]) - \(self.data[i][4]) \n"
                    let c = "Contact : \(self.data[i][5])"
                    let d = a + b + c
                    label.text = d
                    
                    print(d)
                    print(label.text)
                    self.view.addSubview(label)
                    number = number + 200
                    
                    i++
                    
                }

                
            } else {
                print(error)
            }
        }

        
        
        
    }
    
    
    @IBAction func OKtoDonate(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
}
