//
//  ExchangeViewController.swift
//  Pomar
//
//  Created by Alan Victor Paulino de Oliveira on 06/12/18.
//  Copyright © 2018 Paloma Bispo. All rights reserved.
//

import UIKit
import CloudKit

class ExchangeViewController: UIViewController {
    
    @IBOutlet weak var userMoney: UserMoney!
    @IBOutlet weak var valueCoin1: ValueCoin!
    @IBOutlet weak var valueCoin2: ValueCoin!
    @IBOutlet weak var valueCoin3: ValueCoin!
    
    @IBOutlet weak var amountOfRedApples: UILabel!
    @IBOutlet weak var amountOfOrangeApples: UILabel!
    @IBOutlet weak var amountOfYellowApples: UILabel!
    
    
    @IBOutlet weak var exchangeRedLabel: UILabel!
    @IBOutlet weak var exchangeOrangeLabel: UILabel!
    @IBOutlet weak var exchangeYellowLabel: UILabel!
    
    lazy var spinnerView:UIView = {
        let spinView = UIView.init(frame: self.view.bounds)
        spinView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        return spinView
    }()
    
    lazy var spinner: UIActivityIndicatorView = {
        let ai = UIActivityIndicatorView.init(style: .whiteLarge)
        ai.startAnimating()
        ai.center = spinnerView.center
        
        return ai
    }()
    
    let userID = CKRecord.ID(recordName: "0A8A845C-B724-4BDF-8650-4368DB3B8D76")
    
    var messageExchange = "Default"
    var appleTypeChoosed:AppleType = .green
    

    var alertController:UIAlertController {
        let alert = UIAlertController(title: "Confirm transaction", message: messageExchange, preferredStyle: .alert)
        let actionCancel = UIAlertAction(title: "Cancel", style: .destructive) { (action) in
            
        }
        
        let confirmAction = UIAlertAction(title: "Confirm", style: .default) { (action) in
            self.displaySpinner()
            CKManager.shared.exchangeApple(userId: self.userID, appleType: self.appleTypeChoosed, completion: { (record, error) in
                if error == nil{
                    self.removeSpinner()
                    if let valueMoney = record?.value(forKey: "money"),
                        let valueGreenApples = record?.value(forKey: "greenApples"),
                        let valueRedApples = record?.value(forKey: "redApples"),
                        let valueYellowApples = record?.value(forKey: "yellowApples")
                    {
                        DispatchQueue.main.async {
                            self.userMoney.points.text = "\(valueMoney)"
                            self.amountOfRedApples.text = "\(valueRedApples)"
                            self.amountOfOrangeApples.text = "\(valueGreenApples)"
                            self.amountOfYellowApples.text = "\(valueYellowApples)"
                        }
                    }
//                    print(record?.value(forKey: "money"))
                }else{
                    print(error.debugDescription)
                }
            })
        }
        
        alert.addAction(actionCancel)
        alert.addAction(confirmAction)
        
        return alert
    }
    
    
    var tapGestureExchange : UIGestureRecognizer  {
        return UITapGestureRecognizer(target: self, action: #selector(exchangeApples(tapGesture: )))
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        exchangeRedLabel.tag = 1
        exchangeYellowLabel.tag = 2
        exchangeOrangeLabel.tag = 3
        
        exchangeRedLabel.addGestureRecognizer(tapGestureExchange)
        exchangeOrangeLabel.addGestureRecognizer(tapGestureExchange)
        exchangeYellowLabel.addGestureRecognizer(tapGestureExchange)
        
        valueCoin1.valueCoinLabel.text = "100"
        valueCoin2.valueCoinLabel.text = "150"
        valueCoin3.valueCoinLabel.text = "200"
        
        loadAmountOfCoinsOfTheUser()

    }
    
    @objc func exchangeApples(tapGesture gesture:UITapGestureRecognizer){
        
        let type = AppleType(index: (gesture.view?.tag)!)
        self.appleTypeChoosed = type!
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func loadAmountOfCoinsOfTheUser(){
        displaySpinner()
        
        CKManager.shared.fetchUser(id: userID) { (record, user, error) in
       
            if let money = record?.value(forKey: "money") as? Int,
            let greenApples = record?.value(forKey: "greenApples") as? Int,
            let redApples = record?.value(forKey: "redApples") as? Int,
                let yellowApples = record?.value(forKey: "yellowApples") as? Int{
                DispatchQueue.main.async {
                    self.userMoney.points.text = "\(money)"
                    self.amountOfRedApples.text = "\(redApples)"
                    self.amountOfOrangeApples.text = "\(greenApples)"
                    self.amountOfYellowApples.text = "\(yellowApples)"
                    self.removeSpinner()
                    
                }
            }
        }
    }


    func displaySpinner(){
//        let spinnerView = UIView.init(frame: onView.bounds)
//        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
//        let ai = UIActivityIndicatorView.init(style: .whiteLarge)
//        ai.startAnimating()
//        ai.center = spinnerView.center
        
        DispatchQueue.main.async {
            self.spinnerView.addSubview(self.spinner)
            self.view.addSubview(self.spinnerView)
        }
    }
    
    func removeSpinner() {
        DispatchQueue.main.async {
           self.spinnerView.removeFromSuperview()
        }
    }

}
