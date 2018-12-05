//
//  CreateUserViewController.swift
//  Pomar
//
//  Created by Mateus Rodrigues on 05/12/18.
//  Copyright © 2018 Paloma Bispo. All rights reserved.
//

import UIKit

class CreateUserViewController: UIViewController {

    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var skillsView: UIView!
    
    let imagePicker = UIImagePickerController()
    
    let tagsField = WSTagsField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(CreateUserViewController.loadImage(sender:)))
        userImageView.addGestureRecognizer(tap)
        userImageView.isUserInteractionEnabled = true

        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        userImageView.layer.cornerRadius = userImageView.frame.width/2
        userImageView.backgroundColor = UIColor.white
        userImageView.layer.borderWidth = 3.0
        userImageView.layer.borderColor = #colorLiteral(red: 0, green: 0.7941015959, blue: 0.3129233718, alpha: 1)
        userImageView.clipsToBounds = true
        
        tagsField.placeholder = "Write Tags"
        tagsField.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        tagsField.layoutMargins = UIEdgeInsets(top: 2, left: 6, bottom: 2, right: 6)
        tagsField.backgroundColor = UIColor.red
        
        tagsField.translatesAutoresizingMaskIntoConstraints = false
        skillsView.addSubview(tagsField)
        
        NSLayoutConstraint.activate([
            tagsField.topAnchor.constraint(equalTo: skillsView.topAnchor),
            tagsField.leadingAnchor.constraint(equalTo: skillsView.leadingAnchor, constant: 10),
            tagsField.trailingAnchor.constraint(equalTo: skillsView.trailingAnchor, constant: -10),
            tagsField.bottomAnchor.constraint(equalTo: skillsView.bottomAnchor)
            ])
        textFieldEvents()
        
        
    }
    
    fileprivate func textFieldEvents(){
        tagsField.onDidAddTag = { _, _ in
            print("onDidAddTag")
        }
        
        tagsField.onDidRemoveTag = { _, _ in
            print("onDidRemoveTag")
        }
        
        tagsField.onDidChangeText = { _, text in
            let suggestionTags = subjects.filter {$0.localizedCaseInsensitiveContains(text ?? "")}
            print(suggestionTags)
            print("onDidChangeText")
        }
        
        tagsField.onDidChangeHeightTo = { _, height in
            print("HeightTo \(height)")
        }
        
        tagsField.onDidSelectTagView = { _, tagView in
            print("Select \(tagView)")
        }
        
        tagsField.onDidUnselectTagView = { _, tagView in
            print("Unselect \(tagView)")
        }
    }
    
    func tapInTag(tagText: String) {
        tagsField.addTag(tagText)
    }

    @IBAction func done(_ sender: Any) {
        
        guard let image = userImageView.image, let name = nameTextField.text else {
            return
        }
        
        CKManager.shared.iCloudUserID { (token, error) in
            guard let token = token else {
                print(error?.localizedDescription ?? "NO ERROR")
                return
            }
            
            print(token)
            
            let tags = self.tagsField.tags.map({ (wstag) -> String in
                return wstag.text
            })
            
            print(tags)
            
            
            
        }
        
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
