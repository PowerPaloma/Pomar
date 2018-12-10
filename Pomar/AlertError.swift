//
//  AlertError.swift
//  Pomar
//
//  Created by Mateus Rodrigues on 10/12/18.
//  Copyright © 2018 Paloma Bispo. All rights reserved.
//

import Foundation
import UIKit

class AlertError {
    var controller: UIViewController
    
    init(controller: UIViewController) {
        self.controller = controller
    }
    
    func showErrorAlert(message: String) {
        DispatchQueue.main.async {
            let alert  = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
                
            }))
            self.controller.present(alert, animated: true, completion: nil)
        }
    }
}

