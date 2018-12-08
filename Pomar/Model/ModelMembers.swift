//
//  ModelTag.swift
//  Pomar
//
//  Created by Paloma Bispo on 29/11/18.
//  Copyright © 2018 Paloma Bispo. All rights reserved.
//

import Foundation
import UIKit
class ModelMembers: NSObject, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    let minimumInteritemSpacing: CGFloat = 0
    let minimumLineSpacing:CGFloat = 4
    var members: [User]!
    
    init(members: [User]) {
        self.members = members
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.members.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MembersCollectionViewCell", for: indexPath) as! MembersCollectionViewCell
        let member = self.members[indexPath.row]
        guard let imageMember = member.imageRef else {return cell}
        CKManager.shared.fetchImage(reference: imageMember) { (image, error) in
            DispatchQueue.main.async {
                guard let image = image else {
                    return
                }
                cell.imageAux = image
            }
        }
        
        cell.clipsToBounds = true
        cell.layer.cornerRadius = cell.frame.width / 2
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = collectionView.frame.size.height - (minimumInteritemSpacing + minimumLineSpacing)
        return CGSize.init(width:  height, height: height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return minimumLineSpacing
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return minimumInteritemSpacing
    }
    
    
    
    
  
}
