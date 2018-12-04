//
//  GroupsCollectionViewCell.swift
//  Pomar
//
//  Created by Paloma Bispo on 15/11/18.
//  Copyright © 2018 Paloma Bispo. All rights reserved.
//

import UIKit

class GroupsCollectionViewCell: UICollectionViewCell {


    @IBOutlet weak var joinButton: UIButton!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var hoursGroup: UILabel!
    @IBOutlet weak var tagsCollectionView: UICollectionView!
    @IBOutlet weak var daysGroup: UILabel!
    @IBOutlet weak var nameGroup: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        tagsCollectionView.register(UINib(nibName: "TagsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "TagsCollectionViewCell")
//       print(joinButton.frame.size.height)
        
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        joinButton.clipsToBounds = true
        joinButton.layer.cornerRadius = joinButton.frame.size.height / 2
    }

}

extension GroupsCollectionViewCell {
    
    func setCollectionViewDataSourceDelegate<D: UICollectionViewDataSource & UICollectionViewDelegate>(_ dataSourceDelegate: D, forRow row: Int) {
        
        tagsCollectionView.delegate = dataSourceDelegate
        tagsCollectionView.dataSource = dataSourceDelegate
        tagsCollectionView.tag = row
        tagsCollectionView.setContentOffset(tagsCollectionView.contentOffset, animated:false) // Stops collection view if it was scrolling.
        tagsCollectionView.reloadData()
    }
    
    var collectionViewOffset: CGFloat {
        set { tagsCollectionView.contentOffset.x = newValue }
        get { return tagsCollectionView.contentOffset.x }
    }
}

