//
//  CalendarTableViewCell.swift
//  Pomar
//
//  Created by Alan Victor Paulino de Oliveira on 03/12/18.
//  Copyright © 2018 Paloma Bispo. All rights reserved.
//

import UIKit

class CalendarTableViewCell: UITableViewCell {

    @IBOutlet weak var dayView: UIView!
    @IBOutlet weak var hourView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var option1Label: UILabel!
    @IBOutlet weak var hourCollectionView: UICollectionView!
    @IBOutlet weak var layoutCollection: UICollectionViewFlowLayout!
    
    var viewDatePicker = DatePickerView(frame: .zero)
    
    let hourCollectionViewDelegateAndDataSource = HourCollectionViewDelegateAndDataSource()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        hourView.layer.borderColor = UIColor.lightGray.cgColor
        hourView.layer.borderWidth = 2.5
        hourView.layer.cornerRadius = 10
        titleLabel.text = "Day and Time"
        option1Label.text = "Repeat"
        
        hourCollectionView.register(HourCollectionViewCell.self, forCellWithReuseIdentifier: "hourCell")
        
        hourCollectionView.dataSource = hourCollectionViewDelegateAndDataSource
        hourCollectionView.delegate = hourCollectionViewDelegateAndDataSource
        configLayoutCollection()
        
        let originDayView = dayView.frame.origin
        
        viewDatePicker.translatesAutoresizingMaskIntoConstraints = false

        dayView.addSubview(viewDatePicker)
        
        NSLayoutConstraint.activate([
            viewDatePicker.topAnchor.constraint(equalTo: dayView.topAnchor, constant: 0),
            viewDatePicker.leadingAnchor.constraint(equalTo: dayView.leadingAnchor, constant: 0),
            viewDatePicker.trailingAnchor.constraint(equalTo: dayView.trailingAnchor, constant: 0),
            dayView.bottomAnchor.constraint(equalTo: viewDatePicker.bottomAnchor, constant: 0)
            ])
        
        
        
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func btnLeftHour(_ sender: UIButton) {
    }
    
    @IBAction func btnRightHour(_ sender: Any) {
    }
    
    func configLayoutCollection(){
        let customWidth = hourCollectionView.bounds.width/5 - 8.5
        layoutCollection.minimumLineSpacing = 8
        layoutCollection.itemSize = CGSize(width: customWidth, height: 30)
    }
    
}

extension CalendarTableViewCell: AddNewGroupDelegate{
    func getDate() -> Date{
        return viewDatePicker.datePickerView.date
    }
}
