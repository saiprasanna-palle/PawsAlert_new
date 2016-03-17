//
//  YearPicker.swift
//  PawsAlert
//
//  Created by KASUVAJJALA DEEPTHI  on 3/16/16.
//  Copyright © 2016 Rohit Nutalapati. All rights reserved.
//


class YearPicker: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate {
    
    var Years = ["2016", "2017", "2018", "2019", "2020"]

    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Years.count
        
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        return Years[row]
    }


}