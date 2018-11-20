//
//  AddGroupPart1ViewController.swift
//  Pomar
//
//  Created by Paloma Bispo on 19/11/18.
//  Copyright © 2018 Paloma Bispo. All rights reserved.
//

import UIKit

class AddGroupPart1ViewController: UIViewController {

    @IBOutlet weak var scView: UIScrollView!
    @IBOutlet weak var nameTxtField: UITextField!
    @IBOutlet weak var tagsTxtField: UITextField!
    @IBOutlet weak var descriptionGroupTxtView: UITextView!
    var activeField: UITextField!
    var newGroup: Group?
    override func viewDidLoad() {
        super.viewDidLoad()
        descriptionGroupTxtView.layer.borderWidth = 0.5
        descriptionGroupTxtView.layer.borderColor = UIColor.gray.cgColor
        descriptionGroupTxtView.layer.cornerRadius = 15
        descriptionGroupTxtView.clipsToBounds = true
        observeKeyboardNotifications()

        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? AddGroupPart2ViewController {
            guard let newGroup = self.newGroup else{
                dest.newgroup = Group()
                return
            }
            dest.newgroup = newGroup
        }
    }
    

    
    @IBAction func next(_ sender: Any) {
        let isEmptyTextFields = Validation.textFieldsIsEmpty(textFields: [self.nameTxtField, self.tagsTxtField])
        let isEmptyTextViews = Validation.textFieldsIsEmpty(textFields: [self.nameTxtField, self.tagsTxtField])
        
        
        if isEmptyTextFields || isEmptyTextViews {
            let alertCompleteFields = UIAlertController(title: "Complete all the fields", message: nil, preferredStyle: .alert)
            DispatchQueue.main.async {
                self.present(alertCompleteFields, animated: true, completion: nil)
            }
            let when = DispatchTime.now() + 1
            DispatchQueue.main.asyncAfter(deadline: when){
                alertCompleteFields.dismiss(animated: true, completion: nil)
            }
            
        }else{
            newGroup = Group()
            guard let newGroup = newGroup else{ return }
            if let tags = self.tagsTxtField.text {
                newGroup.tags = tags.components(separatedBy: " ")
            }else{
                newGroup.tags = []
            }
            guard let name = self.nameTxtField.text, let description = self.descriptionGroupTxtView.text else{return}
            newGroup.name = name
            newGroup.description = description
            
            performSegue(withIdentifier: "part2", sender: nil)
            
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
        
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: targetFrame.height, right: 0.0)
        scView.contentInset = contentInsets
        scView.scrollIndicatorInsets = contentInsets
        
        var aRect = self.view.frame
        aRect.size.height -= targetFrame.height
        if (activeField != nil && !aRect.contains(activeField.frame.origin)) {
            scView.scrollRectToVisible(activeField.frame, animated: true)
        }
    }
    
    @objc func keyboardWillHide(notif: Notification){
        let contentInsets = NSCoder.uiEdgeInsets(for: "")
        scView.contentInset = contentInsets
        scView.scrollIndicatorInsets = contentInsets
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
