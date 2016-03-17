//
//  PetsInfoDisplay.swift
//  PawsAlert
//
//  Created by PALLE SAIPRASANNA  on 3/16/16.
//  Copyright © 2016 Rohit Nutalapati. All rights reserved.
//

import UIKit
import ParseUI

class PetsInfoDisplay: PFQueryTableViewController {
    
    
    override func viewWillAppear(animated: Bool) {
        tableView.reloadData()
        tableView.reloadInputViews()
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
        var query = PFQuery(className: "PA")
        query.cachePolicy = .CacheElseNetwork
        
        if (self.objects!.count == 0){
            query.cachePolicy = .CacheElseNetwork
        }
        
        query.orderByAscending("Name")
        return query
        
    }
    
    
    //override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath, object: PFObject?) -> PFTableViewCell {
        var type_str : String?
        var status_str : String?
        
     let cell = tableView.dequeueReusableCellWithIdentifier("pfcell", forIndexPath: indexPath) as! PetTableViewCell
        
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
       return 80
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if segue.identifier == "petDetail"
        {
            let indexPath = self.tableView.indexPathForSelectedRow
            let detailVC = segue.destinationViewController as! PetDetailInfoDisplayViewController
            let object = self.objectAtIndexPath(indexPath)
            detailVC.detail_String = object?.objectForKey("Name") as! String + ((object?.objectForKey("Type"))! as! String) as? String
            detailVC.imageFile = object?.objectForKey("imageFile") as! PFFile
        }
    }
    
}

