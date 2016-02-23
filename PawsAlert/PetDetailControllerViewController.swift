//
//  PetDetailControllerViewController.swift
//  PawsAlert
//
//  Created by PALLE SAIPRASANNA  on 2/22/16.
//  Copyright © 2016 Rohit Nutalapati. All rights reserved.
//

import UIKit

class PetDetailControllerViewController: UIViewController {

    @IBOutlet weak var PetDetails: UITextView!
    @IBOutlet weak var PetName: UILabel!
    @IBOutlet weak var PetImg: UIImageView!
    
     var name : String = ""
    var img : UIImage = UIImage()
    var details : String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        /*view.backgroundColor = UIColor(patternImage: UIImage(named: "bg4.jpg")!)
        let blur = UIBlurEffect(style: UIBlurEffectStyle.Dark)
        let blurView = UIVisualEffectView(effect: blur)
        view.insertSubview(blurView, atIndex: 0)
        */
        
        UIGraphicsBeginImageContext(self.view.frame.size)
        UIImage(named: "bg4.jpg")?.drawInRect(self.view.bounds)
        let image: UIImage! = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.view.backgroundColor = UIColor(patternImage: image)
        
        PetName.text = name
        PetImg.image = img
        PetDetails.text = details
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
