//
//  DateCollectionViewCell.swift
//  Pomar
//
//  Created by Paloma Bispo on 03/12/18.
//  Copyright © 2018 Paloma Bispo. All rights reserved.
//

import UIKit

class DateCollectionViewCell: UICollectionViewCell {


    @IBOutlet weak var hourView: UIView!
    @IBOutlet weak var dayView: UIView!
    @IBOutlet weak var labelMonth: UILabel!
    @IBOutlet var dates: [UIView]!
    @IBOutlet var hours: [UILabel]!
    @IBOutlet var datesLabels: [UILabel]!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        hourView.layer.borderColor = UIColor.init(red: 70/255, green: 70/255, blue: 70/255, alpha: 1).cgColor
        hourView.layer.borderWidth = 0.5
        hourView.clipsToBounds = true
        hourView.layer.cornerRadius = 10
        
        dayView.layer.borderColor = UIColor.init(red: 70/255, green: 70/255, blue: 70/255, alpha: 1).cgColor
        dayView.layer.borderWidth = 0.5
        dayView.clipsToBounds = true
        dayView.layer.cornerRadius = 10
        
        for view in dates{
            view.layer.borderColor = UIColor.init(red: 70/255, green: 70/255, blue: 70/255, alpha: 1).cgColor
            view.layer.borderWidth = 0.5
            view.clipsToBounds = true
            view.layer.cornerRadius = view.frame.width/2
        }
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        layoutIfNeeded()
        let layoutAttributes = super.preferredLayoutAttributesFitting(layoutAttributes)
        layoutAttributes.bounds.size = systemLayoutSizeFitting(UIView.layoutFittingCompressedSize, withHorizontalFittingPriority: .required, verticalFittingPriority: .defaultLow)
        return layoutAttributes
    }


}
