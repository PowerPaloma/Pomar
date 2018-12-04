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
    var storedOffsets = [Int: CGFloat]()
    let minimumInteritemSpacing: CGFloat = 10
    let minimumLineSpacing:CGFloat = 10
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "ButtonsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "buttons")
        collectionView.register(UINib(nibName: "LabelsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "labels")
        collectionView.register(UINib(nibName: "ShowTagsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "tags")
        collectionView.register(UINib(nibName: "DateCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "date")

//        tableView.register(UINib(nibName: "DateAndTimeTableViewCell", bundle: nil), forCellReuseIdentifier: "viewCell")
//        tableView.register(UINib(nibName: "CollectionTableViewCell", bundle: nil), forCellReuseIdentifier: "tagsCell")
//        tableView.register(UINib(nibName: "CollectionTableViewCell", bundle: nil), forCellReuseIdentifier: "collectionCell")

    }
    

}


extension DetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let group = self.group else {return UICollectionViewCell()}
        switch indexPath.row {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "buttons", for: indexPath)
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "labels", for: indexPath) as! LabelsCollectionViewCell
            cell.labelDescription.text = group.description
            return cell
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "tags", for: indexPath) as! ShowTagsCollectionViewCell
            cell.backgroundColor = UIColor.red
            modelTag = ModelTag(tags: group.tags, isLimited: false)
            cell.setCollectionViewDataSourceDelegate(modelTag, forRow: indexPath.row)
            cell.collectionViewOffset = storedOffsets[indexPath.row] ?? 0
            return cell
        case 3:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "date", for: indexPath) as! DateCollectionViewCell
//            if group.isWeekly {
//                if let schedulesGroup = group.schedule {
//                    
//                    let map:[(Int, Date)] = schedulesGroup.map { (daySchedule) -> (Int, Date) in
//                        
//                        return (daySchedule.day)
//                    }
//                    let hours = schedulesGroup.map { (daySchedule) -> String in
//                        return daySchedule.hour
//                    }
//                   
//                }
//            }else{
//                
//            }
            return cell
//
        default:
            return UICollectionViewCell()
        
        }
    }
    
    
}

extension DetailsViewController: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemWidth = collectionView.frame.size.width - (minimumInteritemSpacing + minimumLineSpacing)
        switch indexPath.row {
        case 0:
            return CGSize.init(width: itemWidth, height: 50)
        case 1:
            return CGSize.init(width: itemWidth, height: 60)
        case 2:
//            let cell = collectionView.cellForItem(at:indexPath) as! ShowTagsCollectionViewCell
//                let heigth = cell.collection.contentSize.height + cell.labelTitle.frame.height + 8*3
//                return CGSize.init(width: itemWidth, height: heigth)
//            }else{
                return CGSize.init(width: itemWidth, height: 80)
//            }

        case 3:
            return CGSize.init(width: itemWidth, height: 160)
        default:
            return CGSize.zero
        }
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


//extension DetailsViewController: UITableViewDelegate, UITableViewDataSource{
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 5
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let group = self.group else {return UITableViewCell()}
//
//        switch indexPath.row {
//        case 0:
//            let cell = tableView.dequeueReusableCell(withIdentifier: "buttonsCell", for: indexPath) as! ButtonsTableViewCell
//            cell.backgroundColor = UIColor.red
//            return cell
//        case 1:
//            let cell = tableView.dequeueReusableCell(withIdentifier: "labelCell", for: indexPath) as! LabelsTableViewCell
//            cell.backgroundColor = UIColor.white
//            return cell
//        case 2:
//            let cell = tableView.dequeueReusableCell(withIdentifier: "tagsCell", for: indexPath) as! CollectionTableViewCell
//            cell.backgroundColor = UIColor.blue
//            cell.labelTitle.text = "Tags"
//            modelTag = ModelTag(tags: group.tags)
//            cell.setCollectionViewDataSourceDelegate(modelTag, forRow: indexPath.row)
//            cell.collectionViewOffset = storedOffsets[indexPath.row] ?? 0
//
//            return cell
//        case 3:
//            let cell = tableView.dequeueReusableCell(withIdentifier: "viewCell", for: indexPath) as! DateAndTimeTableViewCell
//            cell.backgroundColor = UIColor.black
//            cell.labelTitle.text = "Date and Time"
//            return cell
//        case 4:
//            let cell = tableView.dequeueReusableCell(withIdentifier: "collectionCell", for: indexPath) as! CollectionTableViewCell
//            cell.labelTitle.text = "Date and Time"
//            cell.backgroundColor = UIColor.green
////            let view = DateAndTime()
////            view.translatesAutoresizingMaskIntoConstraints = false
//            return cell
//
//        default:
//            let cell = UITableViewCell()
//            return cell
//        }
//
//
//    }
//
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        switch indexPath.row {
//        case 0:
//            return 10
//        case 1:
//            return 10
//        case 2:
//            return 100
//        case 3:
//            return 100
//        default:
//            return 100
//        }
//    }
//
//
//
//}
//
//extension Bundle {
//
//    static func loadView<T>(fromNib name: String, withType type: T.Type) -> T {
//        if let view = Bundle.main.loadNibNamed(name, owner: nil, options: nil)?.first as? T {
//            return view
//        }
//
//        fatalError("Could not load view with type " + String(describing: type))
//    }
//}
