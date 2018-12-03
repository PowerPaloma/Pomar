//
//  AppleType.swift
//  Pomar
//
//  Created by Mateus Rodrigues on 27/11/18.
//  Copyright © 2018 Paloma Bispo. All rights reserved.
//

import Foundation
import UIKit

enum AppleType {
    case red
    case yellow
    case green
    
    init?(index: Int) {
        switch index {
            case 1: self = .red
            case 2: self = .yellow
            case 3: self = .green
            default: return nil
        }
    }

    
    func color() -> UIColor {
        switch self {
            case .red:
                return UIColor.red
            case .yellow:
                return UIColor.orange
            case .green:
                return UIColor.green
        }
    }
    
}
