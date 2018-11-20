//
//  Validation.swift
//  Pomar
//
//  Created by Paloma Bispo on 19/11/18.
//  Copyright © 2018 Paloma Bispo. All rights reserved.
//

import Foundation
import UIKit


class Validation {
    
    static func textFieldsIsEmpty( textFields: [UITextField]) -> Bool{
        
        let emptyTextFields = textFields.filter { (textField) -> Bool in
            return textField.text == ""
        }
        return !emptyTextFields.isEmpty
        
    }
    
    static func textViewsIsEmpty(textViews: [UITextView]) -> Bool{
        
        let emptytextViews = textViews.filter { (textView) -> Bool in
            return textView.text == ""
        }
        return !emptytextViews.isEmpty
        
    }
}
