//
//  ModelCollection.swift
//  Pomar
//
//  Created by Paloma Bispo on 04/12/18.
//  Copyright © 2018 Paloma Bispo. All rights reserved.
//

import Foundation
import UIKit

class ModelCollection: NSObject, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    let minimumInteritemSpacing: CGFloat = 8
    let minimumLineSpacing:CGFloat = 8
    var tags: [String]!
    var isLimited: BooleanLiteralType!
    
    init(tags: [String], isLimited: Bool) {
        self.tags = tags
        self.isLimited = isLimited
    }
    
    
    func numbersOfTags(_ collectionView: UICollectionView) -> Int {
        //        var tagsInfo: [(String, CGFloat)] = []
        var count: CGFloat = 0.0
        var ret: [(String, CGFloat)] = []
        
        var tagsInfo: [(String, CGFloat)] = tags.map { (tagName) -> (String, CGFloat) in
            let nsTag = tagName as NSString
            let size = nsTag.size(withAttributes: nil)
            return (tagName, size.width + 9)
        }
        
        tagsInfo.sort { (elem1, elem2) -> Bool in
            return elem1.1 < elem2.1
        }
        for tag in tagsInfo {
            count += tag.1  + minimumInteritemSpacing + minimumLineSpacing
            if count < collectionView.frame.width - minimumInteritemSpacing {
                ret.append(tag)
            }else{
                self.tags = tagsInfo.map({ (elem) -> String in
                    return elem.0
                })
                return ret.count
                
            }
        }
        
        return ret.count
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isLimited{
            return numbersOfTags(collectionView)
        }else{
            return tags.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TagsCollectionViewCell", for: indexPath) as! TagsCollectionViewCell
        cell.tagName.text = tags[indexPath.row]
        cell.tagName.sizeToFit()
        cell.background.layer.borderColor = UIColor(red: 0.7, green: 0, blue: 0.02, alpha: 1).cgColor
        cell.background.layer.borderWidth = 0.5
        cell.background.clipsToBounds = true
        cell.background.layer.cornerRadius = 10
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let tag = tags[indexPath.row] as NSString
        let size = tag.size(withAttributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 12)])
        return CGSize(width: size.width + 8, height: collectionView.frame.height*0.6)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return minimumLineSpacing
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return minimumInteritemSpacing
    }
}
