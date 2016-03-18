//
//  VolunteerTableViewController.swift
//  PawsAlert
//
//  Created by KASUVAJJALA DEEPTHI  on 3/17/16.
//  Copyright © 2016 Rohit Nutalapati. All rights reserved.
//

import UIKit
import ParseUI

class VolunteerTableViewController: PFQueryTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
        
        self.title = "Paws Alert"
        self.tableView.separatorColor = UIColor(red: 0.5, green: 0.9, blue: 0.1, alpha: 1)
        tableView.backgroundView = UIImageView(image: UIImage(named: "bg4.jpg"))
        let blur = UIBlurEffect(style: UIBlurEffectStyle.Dark)
        let blurView = UIVisualEffectView(effect: blur)
        view.insertSubview(blurView, atIndex: 0)
        self.tableView.tableFooterView = UIView(frame: CGRectZero)
        
    }
    
    // Initialise the PFQueryTable tableview
    override init(style: UITableViewStyle, className: String!) {
        super.init(style: style, className: className)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        
        // Configure the PFQueryTableView
        self.parseClassName = "Volunteer"
        self.textKey = "Place"
        self.pullToRefreshEnabled = true
        self.paginationEnabled = true
        self.objectsPerPage = 5
    }
    
    // Define the query that will provide the data for the table view
    override func queryForTable() -> PFQuery {
        let query = PFQuery(className: "Volunteer")
        query.cachePolicy = .CacheElseNetwork
        
        if (self.objects!.count == 0){
            query.cachePolicy = .NetworkElseCache
        }
        return query
        
    }
    
    
    //override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath, object: PFObject?) -> PFTableViewCell {
        var pos : String?
        var place : String?
        var contact : String?
        
        let cell = tableView.dequeueReusableCellWithIdentifier("volunteer", forIndexPath: indexPath) as! PFTableViewCell
        
        // Extract values from the PFObject to display in the table cell
      if let place = object?["Place"] as? String {
               cell.textLabel?.text = place
        }
        if let position = object?["Position"] as? String {
            cell.textLabel?.text = (cell.textLabel?.text)! + " : " + position
        }
        
        if let contact = object?["Contact"] as? String {
            cell.detailTextLabel?.text = "Contact : " + contact
        }
        
        return cell
    }
    
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        return 45
}

}

