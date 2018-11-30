//
//  FeedbackViewController.swift
//  Pomar
//
//  Created by Mateus Rodrigues on 28/11/18.
//  Copyright © 2018 Paloma Bispo. All rights reserved.
//

import UIKit

enum SelectedApple {
    case black
    case red
    case yellow
    case green
}

class FeedbackViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var redAppleImageView: UIImageView! {
        didSet {
            redAppleImageView.image = redAppleImageView.image?.withRenderingMode(.alwaysTemplate)
            redAppleImageView.tintColor = UIColor.red
            redAppleImageView.isUserInteractionEnabled = true
            let drag = UIDragInteraction(delegate: self)
            drag.isEnabled = true
            redAppleImageView.addInteraction(drag)
        }
    }
    @IBOutlet weak var yellowAppleImageView: UIImageView! {
        didSet {
            yellowAppleImageView.image = redAppleImageView.image?.withRenderingMode(.alwaysTemplate)
            yellowAppleImageView.tintColor = UIColor.green
            yellowAppleImageView.isUserInteractionEnabled = true
            let drag = UIDragInteraction(delegate: self)
            drag.isEnabled = true
            yellowAppleImageView.addInteraction(drag)
        }
    }
    @IBOutlet weak var greenAppleImageView: UIImageView! {
        didSet {
            greenAppleImageView.image = greenAppleImageView.image?.withRenderingMode(.alwaysTemplate)
            greenAppleImageView.tintColor = UIColor.orange
            greenAppleImageView.isUserInteractionEnabled = true
            let drag = UIDragInteraction(delegate: self)
            drag.isEnabled = true
            greenAppleImageView.addInteraction(drag)
        }
    }
    
    var users: [String] = ["Alan", "Mateus", "Thalia", "Paloma"]
    
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
        
        let scale = CGFloat(0.7)
        shape.apply(CGAffineTransform(scaleX: scale, y: scale))
        
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! UserViewCell
        //cell.imageView.image = #imageLiteral(resourceName: "pomarApple")
        return cell
    }
}

extension FeedbackViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = collectionView.bounds
        let width = (bounds.width-4)/2
        print(width)
        let height = width
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
    
    
}

extension FeedbackViewController: UICollectionViewDropDelegate {
    
    func dropInteraction(_ interaction: UIDropInteraction, performDrop session: UIDropSession) {
        let selected = session.items.first?.localObject as! SelectedApple
        print(selected)
    }
    
    func collectionView(_ collectionView: UICollectionView, performDropWith coordinator: UICollectionViewDropCoordinator) {
        
        let selected = coordinator.items.first?.dragItem.localObject as! SelectedApple
        print(selected)
        
        let destinationIndexPath = coordinator.destinationIndexPath ?? IndexPath(item: 0, section: 0)
        
        let cell = collectionView.cellForItem(at: destinationIndexPath) as! UserViewCell
        cell.selectedApple = selected
        
        print(destinationIndexPath.item)
    }
    
    
}


extension FeedbackViewController: UIDragInteractionDelegate, UIDropInteractionDelegate {
    
    func dragInteraction(_ interaction: UIDragInteraction, itemsForBeginning session: UIDragSession) -> [UIDragItem] {
        
        var color: UIColor = UIColor.black
        
        var selected = SelectedApple.black
        
        if let imageView = interaction.view as? UIImageView {
            
            switch imageView {
                case redAppleImageView:
                    print("redApple")
                    selected = .red
                    color = UIColor.red
                case yellowAppleImageView:
                    selected = .yellow
                    print("yellowApple")
                    color = UIColor.yellow
                case greenAppleImageView:
                    print("greenApple")
                    selected = .green
                    color = UIColor.orange
                default:
                    break
            }
            
            guard let image = imageView.image else { return [] }
            
            let provider = NSItemProvider(object: image)
            
            let item = UIDragItem(itemProvider: provider)
            item.localObject = selected
            
            item.previewProvider = {
                let previewParameters = UIDragPreviewParameters()
                previewParameters.backgroundColor = color
                previewParameters.visiblePath = self.applePath
                let preview = UIDragPreview(view: UIView(), parameters: previewParameters)
                return preview
            }
            
            return [item]
            
        }
        
        return []
        
    }
    
//    func dragInteraction(_ interaction: UIDragInteraction, previewForLifting item: UIDragItem, session: UIDragSession) -> UITargetedDragPreview? {
//
//        guard let image = item.localObject as? UIImage else { return nil }
//
//        let previewImageView = UIImageView(image: image)
//        previewImageView.center = CGPoint(x: 100, y: 100)
//
//        let previewParameters = UIDragPreviewParameters()
//
//        let dragView = interaction.view!
//        var dragPoint = session.location(in: dragView)
//        let target = UIDragPreviewTarget(container: view, center: dragPoint)
//
//        let path = UIBezierPath(ovalIn: CGRect(origin: CGPoint(x: -25, y: -25), size: CGSize(width: 100, height: 100)))
//
//        previewParameters.visiblePath = applePath
//
//
//        return UITargetedDragPreview(view: previewImageView, parameters: previewParameters, target: target)
//    }
    
    func dropInteraction(_ interaction: UIDropInteraction, sessionDidUpdate session: UIDropSession) -> UIDropProposal {
        return UIDropProposal(operation: .copy)
    }
    
    func dropInteraction(_ interaction: UIDropInteraction, canHandle session: UIDropSession) -> Bool {
        return session.canLoadObjects(ofClass: UIImage.self)
    }

}
