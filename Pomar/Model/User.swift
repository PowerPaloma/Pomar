//
//  User.swift
//  Pomar
//
//  Created by Mateus Rodrigues on 13/11/18.
//  Copyright © 2018 Paloma Bispo. All rights reserved.
//

import Foundation
import CloudKit

class User {
    
    var name: String?
    var skills: [String]?
    
    init(record: CKRecord) {
        self.name = record["name"] as? String
        self.skills = record["skills"] as? [String]
    }
}
