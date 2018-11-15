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
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "GroupsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "celGroup")
        
        
    }
}

extension StudyGroupsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellGroup", for: indexPath) as! GroupsCollectionViewCell
        return cell
    }
    
    
    
}
