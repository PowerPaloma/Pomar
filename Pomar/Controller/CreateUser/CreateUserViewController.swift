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
    
    let imagePicker = UIImagePickerController()
    
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
    }

    @IBAction func done(_ sender: Any) {
        
        guard let image = userImageView.image, let name = nameTextField.text else {
            return
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
