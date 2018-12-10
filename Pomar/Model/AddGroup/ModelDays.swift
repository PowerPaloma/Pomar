//
//  ModelDays.swift
//  Pomar
//
//  Created by Paloma Bispo on 08/12/18.
//  Copyright © 2018 Paloma Bispo. All rights reserved.
//


import Foundation
import UIKit

class ModelDays: NSObject, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    let minimumInteritemSpacing: CGFloat = 20
    let minimumLineSpacing:CGFloat = 20
    var numDays = 0
    var collection: UICollectionView!
    var offsetDays = 0
    var weekStart = 0
    var selectedDaysProtocol: SelectedDaysProtocol? = nil
    var selectedDays: [Bool] = [false, false, false, false, false]
    
    init(month: Int) {
        super.init()
       self.daysIn(month: month)
    }
    
     convenience init(month: Int, collection: UICollectionView) {
        self.init(month: month)
        self.collection = collection
      
    }
    
    func daysIn(month: Int){
        let date = Date()
        let calendar = Calendar.current
        let year =  calendar.component(.year, from: date)
        let dateComponents = DateComponents(year: year, month: month)
        guard let dateRange = calendar.date(from: dateComponents) else {return}
        guard let range = calendar.range(of: .day, in: .month, for: dateRange) else {return}
        weekStart = Calendar.current.component(.weekday, from: dateRange) - 2
//        if weekStart == 5 {
//            weekStart = 0
//        }
        self.numDays = range.count
        if numDays < 30{
           offsetDays = (30 + weekStart - 1) - numDays
        }else if numDays > 30{
            offsetDays = (35 + weekStart - 1) - numDays
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numDays + offsetDays + weekStart
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "day", for: indexPath) as! DayCollectionViewCell
        
        if indexPath.row < weekStart {
             cell.dayLabel.text = ""
            cell.isUserInteractionEnabled = false
        }else if indexPath.row < numDays + weekStart {
             cell.dayLabel.text = "\(indexPath.row + 1 - weekStart )"
        }else if indexPath.row > numDays {
            cell.dayLabel.text = ""
            cell.isUserInteractionEnabled = false
        }
        cell.background.backgroundColor = #colorLiteral(red: 0.9628338218, green: 0.9729439616, blue: 0.9768897891, alpha: 1)
        cell.clipsToBounds = true
        cell.layer.cornerRadius = cell.frame.height / 2
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let itemWidth = collectionView.frame.width - (20*6)
            return CGSize(width: itemWidth/5, height: itemWidth/5 )
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return minimumLineSpacing
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return minimumInteritemSpacing
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let index = indexPath.row % 5
        self.selectedDays[index] = false
        selectedDaysProtocol?.selected(days: selectedDays)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let index = indexPath.row % 5
        self.selectedDays[index] = true
        selectedDaysProtocol?.selected(days: selectedDays)
        
    }
}


extension ModelDays: UIScrollViewDelegate {
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        let pageWidth: CGFloat = self.collection.frame.width - 20
//            ((((self.collection.frame.width - 20))/5) - 20) * 5
        
//            ((self.collection.frame.width - (20*6) - 20*2)/5) * 5
        
        let currentOffset = scrollView.contentOffset.x
        let targetOffset = targetContentOffset.pointee.x
        var newTargetOffset: Float = 0.0
        
        if (targetOffset > currentOffset){
            newTargetOffset = ceilf(Float(currentOffset / pageWidth)) * Float(pageWidth)
        }else{
            newTargetOffset = floorf(Float(currentOffset / pageWidth)) * Float(pageWidth)
        }
        if (newTargetOffset < 0){
            newTargetOffset = 0;
        }else if (newTargetOffset > Float(scrollView.contentSize.width)){
            newTargetOffset = Float(scrollView.contentSize.width);
        }
        targetContentOffset.pointee.x = currentOffset;
            scrollView.setContentOffset(CGPoint(x: CGFloat(newTargetOffset), y: scrollView.contentOffset.y), animated: true)
        selectedDays = [false, false, false, false, false]
        selectedDaysProtocol?.selected(days: selectedDays)
          
    }
   
}
