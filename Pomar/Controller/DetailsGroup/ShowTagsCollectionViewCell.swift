//
//  ShowTagsCollectionViewCell.swift
//  Pomar
//
//  Created by Paloma Bispo on 03/12/18.
//  Copyright © 2018 Paloma Bispo. All rights reserved.
//

import UIKit

class ShowTagsCollectionViewCell: UICollectionViewCell {

    //@IBOutlet weak var collection: UICollectionView!
    @IBOutlet weak var tagView: UIView!
    @IBOutlet weak var labelTitle: UILabel!
//    @IBOutlet weak var tableView: UITableView!
    let tagsField = WSTagsField()
    var heithTagsDelegate: DelegateHeigthTags? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        tagView.addSubview(tagsField)
        tagsField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tagsField.topAnchor.constraint(equalTo: tagView.topAnchor, constant: 0),
            tagsField.leadingAnchor.constraint(equalTo: tagView.leadingAnchor, constant: 0),
            tagsField.trailingAnchor.constraint(equalTo: tagView.trailingAnchor, constant: 0),
            tagView.bottomAnchor.constraint(equalTo: tagView.bottomAnchor, constant: 0)
            ])
        
        tagsField.borderColor = UIColor(red: 178/255, green: 0, blue: 6/255, alpha: 1)
        tagsField.borderWidth = 0.5
        tagsField.tintColor = UIColor.white
        tagsField.textColor = UIColor(red: 178/255, green: 0, blue: 6/255, alpha: 1)
        tagsField.spaceBetweenLines = 10
        tagsField.spaceBetweenTags = 8
        tagsField.font = UIFont.systemFont(ofSize: 12)
        tagsField.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)

    }
    
    func loadCellWith(tags: [String]){
        tagsField.addTags(tags)
        
    }
}


extension ShowTagsCollectionViewCell {
    fileprivate func textFieldEvents(){

        
        tagsField.onDidChangeHeightTo = { _, height in
            print("HeightTo \(height)")
            self.heithTagsDelegate?.get(heigth: height)
            
        }
        
        tagsField.onDidSelectTagView = { _, tagView in
            print("Select \(tagView)")
        }
        
        tagsField.onDidUnselectTagView = { _, tagView in
            print("Unselect \(tagView)")
        }
        
    }

}
