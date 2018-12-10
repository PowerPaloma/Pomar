//
//  SkillsCollectionViewCell.swift
//  Pomar
//
//  Created by Alan Victor Paulino de Oliveira on 09/12/18.
//  Copyright © 2018 Paloma Bispo. All rights reserved.
//

import UIKit

class SkillsCollectionViewCell: UICollectionViewCell {
    var label: UILabel!
    
    lazy var customContentView: UIView = {
        let view = UIView()
        view.backgroundColor = .green
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        customContentView.layer.cornerRadius = self.frame.height / 2
    }
    
    
    func commonInit() {
        addSubview(customContentView)
        
        customContentView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        customContentView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        customContentView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        customContentView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        label = UILabel()
        customContentView.addSubview(label)
        label.textAlignment = .center
        label.font = UIFont(name: label.font.fontName, size: 12)
        self.customContentView.backgroundColor = .green
        
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: customContentView.topAnchor, constant: 6),
            label.leadingAnchor.constraint(equalTo: customContentView.leadingAnchor, constant: 6),
            label.trailingAnchor.constraint(equalTo: customContentView.trailingAnchor, constant: -6),
            label.bottomAnchor.constraint(equalTo: customContentView.bottomAnchor, constant: -6)
            ])
    }
}

