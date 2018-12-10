//
//  TagsCollectionViewDelegateAndDataSource.swift
//  Pomar
//
//  Created by Alan Victor Paulino de Oliveira on 01/12/18.
//  Copyright © 2018 Paloma Bispo. All rights reserved.
//

import Foundation
import UIKit

class TagsCollectionViewDelegateAndDataSource:NSObject, UICollectionViewDelegate,UICollectionViewDataSource{
    
    static var tags:[String] = []
    var delegate: TagsSuggestionCollectionDelegate?
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return TagsCollectionViewDelegateAndDataSource.tags.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "tags", for: indexPath) as! TagsSuggestionCollectionViewCell
        
        cell.label.text = TagsCollectionViewDelegateAndDataSource.tags[indexPath.row]
//        cell.loadCell()
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let tag =  TagsCollectionViewDelegateAndDataSource.tags[indexPath.row]
        delegate?.tapInTag(tagText: tag)
        subjects = subjects.filter { $0 !=  tag}
    }
    
}
