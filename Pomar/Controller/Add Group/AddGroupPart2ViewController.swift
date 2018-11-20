//
//  AddGroupPart2ViewController.swift
//  Pomar
//
//  Created by Paloma Bispo on 19/11/18.
//  Copyright © 2018 Paloma Bispo. All rights reserved.
//

import UIKit

class AddGroupPart2ViewController: UIViewController {
    @IBOutlet weak var viewWeekly: UIView!
    @IBOutlet weak var viewUnique: UIView!
    @IBOutlet weak var dayUnique: UITextField!
    @IBOutlet weak var scheduleUnique: UITextField!
    @IBOutlet weak var mondayHour: UITextField!
    @IBOutlet weak var tuesdayHour: UITextField!
    @IBOutlet weak var wednesdayHour: UITextField!
    @IBOutlet weak var thursdayHour: UITextField!
    @IBOutlet weak var fridayHour: UITextField!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    var isWeekly = true
    var newgroup: Group?
//    var dayOfTheWeek = ["Monday", "Tuesday", "Wednesday","Thursday" ,"Friday"]
//    var hours = ["13","14","15","16","17"]
//    var minutes = ["00","15","30","45"]
    var dayPickerController = UIPickerView()
    var hoursPickerController = UIPickerView()
    var modelDayPicker: DayPicker!
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
        
        dayUnique.delegate = self
        scheduleUnique.delegate = self
        
        dayUnique.inputView = dayPickerController
        scheduleUnique.inputView = hoursPickerController
        dayUnique.inputAccessoryView = accessoryToolbar
        scheduleUnique.inputAccessoryView = accessoryToolbar
        modelDayPicker = DayPicker()
        modelHoursPicker = HourPicker()
        
    
        dayPickerController.delegate = modelDayPicker
        dayPickerController.dataSource = modelDayPicker
        
        hoursPickerController.delegate = modelHoursPicker
        hoursPickerController.dataSource = modelHoursPicker
        

        let rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done(_:)))
        
        self.navigationItem.rightBarButtonItem = rightBarButtonItem

        modelDayPicker.textFieldDelegate = self
        modelHoursPicker.textFieldDelegate = self
        
        setupTagsTextFields()
        
    }
    
    func setupTagsTextFileds(){
        mondayHour.tag = 0
        tuesdayHour.tag = 1
        wednesdayHour.tag = 2
        thursdayHour.tag = 3
        fridayHour.tag = 4
    }
    
    override func viewWillAppear(_ animated: Bool) {
       controlSegmented()
    }
    
    func controlSegmented(){
        closePicker()
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            self.viewWeekly.isHidden = false
            self.viewUnique.isHidden = true
            isWeekly = true
            break
        case 1:
            self.viewWeekly.isHidden = true
            self.viewUnique.isHidden = false
            isWeekly = false
            break
        default:
            self.viewWeekly.isHidden = false
            self.viewUnique.isHidden = true
            isWeekly = false
        }
    }
    
    func closePicker(){
        if dayUnique.isFirstResponder {
            dayUnique.resignFirstResponder()
        }else if scheduleUnique.isFirstResponder {
            scheduleUnique.resignFirstResponder()
        }
    }
    

    @objc func onDoneButtonTapped(sender: UIBarButtonItem) {
        closePicker()
    }
    
    
    @objc func done(_ sender: Any) {
        if isWeekly {
            let textFields = [mondayHour,tuesdayHour,wednesdayHour,thursdayHour,fridayHour]
            let textFieldsFills = textFields.filter { (textField) -> Bool in
                let check = Validation.textFieldsIsEmpty(textFields: [textField!])
                return !check
            }
            
            if textFieldsFills.isEmpty{
                let alertCompleteFields = UIAlertController(title: "Complete all the fields", message: nil, preferredStyle: .alert)
                DispatchQueue.main.async {
                    self.present(alertCompleteFields, animated: true, completion: nil)
                }
                let when = DispatchTime.now() + 2
                DispatchQueue.main.asyncAfter(deadline: when){
                    alertCompleteFields.dismiss(animated: true, completion: nil)
                }
            }else{
                // enum ou switch para verificar tag e retornar nome de dias da semana abreviado
//                textFieldsFills[0]?.tag = 3030303
            }
            
            
            let isEmpty = Validation.textFieldsIsEmpty(textFields: [mondayHour,tuesdayHour,wednesdayHour,thursdayHour,fridayHour])
            
            if isEmpty{
                let alertCompleteFields = UIAlertController(title: "Complete all the fields", message: nil, preferredStyle: .alert)
                DispatchQueue.main.async {
                    self.present(alertCompleteFields, animated: true, completion: nil)
                }
            }
//            else{
//                    guard let newGroup = self.newgroup else{return}
//                    guard let scheduleDays = [self.mondayHour.text , self.tuesdayHour.text, self.wednesdayHour.text, self.thursdayHour.text] else{return}
//                    scheduleDays.forEach({ (schedule) in
//                        newgroup?.schedule?.append(schedule)
//                    })
//                }
        }
        else{
            let isEmpty = Validation.textFieldsIsEmpty(textFields: [self.dayUnique, self.scheduleUnique])
            if isEmpty{
                let alertCompleteFields = UIAlertController(title: "Complete all the fields", message: nil, preferredStyle: .alert)
                DispatchQueue.main.async {
                    self.present(alertCompleteFields, animated: true, completion: nil)
                }
                let when = DispatchTime.now() + 2
                DispatchQueue.main.asyncAfter(deadline: when){
                    alertCompleteFields.dismiss(animated: true, completion: nil)
                }
            }else{
                guard let newGroup = self.newgroup else {return}
                guard let day = self.dayUnique.text else {return}
                guard let schedule = self.scheduleUnique.text else {return}
                let uniqueSchedule = DaySchedule(day: day, hour:schedule)
                newGroup.schedule?.append(uniqueSchedule)
                CKManager.shared.createGroup(group: newGroup)
                
            }
            
        }
    }
    
    
    @IBAction func changeSegmented(_ sender: Any) {
       controlSegmented()
    }
}


extension AddGroupPart2ViewController: TextFieldProtocol {
    
    func send(text: String) {
         if dayUnique.isFirstResponder {
            dayUnique.text = text
         }else{
            scheduleUnique.text = text
        }
        
    }
    
}

extension AddGroupPart2ViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return false
    }
}






