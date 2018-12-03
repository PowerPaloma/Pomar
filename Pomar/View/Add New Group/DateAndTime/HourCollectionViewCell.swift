//
//  HourCollectionViewCell.swift
//  Pomar
//
//  Created by Alan Victor Paulino de Oliveira on 03/12/18.
//  Copyright © 2018 Paloma Bispo. All rights reserved.
//

import UIKit

class HourCollectionViewCell: UICollectionViewCell {
    lazy var labelHour: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont(name: label.font.fontName, size: 12)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    
    lazy var customContentView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.layer.borderColor = UIColor.darkGray.cgColor
//        view.backgroundColor = .green
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    override var isSelected: Bool{
        didSet{
            if self.isSelected{
                customContentView.layer.borderWidth = 1.5
            }else{
                customContentView.layer.borderWidth = 0.0
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
 
    func commonInit() {
        self.addSubview(customContentView)
        
        NSLayoutConstraint.activate([
            customContentView.topAnchor.constraint(equalTo: topAnchor, constant: 4),
            customContentView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4),
            customContentView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -4),
            bottomAnchor.constraint(equalTo: customContentView.bottomAnchor, constant: 4 )
            ])
        
        
        customContentView.addSubview(labelHour)
//        self.contentView.backgroundColor = .green

        NSLayoutConstraint.activate([
            labelHour.topAnchor.constraint(equalTo: customContentView.topAnchor, constant: 2),
            labelHour.leadingAnchor.constraint(equalTo: customContentView.leadingAnchor, constant: 2),
            labelHour.trailingAnchor.constraint(equalTo: customContentView.trailingAnchor, constant: -2),
            customContentView.bottomAnchor.constraint(equalTo: labelHour.bottomAnchor, constant: 2)
            ])
        
        
        
    }
}
