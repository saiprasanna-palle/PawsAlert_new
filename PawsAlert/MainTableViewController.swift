//
//  MainTableViewController.swift
//  PawsAlert
//
//  Created by Rohit Nutalapati on 1/30/16.
//  Copyright © 2016 Rohit Nutalapati. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class MainTableViewController: PFQueryTableViewController{
    
      let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate

    var data = [[String]]()
    var images = [UIImage]()
    var col : Int = 0
    var total : Int = 0
    var flag : Int = 0
    
    override func viewWillAppear(animated: Bool) {
         self.loadObjects()
         self.tableView.separatorColor = UIColor(red: 0.5, green: 0.9, blue: 0.1, alpha: 1)
        tableView.reloadData()

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        
        // Verify Login
        if (PFUser.currentUser() == nil) {
            self.appDelegate.setupNavigationWithRoot("homeNavigation", andOptions: nil)
        }
        
        
        self.title = "Paws Alert"
        self.tableView.separatorColor = UIColor(red: 0.5, green: 0.9, blue: 0.1, alpha: 1)
        tableView.backgroundView = UIImageView(image: UIImage(named: "bg4.jpg"))
        let blur = UIBlurEffect(style: UIBlurEffectStyle.Dark)
        let blurView = UIVisualEffectView(effect: blur)
        view.insertSubview(blurView, atIndex: 0)
        self.tableView.tableFooterView = UIView(frame: CGRectZero)

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        //
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
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
        query.cachePolicy = .NetworkElseCache
        
        if (self.objects!.count == 0){
            query.cachePolicy = .NetworkElseCache
        }
        
        query.orderByAscending("Name")
        return query
        
    }
    
    
    //override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath, object: PFObject?) -> PFTableViewCell {
        var type_str : String?
        var status_str : String?
        
        let cell = tableView.dequeueReusableCellWithIdentifier("myPetCell", forIndexPath: indexPath) as! PetTableViewCell
        
        cell.PetName?.font = UIFont(name: "Helvetica", size: 14)
        cell.PetDetail?.font = UIFont(name: "Helvetica", size: 12)
        
        // Extract values from the PFObject to display in the table cell
        if let name = object?["Name"] as? String {
            //   cell.textLabel?.text = name
            cell.PetName?.text = name
        }
        if let status = object?["Status"] as? String {
            status_str = status
        }
        
        if let type = object?["Type"] as? String {
            type_str =  type
        }
        cell.PetDetail?.text = status_str! + "  " + type_str!
        
        let imageFile = object?.objectForKey("imageFile") as? PFFile
        cell.PetImage?.image = UIImage(named: "paw_icon")
        cell.PetImage?.file = imageFile
        cell.PetImage?.loadInBackground()
        //   cell.imageView?.file = imageFile
        //  cell.imageView?.loadInBackground()
        
        return cell
    }
    
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        return 76
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if segue.identifier == "petDetail"
        {
            let indexPath = self.tableView.indexPathForSelectedRow
            let detailVC = segue.destinationViewController as! PetDetailControllerViewController
            let object = self.objectAtIndexPath(indexPath)
            detailVC.detail_String = object?.objectForKey("Details") as! String
            detailVC.imageFile = object?.objectForKey("imageFile") as! PFFile
            detailVC.name = object?.objectForKey("Name") as! String
        }
    }
    
}
