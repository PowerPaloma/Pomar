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
    @IBOutlet weak var redView: UIImageView!
    @IBOutlet weak var yellowView: UIImageView!
    @IBOutlet weak var greenView: UIImageView!
    
    var user: User?
    
    var selectedApple: SelectedApple = .black {
        
        didSet {
            
            var color: UIColor?
            
            switch selectedApple {
                case .red:
                    UIView.animate(withDuration: 0.5, animations: {
                        self.redView.tintColor = UIColor.red
                    })
                case .yellow:
                    UIView.animate(withDuration: 0.5, animations: {
                        self.yellowView.tintColor = UIColor.green
                    })
                case .green:
                    UIView.animate(withDuration: 0.5, animations: {
                        self.greenView.tintColor = UIColor.orange
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
        redView.image = redView.image?.withRenderingMode(.alwaysTemplate)
        redView.tintColor = UIColor.clear
        
        yellowView.layer.contents = UIImage(named: "apple-vector")
        yellowView.image = redView.image?.withRenderingMode(.alwaysTemplate)
        yellowView.tintColor = UIColor.clear
        
        greenView.layer.contents = UIImage(named: "apple-vector")
        greenView.image = redView.image?.withRenderingMode(.alwaysTemplate)
        greenView.tintColor = UIColor.clear
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.layer.cornerRadius = self.frame.width/2
        imageView.layer.borderColor = UIColor.gray.cgColor
//        imageView.layer.borderWidth = 3.0
    }

}
