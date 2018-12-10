//
//  UserViewCell.swift
//  Pomar
//
//  Created by Mateus Rodrigues on 29/11/18.
//  Copyright © 2018 Paloma Bispo. All rights reserved.
//

import UIKit

class UserViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView! {
        didSet {
            
        }
    }
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var redView: UIImageView!
    @IBOutlet weak var yellowView: UIImageView!
    @IBOutlet weak var greenView: UIImageView!
    
    var user: User?
    
    var image: UIImage? {
        didSet {
            imageView.image = image
            if image != nil {
                activityIndicator.stopAnimating()
                activityIndicator.isHidden = true
            }
        }
    }
    
    var redApple: Bool = false
    var yellowApple: Bool = false
    var greenApple: Bool = false
    
    var selectedApple: AppleType? {
        didSet {
            var selectedView: UIImageView?
            switch selectedApple {
                case .red?:
                    redApple = true
                    selectedView = redView
                case .yellow?:
                    yellowApple = true
                    selectedView = yellowView
                case .green?:
                    greenApple = true
                    selectedView = greenView
                default:
                    break
            }
            
            UIView.animate(withDuration: 0.5, animations: {
                selectedView?.tintColor = self.selectedApple?.color()
            })
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        activityIndicator.startAnimating()
        
        redView.image = redView.image?.withRenderingMode(.alwaysTemplate)
        redView.tintColor = UIColor.clear
        
        yellowView.image = redView.image?.withRenderingMode(.alwaysTemplate)
        yellowView.tintColor = UIColor.clear
        
        greenView.image = redView.image?.withRenderingMode(.alwaysTemplate)
        greenView.tintColor = UIColor.clear
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.layer.cornerRadius = self.frame.width*0.9/2
        imageView.layer.borderColor = UIColor.gray.cgColor
//        imageView.layer.borderWidth = 3.0
    }

}
