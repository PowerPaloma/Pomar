//
//  Group.swift
//  Pomar
//
//  Created by Mateus Rodrigues on 13/11/18.
//  Copyright © 2018 Paloma Bispo. All rights reserved.
//

import Foundation
import CloudKit

class Group {
    
    var name: String?
    var tags: [String]?
    
    
    init(record: CKRecord) {
        self.name = record["name"] as? String
        self.tags = record["tags"] as? [String]
    }
    
}

