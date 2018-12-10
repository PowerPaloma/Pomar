//
//  MonthsCollectionViewCell.swift
//  Pomar
//
//  Created by Paloma Bispo on 08/12/18.
//  Copyright © 2018 Paloma Bispo. All rights reserved.
//

import UIKit

class MonthCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var background: UIView!
    @IBOutlet weak var monthLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override var isSelected: Bool{
        didSet{
            if self.isSelected
            {
                self.transform = CGAffineTransform(scaleX: 1.15, y: 1.15)
//                self.background.backgroundColor = UIColor(red: 58/255, green: 199/255, blue: 95/255, alpha: 0.6)
                self.monthLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            }
            else
            {
                self.transform = CGAffineTransform.identity
//                self.background.backgroundColor =  UIColor(red: 58/255, green: 199/255, blue: 95/255, alpha: 0.29)
                self.monthLabel.textColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
            }
        }
    }

}
