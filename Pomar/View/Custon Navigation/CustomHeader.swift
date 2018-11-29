//
//  CustomHeader.swift
//  Pomar
//
//  Created by Paloma Bispo on 29/11/18.
//  Copyright © 2018 Paloma Bispo. All rights reserved.
//

import UIKit

class CustomHeader: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var userPoints: UserMoney!
    @IBOutlet weak var title: UILabel!
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.myInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.myInit()
    }
    
    private func myInit(){
        Bundle.main.loadNibNamed("CustomHeader", owner: self, options: nil)
        self.addSubview(contentView)
        contentView.frame = self.bounds
    }

}
