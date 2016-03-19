//
//  ReportViewController.swift
//  PawsAlert
//
//  Created by Rohit Nutalapati on 2/1/16.
//  Copyright © 2016 Rohit Nutalapati. All rights reserved.
//

import UIKit
import MobileCoreServices
//import AVFoundation

extension UIImage
{
    var highestQualityJPEGNSData: NSData { return UIImageJPEGRepresentation(self, 1.0)! }
    var highQualityJPEGNSData: NSData    { return UIImageJPEGRepresentation(self, 0.75)!}
    var mediumQualityJPEGNSData: NSData  { return UIImageJPEGRepresentation(self, 0.5)! }
    var lowQualityJPEGNSData: NSData     { return UIImageJPEGRepresentation(self, 0.25)!}
    var lowestQualityJPEGNSData: NSData  { return UIImageJPEGRepresentation(self, 0.0)! }
}

class ReportViewController: UIViewController,UIPickerViewDataSource,UIImagePickerControllerDelegate,UIPickerViewDelegate,UITextFieldDelegate, UINavigationControllerDelegate,UITextViewDelegate {
    
    var pickerViewData = ["Puppy","Kitten","Rabbit", "Dog", "Duck","Parrot","Piglet"]
    var pickerViewSelected : String = ""
    var cameraImage : Bool?
    
    var lostSelected = true
    let foundPawSelected : UIImage = UIImage(named: "FOUND_PAW_SELECTED")!
    let foundPaw : UIImage = UIImage(named: "FOUND_PAW")!
    let lostPawSelected : UIImage = UIImage(named: "LOST_PAW_SELECTED")!
    let lostPaw : UIImage = UIImage(named: "LOST_PAW")!
    var str : String = "Found"

    
    
   /*
    //AVSession
    let captureSession = AVCaptureSession()
    var outputImage : AVCaptureStillImageOutput!
    var captureDevice : AVCaptureDevice?
    var previewLayer : AVCaptureVideoPreviewLayer?
    */
    struct PetSet {
        
        var Status : String
        var Type : String
        var Name : String
        var Details : String
        var Image : UIImage
        
    }
    
    @IBOutlet weak var lostButton: UIButton!
    @IBOutlet weak var foundButton: UIButton!
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var PetTypePickerView: UIPickerView!
    @IBOutlet weak var PetNameOutLet: UITextField!
    @IBOutlet weak var PetDetailsOutlet: UITextView!
    var PetImage : UIImage = UIImage(named: "No_Image_Paw")!
    @IBAction func SubmitAction(sender: UIButton) {
        
        if lostSelected {
            str = "Lost"
        }
        
        let Pet : PetSet = PetSet(
        
            
            
            Status : str,//StatusOutlet.titleForSegmentAtIndex(StatusOutlet.selectedSegmentIndex)!,
            Type : pickerViewSelected,
            Name : PetNameOutLet.text! ,
            Details : PetDetailsOutlet.text,
            Image: PetImage//UIImage(named: "CatsAndDog")!
            
        )
        print(Pet)
        
        let name : String = PetNameOutLet.text! as String
        let type : String = pickerViewSelected as String
        let status_String : String = str as String
        let details_String : String = PetDetailsOutlet.text as String
        
        let object = PFObject(className: "PA")
        object.setObject(name, forKey: "Name")
        object.setObject(type, forKey: "Type")
        object.setObject(status_String, forKey: "Status")
        object.setObject(details_String, forKey: "Details")
        object["fromUser"] = PFUser.currentUser()

        //  object.saveInBackground()
        
        
        // Save image to database
        let img : UIImage = Pet.Image
        let imageData = img.lowestQualityJPEGNSData//UIImagePNGRepresentation(img)
        let imageFile: PFFile = PFFile(data: imageData)!
        
        //    let userPhoto = PFObject(className: "TestClass")
        object["imageFile"] = imageFile
        
        
        
        object.saveInBackgroundWithBlock {
            (success: Bool, error: NSError?) -> Void in
            if error != nil {
                let alert = UIAlertController(
                    title: "Message",
                    message: "Cannot report Pet. Try again later",
                    preferredStyle: UIAlertControllerStyle.Alert)
                
                
                alert.addAction(UIAlertAction(
                    title: "OK",
                    style: UIAlertActionStyle.Default,
                    handler: nil
                    ))
                self.presentViewController(alert, animated: true, completion: nil)
              //  self.navigationController?.popViewControllerAnimated(true)
                
                self.PetNameOutLet.text = ""
                self.PetDetailsOutlet.text = ""
                
            } else {
                
                let alert = UIAlertController(
                    title: "Message",
                    message: "Pet successfully addded",
                    preferredStyle: UIAlertControllerStyle.Alert
                )
                
                    alert.addAction(UIAlertAction(
                        title: "OK",
                        style: UIAlertActionStyle.Default,
                        handler: nil
                        ))
                    self.presentViewController(alert, animated: true, completion: nil)
                self.PetNameOutLet.text = ""
                self.PetDetailsOutlet.text = ""
        
      //  self.navigationController?.popViewControllerAnimated(true)
            }
            
        }
        
    }
    
    
    @IBAction func LostPawAction(sender: AnyObject) {
        
        
        if lostSelected {
        lostButton.setImage(lostPawSelected, forState: .Normal)
        }else{
        lostButton.setImage(lostPaw, forState: .Normal)
        lostSelected = !lostSelected
        }
        
        if !lostSelected {
            foundButton.setImage(foundPawSelected, forState: .Normal)
            
        }else{
            foundButton.setImage(foundPaw, forState: .Normal)
            
        }
    }
    
    @IBAction func FoundPawAction(sender: AnyObject) {
        
        lostSelected = !lostSelected
        
        
        if lostSelected {
            lostButton.setImage(lostPawSelected, forState: .Normal)
        }else{
            lostButton.setImage(lostPaw, forState: .Normal)
        }
        
        if !lostSelected {
            foundButton.setImage(foundPawSelected, forState: .Normal)
            lostSelected = !lostSelected
            
        }else{
            foundButton.setImage(foundPaw, forState: .Normal)
            
        }
        
    }
    
    
    
    

    @IBAction func useCamera(sender: AnyObject) {
        
        if UIImagePickerController.isSourceTypeAvailable(
            UIImagePickerControllerSourceType.Camera) {
                
                let imagePicker = UIImagePickerController()
                
                imagePicker.sourceType =
                    UIImagePickerControllerSourceType.Camera
                imagePicker.mediaTypes = [kUTTypeImage as String]
                imagePicker.allowsEditing = false
                
                self.presentViewController(imagePicker, animated: true, 
                    completion: nil)
                cameraImage = true
        }
    }
    
    @IBAction func useCameraRoll(sender: AnyObject) {
        
        if UIImagePickerController.isSourceTypeAvailable(
            UIImagePickerControllerSourceType.SavedPhotosAlbum) {
                let imagePicker = UIImagePickerController()
                
                imagePicker.delegate = self
                imagePicker.sourceType =
                    UIImagePickerControllerSourceType.PhotoLibrary
                imagePicker.mediaTypes = [kUTTypeImage as NSString as String ]
                imagePicker.allowsEditing = false
                self.presentViewController(imagePicker, animated: true, completion: nil)
                cameraImage = false
                
        }
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
    
        let mediaType = info[UIImagePickerControllerMediaType] as! String
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
        
        if mediaType == (kUTTypeImage as String) {
            let image = info[UIImagePickerControllerOriginalImage]
                as! UIImage
            
            imageView.image = image // GET IMAGE HERE <<<===
            PetImage = image
            
            if (cameraImage == true) {
                UIImageWriteToSavedPhotosAlbum(image, self,
                    "image:didFinishSavingWithError:contextInfo:", nil)
            }
        }
    }
    
    func image(image: UIImage, didFinishSavingWithError error: NSErrorPointer, contextInfo:UnsafePointer<Void>) {
        
        if error != nil {
            let alert = UIAlertController(title: "Save Failed",
                message: "Failed to save image",
                preferredStyle: UIAlertControllerStyle.Alert)
            
            let cancelAction = UIAlertAction(title: "OK",
                style: .Cancel, handler: nil)
            
            alert.addAction(cancelAction)
            self.presentViewController(alert, animated: true,
                completion: nil)
        }
    } 

    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }

    func keyboardWillShow(sender: NSNotification) {
        self.view.frame.origin.y = -150
    }
    
    func keyboardWillHide(sender: NSNotification) {
        self.view.frame.origin.y = 0
    }
    
    func textViewDidBeginEditing(textView: UITextView) {
       
        textView.delegate = self
        if textView.tag == 1 && textView.text == "Enter details here..."{
            textView.text = ""
        }
        
    }
    
    func textViewDidEndEditing(textView: UITextView){
    
        if textView.tag == 1 && textView.text == ""{
            textView.text = "Enter details here..."
        }
        textView.resignFirstResponder()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow:"), name:UIKeyboardWillShowNotification, object: nil);
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name:UIKeyboardWillHideNotification, object: nil);
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
        
        UIGraphicsBeginImageContext(self.view.frame.size)
        UIImage(named: "bg4.jpg")?.drawInRect(self.view.bounds)
        let image: UIImage! = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.view.backgroundColor = UIColor(patternImage: image)

        lostButton.setImage(lostPawSelected, forState: .Normal)
        foundButton.setImage(foundPaw, forState: .Normal)
        
        imageView.image = UIImage(named: "No_Image_Paw")
        PetTypePickerView.dataSource = self
        PetTypePickerView.delegate = self
        pickerViewSelected = pickerViewData[0]
        
        PetDetailsOutlet.text = "Enter details here..."
        
        PetDetailsOutlet.tag = 1
        PetDetailsOutlet.delegate = self
        

        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerViewData.count
    }
    
    func pickerView(pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let myString = NSAttributedString(string: pickerViewData[row], attributes: [NSForegroundColorAttributeName : UIColor.whiteColor()])
        return myString
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
     //   myLabel.text = pickerData[row]
        pickerViewSelected = pickerViewData[row]
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
