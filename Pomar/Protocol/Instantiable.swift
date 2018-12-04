//
//  Instantiable.swift
//  Pomar
//
//  Created by Paloma Bispo on 03/12/18.
//  Copyright © 2018 Paloma Bispo. All rights reserved.
//

import Foundation
import UIKit

protocol Instantiable {
    static func instance() -> Self?
}

extension Instantiable where Self:UIView {
    
    static func instance() -> Self? {
        let className = String(describing: Self.self)
        return UINib(nibName: className, bundle: Bundle.main).instantiate(withOwner: self, options: nil).first as? Self
    }
}
