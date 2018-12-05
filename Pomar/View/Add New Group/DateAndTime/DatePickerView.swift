//
//  DatePickerView.swift
//  Pomar
//
//  Created by Alan Victor Paulino de Oliveira on 03/12/18.
//  Copyright © 2018 Paloma Bispo. All rights reserved.
//

import UIKit

protocol DatePickerViewDelegate: class {
    func getDateFromPickerView() -> Date
}

class DatePickerView: UIView{

    @IBOutlet var contentView: DatePickerView!
    @IBOutlet weak var datePickerView: UIDatePicker!
    var delegate: DatePickerViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed("DatePickerView", owner: self, options: nil)
        addSubview(contentView)
        
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        datePickerView.minimumDate = Date()
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

extension DatePickerView: DatePickerViewDelegate{
    func getDateFromPickerView() -> Date {
        let date = datePickerView.date
        return date
    }
    
    
}
