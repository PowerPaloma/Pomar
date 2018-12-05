//
//  DescriptionTableViewCell.swift
//  Pomar
//
//  Created by Alan Victor Paulino de Oliveira on 29/11/18.
//  Copyright © 2018 Paloma Bispo. All rights reserved.
//

import UIKit

class DescriptionTableViewCell: UITableViewCell {

    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var descriptionTextField: UITextField!
    var title:String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func loadCell(typeCell:TypeCellDescription){
        
        switch typeCell {
        case .name:
            self.title = "Name"
            
        case .smallDescription:
            self.title = "Small Description"
        }
        descriptionLabel.text = title
    }
}

extension DescriptionTableViewCell: AddNewGroupDelegate{
    func getNameText() -> String{
        return descriptionTextField.text!
    }
    func getSmallDescriptionText() -> String {
        return descriptionTextField.text!
    }
}

enum TypeCellDescription{
    case name
    case smallDescription
}
