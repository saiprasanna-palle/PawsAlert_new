//
//  MainTableViewController.swift
//  PawsAlert
//
//  Created by Rohit Nutalapati on 1/30/16.
//  Copyright © 2016 Rohit Nutalapati. All rights reserved.
//

import UIKit
import Parse

class MainTableViewController: UITableViewController {

    var data = [[String]]()
    var images = [UIImage]()
    var col : Int = 0
    var total : Int = 0
    var flag : Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        self.title = "Paws Alert"
        self.tableView.separatorColor = UIColor(red: 0.5, green: 0.9, blue: 0.1, alpha: 1)
        tableView.backgroundView = UIImageView(image: UIImage(named: "bg4.jpg"))
        let blur = UIBlurEffect(style: UIBlurEffectStyle.Dark)
        let blurView = UIVisualEffectView(effect: blur)
        view.insertSubview(blurView, atIndex: 0)
        self.tableView.tableFooterView = UIView(frame: CGRectZero)
        
        initData()
        

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        //
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewWillAppear(animated: Bool) {
        print("In view reload")
        tableView.reloadData()
    }
    
     func initData()
    {
        let query = PFQuery(className:"PA")
        var i : Int = 0
        print("In init main data")
        
         query.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            if error == nil {
                print("obj count : \(objects?.count)")
                var temp = [UIImage](count: (objects?.count)!, repeatedValue: UIImage(named: "bg4.jpg")!)
                
                for x in objects! {
                    self.data.append([])
                    self.data[i].append(x.valueForKey("Name") as! String!)
                    self.data[i].append(x.valueForKey("Status") as! String!)
                    self.data[i].append(x.valueForKey("Type") as! String!)
                    self.data[i].append(x.valueForKey("Details") as! String!)
                    self.data[i].append(x.valueForKey("objectId") as! String!)

                    let userImageFile : PFFile = x["imageFile"] as! PFFile
                    userImageFile.getDataInBackgroundWithBlock({(imageData: NSData?, error NSError) -> Void in
                        if (error == nil) {
                            let imaged = UIImage(data:imageData!)
                        //    self.images.append(imaged!)
                            
                            for j in 0..<self.data.count
                            {
                            if(self.data[j][4] == x.valueForKey("objectId") as! String!)
                            {
                                self.total++
                            temp.removeAtIndex(j)
                            temp.insert(imaged!, atIndex: j)
                            print("Image retrieved")
                            }
                            }
                            
                            if self.total == objects?.count
                            {
                                self.flag = 1
                                
                                for k in 0..<self.data.count
                                {
                                    self.images.append(temp[k])
                                }
                                
                                self.tableView.reloadData()
                            }
                        }
                        else
                        {
                            print("Cannot retrieve image")
                        }
                    })
                    i++
                }
            } else {
                print(error)
            }
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "detail" {
            let cell = sender as! UITableViewCell
            let x = self.tableView.indexPathForCell(cell)
            let col : Int = (x?.row)! as Int
            print(" X : \(x?.row), col : \(col)")
            let dc = (segue.destinationViewController as! PetDetailControllerViewController)
            dc.name = data[col][0]
            dc.img = images[col]
            dc.details = "Name : \(data[col][0])"+"\r\n"+"\(data[col][1]) \(data[col][2]) \r\n"+data[col][3]
        }
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return data.count
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("myPetCell", forIndexPath: indexPath) as! PetTableViewCell
        
        print("In cell")
        // Configure the cell...
        cell.PetName.text = data[indexPath.row][0]
        cell.PetDetail.text = data[indexPath.row][1]+" "+data[indexPath.row][2]

               
        if flag == 1
        {
            print("in flag")
         //   cell.PetImage.image = images[indexPath.row]
            
            let cellImage = images[indexPath.row]
            let logoSize = CGSizeMake(200, 105)
            UIGraphicsBeginImageContext(logoSize)
            let imgRect = CGRectMake(0, 5, logoSize.width-60, logoSize.height-5)
            cellImage.drawInRect(imgRect)
            cell.PetImage.image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsGetCurrentContext()

        }
        
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
