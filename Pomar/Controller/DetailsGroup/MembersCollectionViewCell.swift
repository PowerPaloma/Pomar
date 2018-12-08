//
//  MembersCollectionViewCell.swift
//  Pomar
//
//  Created by Paloma Bispo on 04/12/18.
//  Copyright © 2018 Paloma Bispo. All rights reserved.
//

import UIKit

class MembersCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var imageMenber: UIImageView!
    var imageAux: UIImage? {
        didSet {
            imageMenber.image = imageAux
            if imageAux != nil {
                indicator.stopAnimating()
                indicator.isHidden = true
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        indicator.startAnimating()
    }
        
    
}
