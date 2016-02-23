//
//  ReportViewController.swift
//  PawsAlert
//
//  Created by Rohit Nutalapati on 2/1/16.
//  Copyright © 2016 Rohit Nutalapati. All rights reserved.
//

import UIKit

class ReportViewController: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate,UITextFieldDelegate {
    
    var pickerViewData = ["Puppy","Kitten","Rabbit", "Dog", "Duck","Parrot"]
    var pickerViewSelected : String = ""
    
    struct PetSet {
        
        var Status : String
        var Type : String
        var Name : String
        var Details : String
        var Image : UIImage
        
    }
    
    @IBOutlet weak var StatusOutlet: UISegmentedControl!
    @IBOutlet weak var PetTypePickerView: UIPickerView!
    @IBOutlet weak var PetNameOutLet: UITextField!
    @IBOutlet weak var PetDetailsOutlet: UITextView!
    @IBAction func SubmitAction(sender: UIButton) {
        
        let Pet : PetSet = PetSet(
        
            Status : StatusOutlet.titleForSegmentAtIndex(StatusOutlet.selectedSegmentIndex)!,
            Type : pickerViewSelected,
            Name : PetNameOutLet.text! ,
            Details : PetDetailsOutlet.text,
            Image: UIImage(named: "CatsAndDog")!
            
        )
        print(Pet)
        
        let object = PFObject(className: "PawsAlertClass")
        object.addObject(Pet.Name, forKey: "Name")
        object.addObject(Pet.Type, forKey: "Type")
        object.addObject(Pet.Status, forKey: "Status")
        object.addObject(Pet.Details, forKey: "Details")

        //  object.saveInBackground()
        
        
        // Save image to database
        let img : UIImage = Pet.Image
        let imageData = UIImagePNGRepresentation(img)
        let imageFile: PFFile = PFFile(data: imageData!)!
        
        //    let userPhoto = PFObject(className: "TestClass")
        object["imageFile"] = imageFile
        object.saveInBackground()
        
    }
    


    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIGraphicsBeginImageContext(self.view.frame.size)
        UIImage(named: "bg4.jpg")?.drawInRect(self.view.bounds)
        let image: UIImage! = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.view.backgroundColor = UIColor(patternImage: image)

        

        
        PetTypePickerView.dataSource = self
        PetTypePickerView.delegate = self
        pickerViewSelected = pickerViewData[0]
        
        PetDetailsOutlet.text = "Enter details here..."
        
        self.PetNameOutLet.delegate = self
        if(self.PetDetailsOutlet.focused){
            PetDetailsOutlet.text = ""
        }

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
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerViewData[row]
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
