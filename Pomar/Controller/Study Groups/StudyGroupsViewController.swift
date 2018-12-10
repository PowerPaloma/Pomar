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
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    let minimumInteritemSpacing: CGFloat = 20
    let minimumLineSpacing:CGFloat = 20
    var storedOffsets = [Int: CGFloat]()
    var navBar: UINavigationBar = UINavigationBar()
    var groups: [Group] = [] {
        didSet {
            if groups.count > 0 {
                groups = groups.sorted(by: { (group1, group2) -> Bool in
                    return group1.createdAt > group2.createdAt
                })
            }
        }
    }
    
    var modelTag: ModelTag!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        groups = []
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        
        collectionView.register(UINib(nibName: "GroupsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cellGroup")
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? DetailsViewController{
            dest.group = sender as? Group
            
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        segmentedControl.layer.cornerRadius = 5
        
        CKManager.shared.fetchGroups { (groups, error) in
            if error == nil{
                if let groups = groups{
                    self.groups = groups
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                    }
                }
            }else {
                fatalError("\(String(describing: error?.localizedDescription))")
            }
        }
    }
    
    @IBAction func indexChanged(_ sender: Any) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            CKManager.shared.fetchGroups { (groups, error) in
                if error == nil{
                    if let groups = groups{
                        self.groups = groups
                        DispatchQueue.main.async {
                            self.collectionView.reloadData()
                        }
                    }
                }else {
                    fatalError("\(String(describing: error?.localizedDescription))")
                }
            }
        case 1:
//            let id = CKRecord.ID(recordName: KeychainWrapper.standard.string(forKey: "userID"))
            let id = CKRecord.ID(recordName: "1546BAB5-0964-C0AF-AE35-0D55349183EF")
            CKManager.shared.fetchGroups(userID: id) { (groups, error) in
                if error == nil{
                    if let groups = groups{
                        self.groups = groups
                        DispatchQueue.main.async {
                            self.collectionView.reloadData()
                        }
                    }
                }else {
                    fatalError("\(String(describing: error?.localizedDescription))")
                }
            }
        default:
            break
        }
    }
    
    
}

extension StudyGroupsViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return groups.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellGroup", for: indexPath)
        guard let cardCell = cell as? GroupsCollectionViewCell else {return cell}
        cardCell.contentView.layer.cornerRadius = 12.0
        cardCell.contentView.layer.borderWidth = 1.0
        cardCell.contentView.layer.borderColor = UIColor.clear.cgColor
        cardCell.contentView.layer.masksToBounds = true;
        
        cardCell.layer.shadowColor = UIColor.lightGray.cgColor
        cardCell.layer.shadowOffset = CGSize(width:0,height: 2.0)
        cardCell.layer.shadowRadius = 5.0
        cardCell.layer.shadowOpacity = 0.7
        cardCell.layer.masksToBounds = false;
        cardCell.layer.shadowPath = UIBezierPath(roundedRect:cell.bounds, cornerRadius:cell.contentView.layer.cornerRadius).cgPath
        let group = groups[indexPath.row]
        cardCell.nameGroup.text = group.name
        if group.isWeekly {
            if let schedulesGroup = group.schedule {
                let days = schedulesGroup.map { (daySchedule) -> String in
                    return daySchedule.day
                }
                let hours = schedulesGroup.map { (daySchedule) -> String in
                    return daySchedule.hour
                }
                if hours.count > 1{
                    cardCell.hoursGroup.text = "Multiples"
                }else if  hours.count == 1{
                    cardCell.hoursGroup.text = hours[0]
                }else{
                    cardCell.hoursGroup.text = ""
                }
                cardCell.daysGroup.text = days.joined(separator: " ")
            }

        }

        modelTag = ModelTag(tags: group.tags, isLimited: true)
        cardCell.setCollectionViewDataSourceDelegate(modelTag, forRow: indexPath.row)
        cardCell.collectionViewOffset = storedOffsets[indexPath.row] ?? 0
        return cardCell
    
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "detailsGroup", sender: groups[indexPath.row])
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemWidth = collectionView.frame.size.width - (minimumInteritemSpacing + minimumLineSpacing)
        return CGSize.init(width: itemWidth, height: 170)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return minimumLineSpacing
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return minimumInteritemSpacing
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: minimumInteritemSpacing, left: minimumInteritemSpacing, bottom: minimumInteritemSpacing, right: minimumInteritemSpacing)

        
    }
    
    
}
