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
    let minimumInteritemSpacing: CGFloat = 32
    let minimumLineSpacing:CGFloat = 32
    var storedOffsets = [Int: CGFloat]()
    var navBar: UINavigationBar = UINavigationBar()
    var groups: [Group] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "GroupsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cellGroup")
        
        navigationController?.navigationBar.isHidden = true
//        let screen = UIScreen.main.bounds
//
//        let frame = CGRect(x: 32, y: 32, width: 150, height: 70)
//        let userMoney = UserMoney(frame: frame)
//        userMoney.backgroundColor = UIColor.blue
//        self.view.addSubview(userMoney)
    
        
    }
    
    private func setupNavigation(){
//        let coins = UIButton(type: .system)
//        coins.setImage(UIImage(named: "addButton")?.withRenderingMode(.alwaysOriginal), for: .normal)
//        coins.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
//
////        backButtonView.bounds = CGRectOffset(backButtonView.bounds, -14, -7);
////        navigationItem.rightBarButtonItemd
//        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: coins)
////        naviga
//        guard let bounds = self.navigationController?.navigationBar.bounds else {return}
//        print(bounds.height)
//        self.navigationController?.navigationBar.bounds = CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height + 100)
//         guard let bounds2 = self.navigationController?.navigationBar.bounds else {return}
//        print(bounds2.height)
        
        
//        let coin = UIButton(frame: CGRect(x: 7, y: 30, width: 35, height: 35))
//        coin.setImage(UIImage(named: "addButton")?.withRenderingMode(.alwaysOriginal), for: .normal)
//        let coinView =  UIView(frame: CGRect(x: 0.0, y: 0.0, width: 46, height: 40))
//       coinView.addSubview(coin)
//        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: coinView)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        CKManager.shared.fetchGroups { (groups) in
            self.groups =  groups
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
        setupNavigation()
        //let height: CGFloat = 80 //whatever height you want to add to the existing height
        //guard let bounds = self.navigationController?.navigationBar.bounds else {return}
        //self.navigationController?.navigationBar.bounds = CGRect(x: 0, y: -100, width: bounds.width, height: bounds.height + 60)
        
    }
    

    
}

extension StudyGroupsViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groups.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellGroup", for: indexPath) as! GroupsCollectionViewCell
        
        cell.contentView.layer.cornerRadius = 12.0
        cell.contentView.layer.borderWidth = 1.0
        cell.contentView.layer.borderColor = UIColor.clear.cgColor
        cell.contentView.layer.masksToBounds = true;
        
        cell.layer.shadowColor = UIColor.lightGray.cgColor
        cell.layer.shadowOffset = CGSize(width:0,height: 2.0)
        cell.layer.shadowRadius = 5.0
        cell.layer.shadowOpacity = 0.7
        cell.layer.masksToBounds = false;
        cell.layer.shadowPath = UIBezierPath(roundedRect:cell.bounds, cornerRadius:cell.contentView.layer.cornerRadius).cgPath
        let group = groups[indexPath.row]
        cell.nameGroup.text = group.name
        guard let schedulesGroup = group.schedule else {return cell}
        let days = schedulesGroup.map { (daySchedule) -> String in
            return daySchedule.day
        }
        let hours = schedulesGroup.map { (daySchedule) -> String in
            return daySchedule.hour
        }
        if hours.count > 1{
            cell.hoursGroup.text = "Multiples"
        }else if  hours.count == 1{
            cell.hoursGroup.text = hours[0]
        }else{
            cell.hoursGroup.text = ""
        }
        cell.daysGroup.text = days.joined(separator: " ")
        
        //cell.setCollectionViewDataSourceDelegate(self, forRow: indexPath.row)
        //cell.collectionViewOffset = storedOffsets[indexPath.row] ?? 0
        
        return cell
        
        
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
