//
//  StudyGroupsViewController.swift
//  Pomar
//
//  Created by Paloma Bispo on 13/11/18.
//  Copyright © 2018 Paloma Bispo. All rights reserved.
//

import UIKit
import CloudKit

class StudyGroupsViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let day1 = DaySchedule(day: "monday", hour: "14:00")
        let day2 = DaySchedule(day: "friday", hour: "14:00")
        
        let schedule = [day1, day2]
        
        let newGroup = Group(name: "Novo Grupo", description: "Descricao", tags: ["tag1", "tag2"], schedule: schedule, date: Date(), isWeekly: true)
        
    }
    
}
