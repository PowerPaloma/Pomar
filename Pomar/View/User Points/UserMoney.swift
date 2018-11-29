//
//  UserMoney.swift
//  Pomar
//
//  Created by Paloma Bispo on 27/11/18.
//  Copyright © 2018 Paloma Bispo. All rights reserved.
//

import UIKit

class UserMoney: UIView {

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var points: UILabel!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.myInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.myInit()
    }
    
    private func myInit(){
        Bundle.main.loadNibNamed("UserMoney", owner: self, options: nil)
        self.contentView.clipsToBounds = true
        self.contentView.layer.cornerRadius = 12
        self.addSubview(contentView)
        contentView.frame = self.bounds
    }
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
