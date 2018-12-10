//
//  ModelHours.swift
//  Pomar
//
//  Created by Paloma Bispo on 09/12/18.
//  Copyright © 2018 Paloma Bispo. All rights reserved.
//

import Foundation

//
//  ModelMonths.swift
//  Pomar
//
//  Created by Paloma Bispo on 08/12/18.
//  Copyright © 2018 Paloma Bispo. All rights reserved.
//

import Foundation
import UIKit

class ModelHours: NSObject, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    let minimumInteritemSpacing: CGFloat = 4
    let minimumLineSpacing:CGFloat = 4
    var hours = ["00:00", "00:00", "00:00", "00:00", "00:00"]
    var scroll: UIScrollView!
    var hourPicker: UIPickerView!
    var accessoryToolbar: UIToolbar!
    
    
    init(scroll: UIScrollView, hourPicker: UIPickerView, accessoryToolbar: UIToolbar) {
        self.scroll = scroll
        self.hourPicker = hourPicker
        self.accessoryToolbar = accessoryToolbar
    }
    
    
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return hours.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "hour", for: indexPath) as! HourCollectionViewCell
        cell.hourTxtField.text = hours[indexPath.row]
        cell.hourTxtField.inputView = hourPicker
        cell.hourTxtField.inputAccessoryView = accessoryToolbar
        cell.clipsToBounds = true
        cell.layer.cornerRadius = 8
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemWidth = collectionView.frame.width
        return CGSize(width: itemWidth/6 , height: collectionView.frame.height - 16 )

    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return minimumLineSpacing
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return minimumInteritemSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    }
    
    
    
}







