//
//  UserViewCell.swift
//  Pomar
//
//  Created by Mateus Rodrigues on 29/11/18.
//  Copyright © 2018 Paloma Bispo. All rights reserved.
//

import UIKit

class UserViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var redView: UIView!
    @IBOutlet weak var yellowView: UIView!
    @IBOutlet weak var greenView: UIView!
    
    var user: User?
    
    var selectedApple: SelectedApple = .black {
        
        didSet {
            
            var color: UIColor?
            
            switch selectedApple {
                case .red:
                    UIView.animate(withDuration: 0.5, animations: {
                        self.redView.backgroundColor = UIColor.red
                    })
                case .yellow:
                    UIView.animate(withDuration: 0.5, animations: {
                        self.yellowView.backgroundColor = UIColor.yellow
                    })
                case .green:
                    UIView.animate(withDuration: 0.5, animations: {
                        self.greenView.backgroundColor = UIColor.orange
                    })
                case .black:
                    break;
                default:
                    break
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        redView.layer.contents = UIImage(named: "apple-vector")
        
        redView.backgroundColor = UIColor.clear
        yellowView.backgroundColor = UIColor.clear
        greenView.backgroundColor = UIColor.clear
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.layer.cornerRadius = self.frame.width/2
        imageView.layer.borderColor = UIColor.gray.cgColor
//        imageView.layer.borderWidth = 3.0
        redView.layer.cornerRadius = (self.frame.width*0.3)/2
        yellowView.layer.cornerRadius = (self.frame.width*0.3)/2
        greenView.layer.cornerRadius = (self.frame.width*0.3)/2
    }

}
