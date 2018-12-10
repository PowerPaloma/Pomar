//
//  CollectionSkillsDelegateAndDataSource.swift
//  Pomar
//
//  Created by Alan Victor Paulino de Oliveira on 09/12/18.
//  Copyright © 2018 Paloma Bispo. All rights reserved.
//

import UIKit

class CollectionSkillsDelegateAndDataSource: NSObject,UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var skills = ["UIKIT","COLLECTIONVIEW","UIKIT","COLLECTIONVIEW","UIKIT","COLLECTIONVIEW","UIKIT","COLLECTIONVIEW","UIKIT","COLLECTIONVIEW","UIKIT","COLLECTIONVIEW","UIKIT","COLLECTIONVIEW","UIKIT","COLLECTIONVIEW","UIKIT","COLLECTIONVIEW"]
    
    let minimumInteritemSpacing: CGFloat = 4
    let minimumLineSpacing:CGFloat = 8
    let numberOfLinesInCollection = 3
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        if isLimited{
//            return numbersOfTags(collectionView)
//        }else{
//            return tags.count
//        }
        
//        sortSkills(collectionView)
        return skills.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellSkills", for: indexPath) as! SkillsCollectionViewCell
        
        cell.label.text = skills[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let tag = skills[indexPath.row] as NSString
        let size = tag.size(withAttributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 12)])
        
        let customHeight = (collectionView.frame.height/3) - 12
        
        return CGSize(width: size.width + 16, height: customHeight)
    }
    
    func numbersOfTags(_ collectionView: UICollectionView) -> Int {
        //        var tagsInfo: [(String, CGFloat)] = []
        var count: CGFloat = 0.0
        var ret: [(String, CGFloat)] = []
        var countOfLines = numberOfLinesInCollection
        
        var skillsInfo: [(String, CGFloat)] = skills.map { (tagName) -> (String, CGFloat) in
            let nsSkill = tagName as NSString
            let size = nsSkill.size(withAttributes: nil)
            return (tagName, size.width + 9)
        }
        
         skillsInfo.sort { (elem1, elem2) -> Bool in
            return elem1.1 < elem2.1
        }
        for skill in skillsInfo {
            count += skill.1  + minimumInteritemSpacing + minimumLineSpacing
            if count < collectionView.frame.width - minimumInteritemSpacing && countOfLines > 0 {
                ret.append(skill)
            }else{
                self.skills = skillsInfo.map({ (elem) -> String in
                    return elem.0
                })
                countOfLines -= 1
                count = 0
                if countOfLines == 0{
                    return ret.count
                }
                
            }
        }
        
        return ret.count
    }
    
    func sortSkills(_ collectionView:UICollectionView){
        var skillsInfo: [(String, CGFloat)] = skills.map { (tagName) -> (String, CGFloat) in
            let nsSkill = tagName as NSString
            let size = nsSkill.size(withAttributes: nil)
            return (tagName, size.width + 9)
        }
        
        skillsInfo.sort { (elem1, elem2) -> Bool in
            return elem1.1 < elem2.1
        }
        
        self.skills = skillsInfo.map({ (name,_) -> String in
            return name
        })
    }
    
    

}
