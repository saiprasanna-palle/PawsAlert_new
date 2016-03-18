//
//  DonationViewController.swift
//  PawsAlert
//
//  Created by KASUVAJJALA DEEPTHI  on 3/16/16.
//  Copyright © 2016 Rohit Nutalapati. All rights reserved.
//

import UIKit

class DonationViewController: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate {
    var MonthNames = ["Month","January", "February", "March", "April", "May"]
    var Years = ["Year","2016", "2017", "2018", "2019", "2020"]
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
        AmountField.text = tenDollar.titleLabel?.text
        Amount = "10"
    }
    
    @IBAction func twentyFive(sender: AnyObject) {
         AmountField.enabled = false
         AmountField.text = twentyFiveDollar.titleLabel?.text
        Amount = "25"
    }
    
    @IBAction func fifty(sender: AnyObject) {
         AmountField.enabled = false
         AmountField.text = FiftyDollar.titleLabel?.text
        Amount = "50"
    }
    
    @IBAction func Hundred(sender: AnyObject) {
        AmountField.enabled = false
         AmountField.text = HundredDollar.titleLabel?.text
        Amount = "100"
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
        AmountField.text = ""
        FirstName.text = ""
        LastName.text = ""
        CardNum.text = ""
        MonthPicker.selectRow(0, inComponent: 0, animated: true)
        DatePicker.selectRow(0, inComponent: 0, animated: true)
        SecCode.text = ""
        self.navigationController?.popViewControllerAnimated(true)
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
