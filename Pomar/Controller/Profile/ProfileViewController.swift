//
//  ProfileViewController.swift
//  Pomar
//
//  Created by Alan Victor Paulino de Oliveira on 09/12/18.
//  Copyright © 2018 Paloma Bispo. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    @IBOutlet weak var nameUser: UILabel!
    @IBOutlet weak var imageUser: UIImageView!
    @IBOutlet weak var collectionViewSkills: UICollectionView!
    @IBOutlet weak var collectionViewBadges: UICollectionView!
    @IBOutlet weak var layoutCollectionSkills: UICollectionViewFlowLayout!
    
    
    
    let collectionSkillsDelegateAndDataSource = CollectionSkillsDelegateAndDataSource()
    let collectionBadgesDelegateAndDataSource = CollectionBadgesDelegateAndDataSource()
    override func viewDidLoad() {
        super.viewDidLoad()
        imageUser.image = UIImage(named: "pomarLogo")
        imageUser.clipsToBounds = true
        imageUser.layer.cornerRadius = imageUser.bounds.height/2
        imageUser.layer.borderWidth = 5
        imageUser.layer.borderColor = UIColor.green.cgColor
        
        nameUser.text = "Default"
        
        collectionViewSkills.register(SkillsCollectionViewCell.self, forCellWithReuseIdentifier: "cellSkills")
        collectionViewBadges.register(UINib(nibName: "BadgesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cellBadges")
        
//        layoutCollectionSkills.itemSize = CGSize(width: 40, height: 40)
//        layoutCollectionSkills.estimatedItemSize = CGSize(width: 50, height: customHeight)
        layoutCollectionSkills.sectionInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        layoutCollectionSkills.minimumLineSpacing = 4
        layoutCollectionSkills.minimumInteritemSpacing = 4
        
        collectionViewSkills.delegate = collectionSkillsDelegateAndDataSource
        collectionViewSkills.dataSource = collectionSkillsDelegateAndDataSource
        collectionViewBadges.delegate = collectionBadgesDelegateAndDataSource
        collectionViewBadges.dataSource = collectionBadgesDelegateAndDataSource
        
    
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        imageUser.layer.cornerRadius = imageUser.bounds.height/2
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
