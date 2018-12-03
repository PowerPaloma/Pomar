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
    case green
    case yellow
    case red
    
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
