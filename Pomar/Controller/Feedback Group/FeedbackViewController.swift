//
//  FeedbackViewController.swift
//  Pomar
//
//  Created by Mateus Rodrigues on 28/11/18.
//  Copyright © 2018 Paloma Bispo. All rights reserved.
//

import UIKit

class FeedbackViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var redAppleImageView: UIImageView! {
        didSet {
            redAppleImageView.tintColor = AppleType.red.color()
            let drag = UIDragInteraction(delegate: self)
            drag.isEnabled = true
            redAppleImageView.addInteraction(drag)
        }
    }
    @IBOutlet weak var yellowAppleImageView: UIImageView! {
        didSet {
            yellowAppleImageView.tintColor = AppleType.yellow.color()
            let drag = UIDragInteraction(delegate: self)
            drag.isEnabled = true
            yellowAppleImageView.addInteraction(drag)
        }
    }
    @IBOutlet weak var greenAppleImageView: UIImageView! {
        didSet {
            greenAppleImageView.tintColor = AppleType.green.color()
            let drag = UIDragInteraction(delegate: self)
            drag.isEnabled = true
            greenAppleImageView.addInteraction(drag)
        }
    }
    
    @IBOutlet weak var redLabel: UILabel!
    @IBOutlet weak var yellowLabel: UILabel!
    @IBOutlet weak var greenLabel: UILabel!
    
    var users: [String] = ["Alan", "Mateus", "Thalia", "Paloma", "Cibele", "Elias"]
//    var users = [User]()
    
    var selectedView: UIView?
    
    var applePath: UIBezierPath {
        let shape = UIBezierPath()
        shape.move(to: CGPoint(x: 68.12, y: 123.67))
        shape.addCurve(to: CGPoint(x: 55.71, y: 38.19), controlPoint1: CGPoint(x: 17.02, y: 173.55), controlPoint2: CGPoint(x: -48.04, y: 16.08))
        shape.addCurve(to: CGPoint(x: 68.12, y: 123.67), controlPoint1: CGPoint(x: 140.5, y: -24.68), controlPoint2: CGPoint(x: 146.98, y: 157.59))
        shape.close()
        shape.move(to: CGPoint(x: 74.46, y: 0))
        shape.addCurve(to: CGPoint(x: 42.97, y: 30.47), controlPoint1: CGPoint(x: 49.5, y: 4.11), controlPoint2: CGPoint(x: 39.86, y: 13.67))
        shape.addCurve(to: CGPoint(x: 74.46, y: 0), controlPoint1: CGPoint(x: 56.86, y: 34.73), controlPoint2: CGPoint(x: 73.82, y: 24.95))
        shape.close()
        shape.apply(CGAffineTransform(scaleX: 0.7, y: 0.7))
        return shape
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.dropDelegate = self
        
        collectionView.register(UINib(nibName: "UserViewCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        
        view.addInteraction(UIDropInteraction(delegate: self))

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
//        let user = users[indexPath.item]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! UserViewCell
//        cell.user = user
//        CKManager.shared.fetchImage(reference: user.imageRef!) { (image, error) in
//            DispatchQueue.main.async {
//                guard let image = image else {
//                    return
//                }
//                cell.imageView.image = image
//            }
//        }
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
        
        let selected = coordinator.items.first?.dragItem.localObject as! AppleType
        
        guard let destinationIndexPath = coordinator.destinationIndexPath else {
            return
        }
        
        let cell = collectionView.cellForItem(at: destinationIndexPath) as! UserViewCell
        cell.selectedApple = selected
        
        selectedView?.isUserInteractionEnabled = false
        selectedView?.tintColor = UIColor.gray
        
//        CKManager.shared.incrementUserApple(userID: (cell.user?.id)!, type: selected) { (record, error) in
//            guard let record = record else {
//                print(error!.localizedDescription)
//                return
//            }
//            print(record)
//        }
        
    }
    
    
}


extension FeedbackViewController: UIDragInteractionDelegate, UIDropInteractionDelegate {
    
    func dragInteraction(_ interaction: UIDragInteraction, itemsForBeginning session: UIDragSession) -> [UIDragItem] {
        
        var selected: AppleType?
        
        if let imageView = interaction.view as? UIImageView {
            
            selectedView = imageView
            
            switch imageView {
                case redAppleImageView:
                    selected = .red
                case yellowAppleImageView:
                    selected = .yellow
                case greenAppleImageView:
                    selected = .green
                default:
                    break
            }
            
            guard let image = imageView.image else { return [] }
            
            let provider = NSItemProvider(object: image)
            
            let item = UIDragItem(itemProvider: provider)
            item.localObject = selected

            
            item.previewProvider = {
                let previewParameters = UIDragPreviewParameters()
                previewParameters.backgroundColor = selected?.color()
                previewParameters.visiblePath = self.applePath
                let preview = UIDragPreview(view: UIView(), parameters: previewParameters)
                return preview
            }
            
            return [item]
            
        }
        
        return []
        
    }
    
    func dragInteraction(_ interaction: UIDragInteraction, previewForLifting item: UIDragItem, session: UIDragSession) -> UITargetedDragPreview? {

        guard let selected = item.localObject as? AppleType else { return nil }

        let preview = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100 ))
        preview.backgroundColor = selected.color()
        
        let dragView = interaction.view

        let previewParameters = UIDragPreviewParameters()

        let target = UIDragPreviewTarget(container: (dragView?.superview)!, center: dragView!.center)

        previewParameters.visiblePath = applePath


        return UITargetedDragPreview(view: preview, parameters: previewParameters, target: target)
    }
    
    func dropInteraction(_ interaction: UIDropInteraction, sessionDidUpdate session: UIDropSession) -> UIDropProposal {
        return UIDropProposal(operation: .copy)
    }
    
    func dropInteraction(_ interaction: UIDropInteraction, canHandle session: UIDropSession) -> Bool {
        return session.canLoadObjects(ofClass: UIImage.self)
    }

}
