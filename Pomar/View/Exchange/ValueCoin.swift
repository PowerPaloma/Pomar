//
//  ValueCoin.swift
//  Pomar
//
//  Created by Alan Victor Paulino de Oliveira on 06/12/18.
//  Copyright © 2018 Paloma Bispo. All rights reserved.
//

import UIKit

class ValueCoin: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var valueCoinLabel: UILabel!
    
    @IBOutlet weak var backgroundLabel: UIView!
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.myInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.myInit()
    }
    
    private func myInit(){
        Bundle.main.loadNibNamed("ValueCoin", owner: self, options: nil)
        backgroundLabel.clipsToBounds = true
//        self.contentView.clipsToBounds = true
//        self.contentView.layer.cornerRadius = 12
        self.addSubview(contentView)
        contentView.frame = self.bounds
        backgroundLabel.layer.cornerRadius = backgroundLabel.bounds.height / 2
    }

}
