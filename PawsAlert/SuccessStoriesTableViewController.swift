//
//  SuccessStoriesTableViewController.swift
//  PawsAlert
//
//  Created by KASUVAJJALA DEEPTHI  on 3/17/16.
//  Copyright © 2016 Rohit Nutalapati. All rights reserved.
//

import UIKit
import ParseUI

class SuccessStoriesTableViewController: PFQueryTableViewController {
  
   
    override func viewWillAppear(animated: Bool) {
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        self.title = "Success Stories"
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
        self.parseClassName = "Stories"
        self.textKey = "StoryDetail"
        self.pullToRefreshEnabled = true
        self.paginationEnabled = true
        self.objectsPerPage = 1
    }
    
    // Define the query that will provide the data for the table view
    override func queryForTable() -> PFQuery {
        let query = PFQuery(className: "Stories")
        query.cachePolicy = .CacheElseNetwork
        
        if (self.objects!.count == 0){
            query.cachePolicy = .NetworkElseCache
        }
        return query
        
    }


    //override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath, object: PFObject?) -> PFTableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("SuccessStory", forIndexPath: indexPath) as! SuccessStoryTableViewCell
        cell.successStory?.font = UIFont(name: "Helvetica", size: 10)
        
        // Extract values from the PFObject to display in the table cell
        if let story = object?["StoryDetail"] as? String {
            //   cell.textLabel?.text = name
            cell.successStory.text = story
        }
        
        let petImageFile = object?.objectForKey("PetImage") as? PFFile
        cell.petImage?.image = UIImage(named: "paw_icon")
        cell.petImage?.file = petImageFile
        cell.petImage?.loadInBackground()
        
        let volunteerImageFile = object?.objectForKey("StoryImage") as? PFFile
        cell.volunteerImage?.image = UIImage(named: "paw_icon")
        cell.volunteerImage?.file = volunteerImageFile
        cell.volunteerImage?.loadInBackground()
        
        return cell
    }
    
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        return 180
}

}