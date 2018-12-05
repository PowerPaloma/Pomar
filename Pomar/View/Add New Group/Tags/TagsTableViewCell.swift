//
//  TagsTableViewCell.swift
//  Pomar
//
//  Created by Alan Victor Paulino de Oliveira on 29/11/18.
//  Copyright © 2018 Paloma Bispo. All rights reserved.
//

import UIKit

protocol TagsSuggestionCollectionDelegate: class{
    func tapInTag(tagText: String)
}

class TagsTableViewCell: UITableViewCell {

   
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var layoutCollection: UICollectionViewFlowLayout!
    
    @IBOutlet weak var tagsView: UIView!
    var tagsCollectionViewDelegateAndDataSource = TagsCollectionViewDelegateAndDataSource()
    
    let tagsField = WSTagsField()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func loadCell(){
        tagsField.placeholder = "Write Tags"
        tagsField.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        tagsField.layoutMargins = UIEdgeInsets(top: 2, left: 6, bottom: 2, right: 6)
        
        tagsField.translatesAutoresizingMaskIntoConstraints = false
        tagsView.addSubview(tagsField)
        
        NSLayoutConstraint.activate([
            tagsField.topAnchor.constraint(equalTo: tagsView.topAnchor),
            tagsField.leadingAnchor.constraint(equalTo: tagsView.leadingAnchor, constant: 10),
            tagsField.trailingAnchor.constraint(equalTo: tagsView.trailingAnchor, constant: -10),
            tagsView.bottomAnchor.constraint(equalTo: tagsField.bottomAnchor)
            ])
        textFieldEvents()
        
        collectionView.delegate = tagsCollectionViewDelegateAndDataSource
        collectionView.dataSource = tagsCollectionViewDelegateAndDataSource
        tagsCollectionViewDelegateAndDataSource.delegate = self
        
        layoutCollection.estimatedItemSize = CGSize(width: 1, height: 1)
         collectionView.register(TagsSuggestionCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
    }
    
}

extension TagsTableViewCell:TagsSuggestionCollectionDelegate {
    
    fileprivate func textFieldEvents(){
        tagsField.onDidAddTag = { _, _ in
            print("onDidAddTag")
        }
        
        tagsField.onDidRemoveTag = { _, _ in
            print("onDidRemoveTag")
        }
        
        tagsField.onDidChangeText = { _, text in
            let suggestionTags = subjects.filter {$0.localizedCaseInsensitiveContains(text ?? "")}
            print(suggestionTags)
            TagsCollectionViewDelegateAndDataSource.tags = suggestionTags
            self.collectionView.reloadData()
            print("onDidChangeText")
        }
        
        tagsField.onDidChangeHeightTo = { _, height in
            print("HeightTo \(height)")
        }
        
        tagsField.onDidSelectTagView = { _, tagView in
            print("Select \(tagView)")
        }
        
        tagsField.onDidUnselectTagView = { _, tagView in
            print("Unselect \(tagView)")
        }
    }
    
    func tapInTag(tagText: String) {
        tagsField.addTag(tagText)
    }
    func getTags() -> [String] {
        let wsTags = tagsField.tags
        let tags = wsTags.map { (tags) -> String in
            return tags.text
        }
        return tags
        
    }
}




