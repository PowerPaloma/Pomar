//
//  FinalTutorial.swift
//  Pomar
//
//  Created by Alan Victor Paulino de Oliveira on 27/11/18.
//  Copyright © 2018 Paloma Bispo. All rights reserved.
//

import UIKit

protocol FinalTutorialDelegate:class {
    func tapButtonInFinalTutorial()
}


class FinalTutorial: SlideTutorial {
    @IBOutlet weak var imageFinal: UIImageView!
    @IBOutlet weak var textFinal: UILabel!
    @IBOutlet weak var actionFinal: UIView!
    
    var delegate: FinalTutorialDelegate?
    
    override func awakeFromNib() {
        actionFinal.layer.cornerRadius = 8
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapButtonView(_:)))
        actionFinal.addGestureRecognizer(tapGesture)
    }
    
    @objc func tapButtonView( _ gesture:UIGestureRecognizer){
        // delegate aqui
        delegate?.tapButtonInFinalTutorial()
        print("Tapped in button")
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

