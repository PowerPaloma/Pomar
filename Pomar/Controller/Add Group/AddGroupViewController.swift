//
//  AddGroupViewController.swift
//  Pomar
//
//  Created by Paloma Bispo on 08/12/18.
//  Copyright © 2018 Paloma Bispo. All rights reserved.
//

import UIKit

class AddGroupViewController: UIViewController {

    @IBOutlet weak var smallDescriptionTxtView: UITextView!
    @IBOutlet weak var nameTxtField: UITextField!
    @IBOutlet weak var hourView: UIView!
    @IBOutlet var hoursTxtF: [UITextField]!
    @IBOutlet weak var scroll: UIScrollView!
    @IBOutlet weak var card: UIView!
    @IBOutlet weak var collectionMonths: UICollectionView!
    @IBOutlet weak var collectionDays: UICollectionView!
    @IBOutlet weak var dateAndTimeView: UIView!
    let minimumInteritemSpacing: CGFloat = 4
    let minimumLineSpacing:CGFloat = 4
    var hours = ["00:00", "00:00", "00:00", "00:00", "00:00"]
    var modelMonth: ModelMonths!
    var modelDay: ModelDays!
    var activeField: UITextField!
    var hoursPickerController = UIPickerView()
    var modelHoursPicker: HourPicker!
    var accessoryToolbar: UIToolbar {
        get {
            let toolbarFrame = CGRect(x: 0, y: 0,
                                      width: view.frame.width, height: 44)
            let accessoryToolbar = UIToolbar(frame: toolbarFrame)
            let doneButton = UIBarButtonItem(barButtonSystemItem: .done,
                                             target: self,
                                             action: #selector(onDoneButtonTapped(sender:)))
            let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                                target: nil,
                                                action: nil)
            accessoryToolbar.items = [flexibleSpace, doneButton]
            accessoryToolbar.barTintColor = UIColor.white
            return accessoryToolbar
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionMonths.register(UINib(nibName: "MonthCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "month")
        collectionDays.register(UINib(nibName: "DayCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "day")
        
        self.modelDay = ModelDays(month: 2, collection: self.collectionDays)
        modelDay.selectedDaysProtocol = self
        collectionDays.delegate = self.modelDay
        collectionDays.dataSource = self.modelDay
        collectionDays.allowsMultipleSelection = true
        
        self.modelMonth = ModelMonths(collection: self.collectionMonths, modelDays: modelDay)
        collectionMonths.delegate = self.modelMonth
        collectionMonths.dataSource = self.modelMonth
        
        modelHoursPicker = HourPicker()
        hoursPickerController.delegate = modelHoursPicker
        hoursPickerController.dataSource = modelHoursPicker
        modelHoursPicker.textFieldDelegate = self
        
        setupTextFields()
        setup()
        observeKeyboardNotifications()
    }
    
    private func setup(){
        self.scroll.clipsToBounds = true
        self.scroll.layer.cornerRadius = 12
        self.dateAndTimeView.clipsToBounds = true
        self.dateAndTimeView.layer.cornerRadius = 8
        self.dateAndTimeView.layer.borderWidth = 0.5
        self.dateAndTimeView.layer.borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        self.collectionMonths.layer.borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        self.collectionMonths.layer.borderWidth = 0.5
        self.hourView.layer.borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        self.hourView.layer.borderWidth = 0.5
        self.hourView.clipsToBounds = true
        self.hourView.layer.cornerRadius = 8
        self.smallDescriptionTxtView.layer.borderColor = #colorLiteral(red: 0.8844738603, green: 0.879216373, blue: 0.8885154724, alpha: 1)
        self.smallDescriptionTxtView.layer.borderWidth = 0.5
        self.smallDescriptionTxtView.layer.cornerRadius = 8
        self.smallDescriptionTxtView.clipsToBounds = true
        
//        card.layer.cornerRadius = 12.0
//        card.layer.borderWidth = 1.0
//        card.layer.borderColor = UIColor.clear.cgColor
//        card.layer.masksToBounds = true;
//        
//        card.layer.shadowColor = UIColor.lightGray.cgColor
//        card.layer.shadowOffset = CGSize(width:0,height: 2.0)
//        card.layer.shadowRadius = 5.0
//        card.layer.shadowOpacity = 0.7
//        card.layer.masksToBounds = false;
//        card.layer.shadowPath = UIBezierPath(roundedRect:card.bounds, cornerRadius:card.layer.cornerRadius).cgPath
    }
    
    private func setupTextFields(){
        for txtField in self.hoursTxtF {
            txtField.inputView  = hoursPickerController
            txtField.inputAccessoryView = accessoryToolbar
            txtField.delegate = self
        }
    }
    
    
    fileprivate func observeKeyboardNotifications() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: Notification){
        let targetFrame = (notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: targetFrame.height + 16, right: 0.0)
        scroll.contentInset = contentInsets
        scroll.scrollIndicatorInsets = contentInsets
        
        var aRect = self.view.frame
        aRect.size.height -= targetFrame.height
        if (activeField != nil && !aRect.contains(activeField.frame.origin)) {
            scroll.scrollRectToVisible(activeField.frame, animated: true)
        }
    }
    
    //Not testable
    
    @objc func keyboardWillHide(notif: Notification){
        let contentInsets = NSCoder.uiEdgeInsets(for: "")
        scroll.contentInset = contentInsets
        scroll.scrollIndicatorInsets = contentInsets
    }
    
    func closePicker(){
        if hoursTxtF[0].isFirstResponder {
            hoursTxtF[0].resignFirstResponder()
        }else  if hoursTxtF[1].isFirstResponder {
            hoursTxtF[1].resignFirstResponder()
        }else  if hoursTxtF[2].isFirstResponder {
            hoursTxtF[2].resignFirstResponder()
        }else  if hoursTxtF[3].isFirstResponder {
            hoursTxtF[3].resignFirstResponder()
        }else  if hoursTxtF[4].isFirstResponder {
            hoursTxtF[4].resignFirstResponder()
        }
    }
    
    
    @objc func onDoneButtonTapped(sender: UIBarButtonItem) {
        closePicker()
    }
    
}

extension AddGroupViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return false
    }
}

extension AddGroupViewController: SelectedDaysProtocol{
    
    func selected(days: [Bool]) {
        for (index, isSelected) in days.enumerated() {
            if isSelected {
                let txtField = hoursTxtF[index]
                txtField.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                txtField.clipsToBounds = true
                txtField.layer.cornerRadius = 8
                txtField.backgroundColor = #colorLiteral(red: 0.2589761913, green: 0.8057302833, blue: 0.4474651814, alpha: 0.3603392551)
                txtField.isEnabled = true
            }else{
                let txtField = hoursTxtF[index]
                txtField.textColor = #colorLiteral(red: 0.8823529412, green: 0.8784313725, blue: 0.8862745098, alpha: 1)
                txtField.clipsToBounds = true
                txtField.layer.cornerRadius = 8
                txtField.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                txtField.isEnabled = false
            }
        }
    }
    
    
}

extension AddGroupViewController: TextFieldProtocol {
    
    func send(text: String) {
        if hoursTxtF[0].isFirstResponder {
            hoursTxtF[0].text = text
        }else  if hoursTxtF[1].isFirstResponder {
            hoursTxtF[1].text = text
        }else  if hoursTxtF[2].isFirstResponder {
            hoursTxtF[2].text = text
        }else  if hoursTxtF[3].isFirstResponder {
            hoursTxtF[3].text = text
        }else  if hoursTxtF[4].isFirstResponder {
            hoursTxtF[4].text = text
        }
    }
    
}


