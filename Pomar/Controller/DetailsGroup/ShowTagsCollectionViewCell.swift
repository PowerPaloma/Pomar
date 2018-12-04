//
//  ShowTagsCollectionViewCell.swift
//  Pomar
//
//  Created by Paloma Bispo on 03/12/18.
//  Copyright © 2018 Paloma Bispo. All rights reserved.
//

import UIKit

class ShowTagsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var collection: UICollectionView!
    @IBOutlet weak var labelTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collection.register(UINib(nibName: "TagsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "TagsCollectionViewCell")
        // Initialization code
    }

}


extension ShowTagsCollectionViewCell {
    
    func setCollectionViewDataSourceDelegate<D: UICollectionViewDataSource & UICollectionViewDelegate>(_ dataSourceDelegate: D, forRow row: Int) {
        
        collection.delegate = dataSourceDelegate
        collection.dataSource = dataSourceDelegate
        collection.tag = row
        collection.setContentOffset(collection.contentOffset, animated:false) // Stops collection view if it was scrolling.
        collection.reloadData()
    }
    
    var collectionViewOffset: CGFloat {
        set { collection.contentOffset.x = newValue }
        get { return collection.contentOffset.x }
    }
}
