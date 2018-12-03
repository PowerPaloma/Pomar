//
//  Apples.swift
//  Pomar
//
//  Created by Mateus Rodrigues on 30/11/18.
//  Copyright © 2018 Paloma Bispo. All rights reserved.
//

import Foundation
import CloudKit

class Apples {
    
    var record: CKRecord
    
    var red: Int {
        get {
            return record["red"] as! Int
        }
        set {
            record["red"] = newValue
        }
    }
    
    var yellow: Int {
        get {
            return record["yellow"] as! Int
        }
        set {
            record["yellow"] = newValue
        }
    }
    
    var green: Int {
        get {
            return record["green"] as! Int
        }
        set {
            record["green"] = newValue
        }
    }
    
    init(record: CKRecord) {
        self.record = record
    }
    
    func decrement(_ apple: AppleType) {
        switch apple {
            case .red:
                self.red -= 1
            case .yellow:
                self.yellow -= 1
            case .green:
                self.green -= 1
        }
    }
    
}
