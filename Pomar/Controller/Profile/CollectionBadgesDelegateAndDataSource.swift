//
//  CollectionBadgesDelegateAndDataSource.swift
//  Pomar
//
//  Created by Alan Victor Paulino de Oliveira on 09/12/18.
//  Copyright © 2018 Paloma Bispo. All rights reserved.
//

import UIKit

class CollectionBadgesDelegateAndDataSource: NSObject, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate{
    
    let badges:[UIImage] = [#imageLiteral(resourceName: "style"),#imageLiteral(resourceName: "table-view"),#imageLiteral(resourceName: "collection-view"),#imageLiteral(resourceName: "designer"),#imageLiteral(resourceName: "well-done"),#imageLiteral(resourceName: "deleg-missons"),#imageLiteral(resourceName: "shared"),#imageLiteral(resourceName: "money-pocket"),#imageLiteral(resourceName: "material"),#imageLiteral(resourceName: "uikit")]
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return badges.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellBadges", for: indexPath) as! BadgesCollectionViewCell
        
        cell.imageBadge.image = badges[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = (collectionView.frame.height / 2) - 20
        let width = height
        
        return CGSize(width: width, height: height)
    }
    

    
    
}
