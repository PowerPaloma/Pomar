//
//  ModelDayPicker.swift
//  Pomar
//
//  Created by Paloma Bispo on 19/11/18.
//  Copyright © 2018 Paloma Bispo. All rights reserved.
//

import Foundation
import UIKit


class DayPicker: NSObject, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    var days: [String] = []
    var months: [String] = []
    let fmt = DateFormatter()
    let textFieldDelegate: TextFieldProtocol? = nil
    
    override init() {
        for i in 1...31{
            if i < 12{
                months.append(fmt.monthSymbols[i])
            }
            days.append(String(i))
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }

    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return days.count
        case 1:
            return months.count
        default:
            return 0 
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0:
            return days[row]
        case 1:
            return months[row]
        default:
            return ""
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch component {
        case 0:
            textFieldDelegate?.send(isFirstComponent: true, text: days[row])
        case 1:
            textFieldDelegate?.send(isFirstComponent: false, text: days[row])
        default:
            textFieldDelegate?.send(isFirstComponent: false, text: "")
        }
        
    }


    
}
