//
//  DayCollectionViewCell.swift
//  Pomar
//
//  Created by Paloma Bispo on 08/12/18.
//  Copyright © 2018 Paloma Bispo. All rights reserved.
//

import UIKit

class DayCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var background: UIView!
    @IBOutlet weak var dayLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override var isSelected: Bool{
        didSet{
            if self.isSelected {
                self.dayLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                self.background.backgroundColor = #colorLiteral(red: 0.2589761913, green: 0.8057302833, blue: 0.4474651814, alpha: 0.3603392551)
            }else{
                self.dayLabel.textColor = #colorLiteral(red: 0.5606647134, green: 0.5573351979, blue: 0.5632262826, alpha: 1)
                self.background.backgroundColor = #colorLiteral(red: 0.9628338218, green: 0.9729439616, blue: 0.9768897891, alpha: 1)

            }
        }
    }

}
