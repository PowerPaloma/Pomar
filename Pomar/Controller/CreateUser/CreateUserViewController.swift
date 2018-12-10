//
//  CreateUserViewController.swift
//  Pomar
//
//  Created by Mateus Rodrigues on 05/12/18.
//  Copyright © 2018 Paloma Bispo. All rights reserved.
//

import UIKit
import CloudKit


class CreateUserViewController: UIViewController {

    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var skillsView: UIView!
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var constraintHeight: NSLayoutConstraint!
    var activeField: UITextField?
    var lastOffset: CGPoint!
    var keyboardHeight: CGFloat! = 0.0
    
    let imagePicker = UIImagePickerController()
    
    let tagsField = WSTagsField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        nameTextField.delegate = self
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(CreateUserViewController.loadImage(sender:)))
        userImageView.addGestureRecognizer(tap)
        userImageView.isUserInteractionEnabled = true
        
        let notifier = NotificationCenter.default
        notifier.addObserver(self,
                             selector: #selector(keyboardWillShowNotification(_:)),
                             name: UIWindow.keyboardWillShowNotification,
                             object: nil)
        notifier.addObserver(self,
                             selector: #selector(keyboardWillHideNotification(_:)),
                             name: UIWindow.keyboardWillHideNotification,
                             object: nil)


        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        
        cardView.layer.cornerRadius = 5
        
        userImageView.layer.cornerRadius = userImageView.frame.width/2
        userImageView.backgroundColor = UIColor.white
        userImageView.layer.borderWidth = 3.0
        userImageView.layer.borderColor = #colorLiteral(red: 0, green: 0.7941015959, blue: 0.3129233718, alpha: 1)
        userImageView.clipsToBounds = true
        
        tagsField.placeholder = "Write your skills"
        tagsField.tintColor = #colorLiteral(red: 0.7644024491, green: 0, blue: 0, alpha: 1)
        
        tagsField.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 10)
        tagsField.layoutMargins = UIEdgeInsets(top: 2, left: 6, bottom: 2, right: 6)
        tagsField.textDelegate = self
        tagsField.acceptTagOption = .space
        
        tagsField.translatesAutoresizingMaskIntoConstraints = false
        skillsView.addSubview(tagsField)
        
        NSLayoutConstraint.activate([
            tagsField.topAnchor.constraint(equalTo: skillsView.topAnchor),
            tagsField.leadingAnchor.constraint(equalTo: skillsView.leadingAnchor, constant: 0),
            tagsField.trailingAnchor.constraint(equalTo: skillsView.trailingAnchor, constant: -10),
            tagsField.bottomAnchor.constraint(equalTo: skillsView.bottomAnchor)
            ])
        
    }
    
    func tapInTag(tagText: String) {
        tagsField.addTag(tagText)
    }

    @IBAction func done(_ sender: Any) {
        
        loadingView.isHidden = false
        activityIndicator.startAnimating()
        
        guard let image = userImageView.image, let name = nameTextField.text else {
            return
        }
        
        CKManager.shared.iCloudUserID { (token, error) in
            
            guard let token = token else {
                print(error?.localizedDescription ?? "NO ERROR")
                    self.showErrorAlert(message: error!.localizedDescription)
                return
            }

            let tags = self.tagsField.tags.map({ (wstag) -> String in
                return wstag.text
            })

            CKManager.shared.saveimage(image, completion: { (record, error) in
                guard let record = record else {
                    print(error!.localizedDescription)
                    self.showErrorAlert(message: error!.localizedDescription)
                    return
                }
                let imageRef = CKRecord.Reference(record: record, action: .none)
                let user = User(name: name, token: token, imageRef: imageRef)
                CKManager.shared.createUser(user: user, completion: { (record, error) in
                    
                    guard let record = record else {
                        self.showErrorAlert(message: error!.localizedDescription)
                        return
                    }
                
                    print(record)
                    let saveSuccessful = KeychainWrapper.standard.set(record.recordID.recordName, forKey: "userID")
                    print("saveSuccessful=\(saveSuccessful)") //saveSuccessful=true
                    DispatchQueue.main.async {
                        self.activityIndicator.stopAnimating()
                        self.activityIndicator.isHidden = true
                        self.loadingView.isHidden = true
                    }
                })

            })
        }
        
    }
    
    func showErrorAlert(message: String) {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            let alert  = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
                self.loadingView.isHidden = true
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
}

extension CreateUserViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        activeField = textField
        lastOffset = self.scrollView.contentOffset
        return true
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        activeField?.resignFirstResponder()
        activeField = nil
        return true
    }
}

extension CreateUserViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            userImageView.contentMode = .scaleAspectFill
            userImageView.image = pickedImage
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    @objc func loadImage(sender: UIButton) {
        
        let alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
            self.openCamera()
        }))
        
        alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
            self.openGallary()
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func openCamera() {
        if(UIImagePickerController .isSourceTypeAvailable(.camera))
        {
            imagePicker.sourceType = .camera
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
        else
        {
            let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func openGallary()
    {
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        self.present(imagePicker, animated: true, completion: nil)
    }
    
}

extension CreateUserViewController {
    @objc func keyboardWillShowNotification(_ notification: NSNotification) {
        if keyboardHeight != nil {
            return
        }
        
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            keyboardHeight = keyboardSize.height
            
            // so increase contentView's height by keyboard height
            UIView.animate(withDuration: 0.3, animations: {
                self.constraintHeight.constant += self.keyboardHeight
            })
            
            // move if keyboard hide input field
            guard let activeFieldFrame = activeField?.convert((activeField?.bounds)!, to: contentView) else {
                return
            }
            let distanceToBottom = self.scrollView.frame.size.height - (activeFieldFrame.origin.y) - (activeFieldFrame.size.height)
            let collapseSpace = keyboardHeight - distanceToBottom
            
            if collapseSpace < 0 {
                // no collapse
                return
            }
            
            // set new offset for scroll view
            UIView.animate(withDuration: 0.3, animations: {
                // scroll to the position above keyboard 10 pointsgu
                
                self.scrollView.contentOffset = CGPoint(x: self.lastOffset.x, y: collapseSpace + 10)
            })
//
//            if self.activeField is BackspaceDetectingTextField {
//                UIView.animate(withDuration: 0.3) {
//                    self.userImageView.isHidden = true
//                }
//            }
        }
    }
    
    @objc func keyboardWillHideNotification(_ notification: NSNotification) {
        if self.keyboardHeight == nil {
            return
        }
        UIView.animate(withDuration: 0.3) {
            self.constraintHeight.constant -= self.keyboardHeight
            self.scrollView.contentOffset = self.lastOffset
        }
        //self.userImageView.isHidden = false
        
        keyboardHeight = nil
    }
}
