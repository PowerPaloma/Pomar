//
//  AddGroupViewController.swift
//  Pomar
//
//  Created by Paloma Bispo on 08/12/18.
//  Copyright © 2018 Paloma Bispo. All rights reserved.
//

import UIKit

class AddGroupViewController: UIViewController {

    @IBOutlet weak var collectionHours: UICollectionView!

    @IBOutlet weak var scroll: UIScrollView!
    @IBOutlet weak var card: UIView!
    @IBOutlet weak var collectionMonths: UICollectionView!
    @IBOutlet weak var collectionDays: UICollectionView!
    @IBOutlet weak var dateAndTimeView: UIView!
    var modelMonth: ModelMonths!
    var modelDay: ModelDays!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionMonths.register(UINib(nibName: "MonthCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "month")
        collectionDays.register(UINib(nibName: "DayCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "day")
        
        self.modelDay = ModelDays(month: 2, collection: self.collectionDays)
        collectionDays.delegate = self.modelDay
        collectionDays.dataSource = self.modelDay
        
        self.modelMonth = ModelMonths(collection: self.collectionMonths, modelDays: modelDay)
        collectionMonths.delegate = self.modelMonth
        collectionMonths.dataSource = self.modelMonth
        setup()
    }
    
    func setup(){
        self.card.clipsToBounds = true
        self.card.layer.cornerRadius = 12
        self.scroll.clipsToBounds = true
        self.scroll.layer.cornerRadius = 12
        self.dateAndTimeView.clipsToBounds = true
        self.dateAndTimeView.layer.cornerRadius = 12
        self.dateAndTimeView.layer.borderWidth = 0.5
        self.dateAndTimeView.layer.borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        self.collectionMonths.layer.borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        self.collectionMonths.layer.borderWidth = 0.5
        self.stackHours.view
        self.stackHours.layer.borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        self.stackHours.layer.borderWidth = 0.5
        self.stackHours.clipsToBounds = true
        self.stackHours.layer.cornerRadius = 8
    }
    
}


extension UIView {
    func addTopBorderWithColor(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: width)
        self.layer.addSublayer(border)
    }
    
    func addRightBorderWithColor(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: self.frame.size.width - width, y: 0, width: width, height: self.frame.size.height)
        self.layer.addSublayer(border)
    }
    
    func addBottomBorderWithColor(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width: self.frame.size.width, height: width)
        self.layer.addSublayer(border)
    }
    
    func addLeftBorderWithColor(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: 0, y: 0, width: width, height: self.frame.size.height)
        self.layer.addSublayer(border)
    }
}

