//
//  ButtonsCollectionViewCell.swift
//  Pomar
//
//  Created by Paloma Bispo on 03/12/18.
//  Copyright © 2018 Paloma Bispo. All rights reserved.
//

import UIKit

class ButtonsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var joinButton: UIButton!
    @IBOutlet weak var feedbackButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        joinButton.clipsToBounds = true
        joinButton.layer.cornerRadius = 10
        feedbackButton.clipsToBounds = true
        feedbackButton.layer.cornerRadius = 10
        // Initialization code
    }

}
