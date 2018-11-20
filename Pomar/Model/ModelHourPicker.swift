//
//  ModelDayPicker.swift
//  Pomar
//
//  Created by Paloma Bispo on 19/11/18.
//  Copyright © 2018 Paloma Bispo. All rights reserved.
//

import Foundation
import UIKit


class HourPicker: NSObject, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var hours: [String] = []
    var minutes: [String] = []
    
    override init() {
        for i in 14...18{
            hours.append(String(i))
        }
        minutes = ["00", "15", "30", "45"]
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return hours.count
        case 1:
            return minutes.count
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0:
            return hours[row]
        case 1:
            return minutes[row]
        default:
            return ""
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
    }
    
    
    
}
