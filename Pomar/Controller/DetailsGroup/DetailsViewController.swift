//
//  DetailsViewController.swift
//  Pomar
//
//  Created by Paloma Bispo on 03/12/18.
//  Copyright © 2018 Paloma Bispo. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    
    var group: Group? = nil
    var modelTag: ModelTag!
    var modelMember: ModelMembers!
    var tags: [String] = []
    var storedOffsets = [Int: CGFloat]()
    let minimumInteritemSpacing: CGFloat = 10
    let minimumLineSpacing:CGFloat = 10
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var joinButton: UIButton!
    @IBOutlet weak var feedbackButton: UIButton!
    let flowLayout = FlowLayout()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "ButtonsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "buttons")
        collectionView.register(UINib(nibName: "LabelsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "labels")
        collectionView.register(UINib(nibName: "ShowTagsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "tags")
        collectionView.register(UINib(nibName: "DateCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "date")
        collectionView.register(UINib(nibName: "ParticipantsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "members")
        collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "footer")
        collectionView.collectionViewLayout = flowLayout
        collectionView.contentInsetAdjustmentBehavior = .always
        setup()

    }

    func setup(){
        collectionView.clipsToBounds = true
        collectionView.layer.cornerRadius = 12.0
        joinButton.clipsToBounds = true
        joinButton.layer.cornerRadius = 8.0
        feedbackButton.clipsToBounds = true
        feedbackButton.layer.cornerRadius = 8.0
        collectionView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    }
    
    @objc func buttonAction(sender: UIButton!) {
        let storyboard = UIStoryboard(name: "Feedback", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "feedback") as! FeedbackViewController
        controller.groupId = self.group?.id
        self.present(controller, animated: true, completion: nil)
    }
}


extension DetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch kind {
            
        case UICollectionView.elementKindSectionHeader:
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath)
            return headerView
            
        case UICollectionView.elementKindSectionFooter:
            let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "footer", for: indexPath)
            guard let view = footerView.viewWithTag(2) else {return footerView}
            view.clipsToBounds = true
            view.layer.cornerRadius = 12.0
            view.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
            return footerView
            
        default:
            assert(false, "Unexpected element kind")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let group = self.group else {return UICollectionViewCell()}
        switch indexPath.row {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "buttons", for: indexPath) as! ButtonsCollectionViewCell
            cell.feedbackButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "labels", for: indexPath) as! LabelsCollectionViewCell
            cell.labelDescription.text = group.description
            return cell
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "tags", for: indexPath) as! ShowTagsCollectionViewCell
            cell.tableView.dataSource = self
            cell.tableView.delegate = self
            cell.tableView.rowHeight = UITableView.automaticDimension
            cell.tableView.estimatedRowHeight = 100

            tags = group.tags
//            modelTag = ModelTag(tags: group.tags, isLimited: false)
//            cell.setCollectionViewDataSourceDelegate(modelTag, forRow: indexPath.row)
//            cell.collectionViewOffset = storedOffsets[indexPath.row] ?? 0
            return cell
        case 3:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "date", for: indexPath) as! DateCollectionViewCell
            if group.isWeekly {
                if let schedulesGroup = group.schedule {
                    var aux = [(false, ""), (false, "" ), (false, "" ), (false, "" ), (false, "" )]
                    let scheduleInfo = schedulesGroup.map { (daySchedule) -> (String, String) in
                        return (daySchedule.day, daySchedule.hour)
                    }
                    for d in scheduleInfo {
                        switch d.0{
                        case "Monday":
                            aux[0] = (true, d.1)
                        case "Tuesday":
                             aux[1] = (true, d.1)
                        case "Wednesday":
                             aux[2] = (true, d.1)
                        case "Thursday":
                             aux[3] = (true, d.1)
                        case "Friday":
                             aux[4] = (true, d.1)
                        default:
                            break
                        }
                    }
                    for (index, info) in aux.enumerated() {
                        if info.0 {
                            let date = cell.dates[index]
                            let hour = cell.hours[index]
                            date.layer.borderWidth = 1
                            date.layer.borderColor = UIColor(red: 178/255, green: 0, blue: 6/255, alpha: 1).cgColor
                            date.backgroundColor = UIColor(red: 178/255, green: 0, blue: 6/255, alpha: 1)
                            
                            hour.text = info.1
                            hour.layer.borderWidth = 1
                            hour.clipsToBounds = true
                            hour.layer.cornerRadius = 8
                            hour.layer.borderColor = UIColor(red: 178/255, green: 0, blue: 6/255, alpha: 1).cgColor
                        }
                        
                    }
                   
                }
            }else{
                
            }
            return cell
        case 4:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "members", for: indexPath) as! ParticipantsCollectionViewCell
            guard let idGroup = group.id else {return cell}
            CKManager.shared.fetchUsers(groupID: idGroup) { (membersGroup, error) in
                if error != nil{
                    return
                }else{
                        guard let members = membersGroup else {return}
                    self.modelMember = ModelMembers(members: members)
                    cell.setCollectionViewDataSourceDelegate(self.modelMember, forRow: indexPath.row)
                    cell.collectionViewOffset = self.storedOffsets[indexPath.row] ?? 0
                }
            }
            
             return cell
            

        default:
            assert(false, "Unexpected element kind")
        
        }
    }
    
    
}

//extension DetailsViewController: UICollectionViewDelegateFlowLayout{
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let itemWidth = collectionView.frame.size.width - (minimumInteritemSpacing + minimumLineSpacing)
//        switch indexPath.row {
////        case 0:
////            return CGSize.init(width: itemWidth, height: 100)
//        case 1:
//            return CGSize.init(width: itemWidth, height: 160)
//        case 2:
//            return CGSize.init(width: itemWidth, height: 100)
//
//        case 3:
//            return CGSize.init(width: itemWidth, height: 200)
//        case 4:
//            return CGSize.init(width: itemWidth, height: 100)
//        default:
//            return CGSize.zero
//        }
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return minimumLineSpacing
//    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return minimumInteritemSpacing
//    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return UIEdgeInsets(top: minimumInteritemSpacing, left: minimumInteritemSpacing, bottom: minimumInteritemSpacing, right: minimumInteritemSpacing)
//        
//        
//    }
//    
//}



extension DetailsViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tags.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TagsTableViewCell", for: indexPath) as! TagsTableViewCell
        cell.tagName.text = tags[indexPath.row]
        cell.tagName.sizeToFit()
        cell.background.layer.borderColor = UIColor(red: 0.7, green: 0, blue: 0.02, alpha: 1).cgColor
        cell.background.layer.borderWidth = 0.5
        cell.background.clipsToBounds = true
        cell.background.layer.cornerRadius = 10
        return cell
    }
    
    
    
    
    
}
