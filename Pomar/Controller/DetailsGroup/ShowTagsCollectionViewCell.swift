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
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        tableView.register(UINib(nibName: "TagsTableViewCell", bundle: nil), forCellReuseIdentifier: "TagsTableViewCell")
//        collection.register(UINib(nibName: "TagsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "TagsCollectionViewCell")
        // Initialization code
    }
//    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
//        layoutIfNeeded()
//        let layoutAttributes = super.preferredLayoutAttributesFitting(layoutAttributes)
//        layoutAttributes.bounds.size = systemLayoutSizeFitting(UIView.layoutFittingCompressedSize, withHorizontalFittingPriority: .required, verticalFittingPriority: .defaultLow)
//        return layoutAttributes
//    }
//    
    
        override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {
            return contentView.systemLayoutSizeFitting(CGSize(width: targetSize.width, height: 1))
        }

}


extension ShowTagsCollectionViewCell {
    
//    func setCollectionViewDataSourceDelegate<D: UICollectionViewDataSource & UICollectionViewDelegate>(_ dataSourceDelegate: D, forRow row: Int) {
//        
//        collection.delegate = dataSourceDelegate
//        collection.dataSource = dataSourceDelegate
//        collection.tag = row
//        collection.setContentOffset(collection.contentOffset, animated:false) // Stops collection view if it was scrolling.
//        collection.reloadData()
//    }
//    
//    var collectionViewOffset: CGFloat {
//        set { collection.contentOffset.x = newValue }
//        get { return collection.contentOffset.x }
//    }
}
