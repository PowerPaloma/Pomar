//
//  InitialViewController.swift
//  Pomar
//
//  Created by Paloma Bispo on 04/12/18.
//  Copyright © 2018 Paloma Bispo. All rights reserved.
//

import UIKit

class InitialViewController: UIViewController {

    @IBOutlet weak var startButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startButton.clipsToBounds = true
        startButton.layer.cornerRadius = 10

        // Do any additional setup after loading the view.
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
