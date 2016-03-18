//
//  DonationViewController.swift
//  PawsAlert
//
//  Created by KASUVAJJALA DEEPTHI  on 3/16/16.
//  Copyright © 2016 Rohit Nutalapati. All rights reserved.
//

import UIKit

class DonationViewController: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate {
    var MonthNames = ["January", "February", "March", "April", "May","June","July","August","September","October","November","December"]
    var Years = ["2016", "2017", "2018", "2019", "2020","2021","2022","2023","2024","2025"]
    var Fname : String = ""
    var Lname : String = ""
    var cardNumber : String = ""
    var Amount : String = ""
    var ExpMonth: String = ""
    var ExpYr: String = ""
    var SCode: String = ""
    var rowMonthNum: Int = 0
    var rowYrNum: Int = 0
    var senderButton : String = ""
    
    @IBOutlet weak var Titlelabel: UILabel!
    
    @IBOutlet weak var messsageLabel: UITextView!
    
    @IBOutlet weak var tenDollar: UIButton!
    @IBOutlet weak var twentyFiveDollar: UIButton!
    @IBOutlet weak var FiftyDollar: UIButton!
    @IBOutlet weak var HundredDollar: UIButton!
    @IBOutlet weak var OtherAmount: UIButton!
    
    @IBOutlet weak var AmountField: UITextField!
    
    @IBOutlet weak var FirstName: UITextField!
   
  
    
    @IBOutlet weak var LastName: UITextField!
    
    @IBOutlet weak var CardNum: UITextField!
    
    @IBOutlet weak var MonthPicker: UIPickerView!
    
    @IBOutlet weak var DatePicker: UIPickerView!
    
    @IBOutlet weak var SecCode: UITextField!
    
    
  

    @IBAction func tenDollar(sender: AnyObject) {
         AmountField.enabled = false
        AmountField.text = "10"
    }
    
    @IBAction func twentyFive(sender: AnyObject) {
         AmountField.enabled = false
         AmountField.text = "25"
    }
    
    @IBAction func fifty(sender: AnyObject) {
         AmountField.enabled = false
         AmountField.text = "50"
    }
    
    @IBAction func Hundred(sender: AnyObject) {
        AmountField.enabled = false
         AmountField.text = "100"
    }
    
    @IBAction func OtherAmount(sender: AnyObject) {
        if(AmountField.text != "")
        {
          AmountField.text = ""
          AmountField.enabled = true
        }
        else
        {
            AmountField.enabled = true
            Amount = AmountField.text!
        }
    }
    
    @IBAction func Submit(sender: AnyObject) {
        Fname = FirstName.text!
        Lname = LastName.text!
        cardNumber = CardNum.text!
        SCode = SecCode.text!
        Amount = AmountField.text!
        
        if (Fname != "" && Lname != "" && cardNumber != "" && SCode != "" && Amount != "")
        {
            print("No null fields")
        do
        {
            
           let cardnum = try Int32(cardNumber)
            let secCode = try Int(SCode)
            let amt = try Int(Amount)
            print(AmountField.text!)
            print(amt)
            
            if (cardNumber.characters.count != 16)
            {
                let alert = UIAlertController(
                    title: "Error",
                    message: "Card number should be only 16 digits",
                    preferredStyle: UIAlertControllerStyle.Alert
                )
                alert.addAction(UIAlertAction(
                    title: "OK",
                    style: UIAlertActionStyle.Default,
                    handler: nil
                    ))
                self.presentViewController(alert, animated: true, completion: nil)


            }
            
           else if (SCode.characters.count != 3)
            {
                let alert = UIAlertController(
                    title: "Error",
                    message: "Security code can only be 3 digits",
                    preferredStyle: UIAlertControllerStyle.Alert
                )
                
                alert.addAction(UIAlertAction(
                    title: "OK",
                    style: UIAlertActionStyle.Default,
                    handler: nil
                    ))
                self.presentViewController(alert, animated: true, completion: nil)

            }
                
            
            else
            {
                print("All fields validated")
                let object = PFObject(className: "Donation")
                object.setObject(amt!, forKey: "Amount")
                object["fromUser"] = PFUser.currentUser()
                object.saveInBackgroundWithBlock {
                    (success: Bool, error: NSError?) -> Void in
                    if error != nil {
                        let alert = UIAlertController(
                            title: "Message",
                            message: "Donation cannot me made. Try again later",
                            preferredStyle: UIAlertControllerStyle.Alert)
                            
                            alert.addAction(UIAlertAction(
                                title: "OK",
                                style: UIAlertActionStyle.Default,
                                handler: nil
                                ))
                            self.presentViewController(alert, animated: true, completion: nil)
                            self.navigationController?.popViewControllerAnimated(true)
                        
                    } else {
                        
                        let alert = UIAlertController(
                            title: "Message",
                            message: "You have successfully made your Donation.",
                            preferredStyle: UIAlertControllerStyle.Alert
                        )
                        
                        alert.addAction(UIAlertAction(
                            title: "OK",
                            style: UIAlertActionStyle.Default,
                            handler: nil
                            ))
                      self.presentViewController(alert, animated: true, completion: nil)
                        self.AmountField.text = ""
                        self.FirstName.text = ""
                        self.LastName.text = ""
                        self.CardNum.text = ""
                        self.MonthPicker.selectRow(0, inComponent: 0, animated: true)
                        self.DatePicker.selectRow(0, inComponent: 0, animated: true)
                        self.SecCode.text = ""
                      //self.navigationController?.popViewControllerAnimated(true)

                    }
                }
                        }
            
        }
            catch
            {
                print("In catch")
                let alert = UIAlertController(
                    title: "Error",
                    message: "Card number/Security/Amount should be numeric",
                    preferredStyle: UIAlertControllerStyle.Alert
                )
                alert.addAction(UIAlertAction(
                    title: "OK",
                    style: UIAlertActionStyle.Default,
                    handler: nil
                    ))
                self.presentViewController(alert, animated: true, completion: nil)

            }
            
        }
        
        else
        {
            print("In outer else")
            let alert = UIAlertController(
                title: "Error",
                message: "Please fill all details",
                preferredStyle: UIAlertControllerStyle.Alert
            )
            alert.addAction(UIAlertAction(
                title: "OK",
                style: UIAlertActionStyle.Default,
                handler: nil
                ))
            self.presentViewController(alert, animated: true, completion: nil)
        }
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
       // self.navigationItem.leftBarButtonItem?.enabled = YES
        //write in save nethod
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "bg4.jpg")!)
        
        messsageLabel.layer.borderWidth = 0
        messsageLabel.layer.backgroundColor = UIColor(patternImage: UIImage(named: "bg4.jpg")!).CGColor

        if (senderButton == "Donate Money")
        {
            Titlelabel.text = "Make a Donation!!"
            messsageLabel.text = "Thank You for considering making a Donation to Stillwater Animal Welfare Coalition."
        }
        if (senderButton == "Furless Fostering")
        {
            Titlelabel.text = "Sponsor the furless animals!!"
            messsageLabel.text = "Thank You for considering to sponsor animals at the Stillwater Animal Welfare. The sponsorship would help the furless animals to recover."
            self.title = "Furless Fostering"
            
        }
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        if(pickerView.tag == 0 || pickerView.tag == 1)
        {
        return 1
        }
        else
        {
        return 0
        }
        
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
         if(pickerView.tag == 0)
         {
        return MonthNames.count
        }
        if(pickerView.tag == 1)
         {
             return Years.count
        }
        else
        {
            return 0
        }
        
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        
        
        if(pickerView.tag == 0)
        {
            return MonthNames[row]
        }
        if(pickerView.tag == 1)
        {
            return Years[row]
        }
        else
        {
            return ""
        }
        
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
      
        if(pickerView.tag == 0)
        {
           rowMonthNum = row
           ExpMonth = MonthNames[rowMonthNum]
           

        }
        if(pickerView.tag == 1)
        {
            rowYrNum = row
            ExpYr = Years[rowYrNum]
            

        }
    }
    
    
    
   /* func numberOfComponentsInPickerView(DatePicker: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(DatePicker: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return MonthNames.count
    }
    
    func pickerView(DatePicker: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return MonthNames[row]
    }*/

}
