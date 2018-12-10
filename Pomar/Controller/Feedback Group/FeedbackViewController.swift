//
//  FeedbackViewController.swift
//  Pomar
//
//  Created by Mateus Rodrigues on 28/11/18.
//  Copyright © 2018 Paloma Bispo. All rights reserved.
//

import UIKit
import CloudKit

class FeedbackViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var stackBackgroundView: UIView!
    
    @IBOutlet weak var redAppleImageView: UIImageView! {
        didSet {
            redAppleImageView.tintColor = AppleType.red.color()
            let drag = UIDragInteraction(delegate: self)
            drag.isEnabled = true
            redAppleImageView.addInteraction(drag)
            redAppleImageView.tag = 1
        }
    }
    
    @IBOutlet weak var yellowAppleImageView: UIImageView! {
        didSet {
            yellowAppleImageView.tintColor = AppleType.yellow.color()
            let drag = UIDragInteraction(delegate: self)
            drag.isEnabled = true
            yellowAppleImageView.addInteraction(drag)
            yellowAppleImageView.tag = 2
        }
    }
    
    @IBOutlet weak var greenAppleImageView: UIImageView! {
        didSet {
            greenAppleImageView.tintColor = AppleType.green.color()
            let drag = UIDragInteraction(delegate: self)
            drag.isEnabled = true
            greenAppleImageView.addInteraction(drag)
            greenAppleImageView.tag = 3
        }
    }
    
    @IBOutlet weak var redLabel: UILabel!
    @IBOutlet weak var indicatorView: UIView!
    
    var users = [User]()
    
    var groupId: CKRecord.ID?
    
    var currentUser: User? {
        didSet{
            let id = CKRecord.ID(recordName: "082D5E81-4294-4BEA-BC2B-EEB24294EB03")
            CKManager.shared.available(userID: currentUser!.id!, groupID: id) { (apples, error) in
                guard let apples = apples else {
                    print(error!.localizedDescription)
                    return
                }
                self.myApples = apples
            }
        }
    }
    
    var myApples: Apples? {
        didSet {
            redApples = myApples!.red
            yellowApples = myApples!.yellow
            greenApples = myApples!.green
        }
    }
    
    var redApples: Int = 0 {
        didSet {
            DispatchQueue.main.async {
                if self.redApples == 0 {
                    self.redAppleImageView.isUserInteractionEnabled = false
                    self.redAppleImageView.tintColor = UIColor.gray
                    UIView.animate(withDuration: 0.5, animations: {
                        self.redLabel.isHidden = true
                        self.indicatorView.backgroundColor = UIColor.clear
                    })
                }
                self.redLabel.text = String(self.redApples)
            }
        }
    }
    
    var yellowApples: Int = 0 {
        didSet {
            DispatchQueue.main.async {
                if self.yellowApples == 0 {
                    self.yellowAppleImageView.isUserInteractionEnabled = false
                    self.yellowAppleImageView.tintColor = UIColor.gray
                }
            }
        }
    }
    
    var greenApples: Int = 0 {
        didSet {
            DispatchQueue.main.async {
                if self.greenApples == 0 {
                    self.greenAppleImageView.isUserInteractionEnabled = false
                    self.greenAppleImageView.tintColor = UIColor.gray
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        groupId = CKRecord.ID(recordName: "082D5E81-4294-4BEA-BC2B-EEB24294EB03")
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.dropDelegate = self
        
        collectionView.register(UINib(nibName: "UserViewCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        
        view.addInteraction(UIDropInteraction(delegate: self))
        
        CKManager.shared.fetchUsers(groupID: groupId!) { (users, error) in
            guard let users = users else {
                print(error?.localizedDescription)
                return
            }
            
            self.currentUser = users.first
            
            self.users = users
            self.users.remove(at: 0)
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
            
        }
        

    }
    
    override func viewDidLayoutSubviews() {
        indicatorView.layer.cornerRadius = indicatorView.frame.width/2
        
        stackBackgroundView.layer.cornerRadius = 10
    }

}

extension FeedbackViewController: UICollectionViewDataSource , UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return users.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let user = users[indexPath.item]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! UserViewCell
        cell.user = user
        CKManager.shared.fetchImage(reference: user.imageRef!) { (image, error) in
            DispatchQueue.main.async {
                guard let image = image else {
                    return
                }
                cell.image = image
            }
        }
        return cell
    }
}

extension FeedbackViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = collectionView.bounds
        let width = (bounds.width)/3
        let height = width
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}

extension FeedbackViewController: UICollectionViewDropDelegate {
        
    func collectionView(_ collectionView: UICollectionView, performDropWith coordinator: UICollectionViewDropCoordinator) {
        
        let tag = coordinator.items.first?.dragItem.localObject as! Int
        let type = AppleType(index: tag)
        
        guard let destinationIndexPath = coordinator.destinationIndexPath else {
            return
        }
        
        let cell = collectionView.cellForItem(at: destinationIndexPath) as! UserViewCell
        cell.selectedApple = type
        
        CKManager.shared.incrementUserApple(userID: (cell.user?.id)!, type: type!) { (record, error) in
            guard record != nil else {
                print(error!.localizedDescription)
                return
            }
            
            CKManager.shared.decrementApples(applesID: (self.myApples?.id!)!, type: type!, completion: { (record, error) in
                guard let record = record else {
                    print(error!.localizedDescription)
                    return
                }
                
                self.myApples = Apples(record: record)
                
            })
            
        }
        
    }
    
    
}


extension FeedbackViewController: UIDragInteractionDelegate, UIDropInteractionDelegate {
    
    func dragInteraction(_ interaction: UIDragInteraction, itemsForBeginning session: UIDragSession) -> [UIDragItem] {
        
        if let imageView = interaction.view as? UIImageView {
            
            guard let image = imageView.image else { return [] }
            
            let provider = NSItemProvider(object: image)
            
            let item = UIDragItem(itemProvider: provider)
            item.localObject = imageView.tag
            
            item.previewProvider = {
                let previewParameters = UIDragPreviewParameters()
                previewParameters.backgroundColor = AppleType(index: imageView.tag)?.color()
                previewParameters.visiblePath = AppleShape().path
                let preview = UIDragPreview(view: UIView(), parameters: previewParameters)
                return preview
            }
            
            return [item]
            
        }
        
        return []
        
    }
    
    func dragInteraction(_ interaction: UIDragInteraction, previewForLifting item: UIDragItem, session: UIDragSession) -> UITargetedDragPreview? {

        guard let tag = item.localObject as? Int else { return nil }
        

        let preview = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100 ))
        preview.backgroundColor = AppleType(index: tag)?.color()
        
        let dragView = interaction.view

        let previewParameters = UIDragPreviewParameters()

        let target = UIDragPreviewTarget(container: (dragView?.superview)!, center: dragView!.center)

        previewParameters.visiblePath = AppleShape().path


        return UITargetedDragPreview(view: preview, parameters: previewParameters, target: target)
    }
    
    func dropInteraction(_ interaction: UIDropInteraction, sessionDidUpdate session: UIDropSession) -> UIDropProposal {
        return UIDropProposal(operation: .copy)
    }
    
    func dropInteraction(_ interaction: UIDropInteraction, canHandle session: UIDropSession) -> Bool {
        return session.canLoadObjects(ofClass: UIImage.self)
    }

}
