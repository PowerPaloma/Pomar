//
//  DaySchedule.swift
//  Pomar
//
//  Created by Mateus Rodrigues on 14/11/18.
//  Copyright © 2018 Paloma Bispo. All rights reserved.
//

import Foundation

struct DaySchedule: Codable {
    let day: String
    let hour: String
}

extension DaySchedule: Equatable {}

func ==(lhs: DaySchedule, rhs: DaySchedule) -> Bool {
    return lhs.day == rhs.day && lhs.hour == rhs.hour
}
