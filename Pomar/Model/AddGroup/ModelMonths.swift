//
//  ModelMonths.swift
//  Pomar
//
//  Created by Paloma Bispo on 08/12/18.
//  Copyright © 2018 Paloma Bispo. All rights reserved.
//

import Foundation
import UIKit

class ModelMonths: NSObject, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    let collectionView: UICollectionView!
    let minimumInteritemSpacing: CGFloat = 16
    let minimumLineSpacing:CGFloat = 16
    var months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    var modelDays: ModelDays!
    var start = true

    
    init(collection: UICollectionView, modelDays: ModelDays) {
        self.collectionView = collection
        self.modelDays = modelDays
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return months.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "month", for: indexPath) as! MonthCollectionViewCell
        cell.monthLabel.text = months[indexPath.row]
        if indexPath.row == 1 && start{
            cell.isSelected = true
            
        }
        cell.clipsToBounds = true
        cell.layer.cornerRadius = 8
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let month = self.months[indexPath.row] as NSString
        let size = month.size(withAttributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 16)])
        return CGSize(width: size.width + 16, height: collectionView.frame.height - minimumLineSpacing )
//        let itemWidth = collectionView.frame.width - (minimumInteritemSpacing + minimumLineSpacing)
//        return CGSize(width: itemWidth/3, height: collectionView.frame.height - minimumLineSpacing )
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return minimumLineSpacing
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return minimumInteritemSpacing
    }
    
 
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if start{
            let cell = collectionView.cellForItem(at: IndexPath(item: 1, section: 0))
            cell?.isSelected = false
            start = false
        }
        
        modelDays.daysIn(month: indexPath.row+1)
        modelDays.collection.reloadData()
        modelDays.collection.setContentOffset(CGPoint.zero, animated: true)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
}







