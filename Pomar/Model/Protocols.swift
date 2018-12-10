//
//  TextFieldProtocol.swift
//  Pomar
//
//  Created by Paloma Bispo on 20/11/18.
//  Copyright © 2018 Paloma Bispo. All rights reserved.
//

import Foundation

protocol TextFieldProtocol {
    func send(text: String)
}

protocol SelectedDaysProtocol {
    func selected(days: [Bool])
}

protocol MonthSelectedProtocol {
    func selected(month: String)
}

protocol DayProtocol {
    func selected(days: [Int])
}
