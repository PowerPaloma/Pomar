//
//  DateAndTime.swift
//  Pomar
//
//  Created by Paloma Bispo on 03/12/18.
//  Copyright © 2018 Paloma Bispo. All rights reserved.
//

import UIKit

class DateAndTime: UIView, Instantiable {

    @IBOutlet weak var labelMonth: UILabel!
    @IBOutlet weak var stackHours: UIStackView!
    @IBOutlet weak var stackDate: UIStackView!
    @IBOutlet var contentView: UIView!
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.myInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.myInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.myInit()
    }
    
    private func myInit(){
        Bundle.main.loadNibNamed("DateAndTime", owner: self, options: nil)
        self.addSubview(contentView)
        contentView.frame = self.bounds
//        for view in stackDate.arrangedSubviews{
//            view.clipsToBounds = true
//            view.layer.cornerRadius = view.frame.width / 2
//        }
        
    }
    
}
