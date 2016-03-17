//
//  PetDetailInfoDisplayViewController.swift
//  PawsAlert
//
//  Created by PALLE SAIPRASANNA  on 3/16/16.
//  Copyright © 2016 Rohit Nutalapati. All rights reserved.
//

import UIKit

class PetDetailInfoDisplayViewController: UIViewController {

    @IBOutlet weak var details: UITextView!
    @IBOutlet weak var img: UIImageView!
    
    
    var detail_String: String!
    var imageFile: PFFile!
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.details.text = self.detail_String
        
        
        self.imageFile.getDataInBackgroundWithBlock({ (imageData, error) -> Void in
            if error == nil
            {
                if let imageData = imageData
                {
                    let image = UIImage(data:imageData)
                    self.img.image = image
                }
            }
        })
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
