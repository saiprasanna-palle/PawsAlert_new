//
//  CloseCaseViewController.swift
//  PawsAlert
//
//  Created by PALLE SAIPRASANNA  on 3/18/16.
//  Copyright © 2016 Rohit Nutalapati. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class CloseCaseViewController: PFQueryTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
        
        self.title = "Close Success Case"
        self.tableView.separatorColor = UIColor(red: 0.5, green: 0.9, blue: 0.1, alpha: 1)
        tableView.backgroundView = UIImageView(image: UIImage(named: "bg4.jpg"))
        let blur = UIBlurEffect(style: UIBlurEffectStyle.Dark)
        let blurView = UIVisualEffectView(effect: blur)
        view.insertSubview(blurView, atIndex: 0)
        self.tableView.tableFooterView = UIView(frame: CGRectZero)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    // Initialise the PFQueryTable tableview
    override init(style: UITableViewStyle, className: String!) {
        super.init(style: style, className: className)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        
        // Configure the PFQueryTableView
        self.parseClassName = "PA"
        self.textKey = "Name"
        self.pullToRefreshEnabled = true
        self.paginationEnabled = true
        self.objectsPerPage = 4
    }
    
    // Define the query that will provide the data for the table view
    override func queryForTable() -> PFQuery {
        let query = PFQuery(className: "PA")
         query.whereKey("fromUser", equalTo:PFUser.currentUser()!)
        query.cachePolicy = .NetworkElseCache
        
        if (self.objects!.count == 0){
            query.cachePolicy = .NetworkElseCache
        }
        
        query.orderByAscending("Name")
        return query
        
    }

    

    //override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath, object: PFObject?) -> PFTableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("userPetCell", forIndexPath: indexPath) as! UserPetsCellTableViewCell
        cell.petName?.font = UIFont(name: "Helvetica", size: 14)
        
        // Extract values from the PFObject to display in the table cell
        if let name = object?["Name"] as? String {
            //   cell.textLabel?.text = name
            cell.petName?.text = name
        }
     
        
        let imageFile = object?.objectForKey("imageFile") as? PFFile
        cell.petImage?.image = UIImage(named: "paw_icon")
        cell.petImage?.file = imageFile
        cell.petImage?.loadInBackground()
        //   cell.imageView?.file = imageFile
        //  cell.imageView?.loadInBackground()
        
        return cell
    }
    
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        return 75
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        
        return true
        
    }
    
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        // you need to implement this method too or you can't swipe to display the actions
        
        if (editingStyle == UITableViewCellEditingStyle.Delete) {
            var object = self.objectAtIndexPath(indexPath)
            //self.objects.removeAtIndex(indexpath)
            object!.deleteInBackgroundWithBlock({ (Bool, NSError) -> Void in
                self.loadObjects()
                print("its alive...sort of")
            })
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            tableView.reloadData()
        }
    }

    
    
}
