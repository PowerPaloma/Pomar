//
//  User.swift
//  Pomar
//
//  Created by Mateus Rodrigues on 13/11/18.
//  Copyright © 2018 Paloma Bispo. All rights reserved.
//

import Foundation
import CloudKit
import UIKit

class User {
    
    var record: CKRecord
    
    var id: CKRecord.ID? {
        get {
            return record.recordID
        }
    }
    
    var name: String {
        set {
            record["name"] = newValue
        }
        get {
            return record["name"] as! String
        }
    }
    
    var skills: [String] {
        set {
            record["skills"] = newValue
        }
        get {
            return record["skills"] as! [String]
        }
    }
    
    var token: String {
        set {
            record["token"] = newValue
        }
        get {
            return record["token"] as! String
        }
    }
    
    var profileImage: UIImage?
    
    var imageRef: CKRecord.Reference? {
        set {
            record["imageRef"] = newValue
        }
        get {
            return record["imageRef"] as? CKRecord.Reference
        }
    }
    
    var groups: [CKRecord.Reference]? {
        set {
            record["groups"] = newValue
        }
        get {
            return record["groups"] as? [CKRecord.Reference]
        }
    }
    
    var redApples: Int {
        set {
            record["redApples"] = newValue
        }
        get {
            return record["redApples"] as! Int
        }
    }
    
    var yellowApples: Int {
        set {
            record["yellowApples"] = newValue
        }
        get {
            return record["yellowApples"] as! Int
        }
    }
    
    var greenApples: Int {
        set {
            record["greenApples"] = newValue
        }
        get {
            return record["greenApples"] as! Int
        }
    }
    
    var money: Int {
        set {
            record["money"] = newValue
        }
        get {
            return record["money"] as! Int
        }
    }
    
    init(name: String, skills: [String], token: String, imageRef: CKRecord.Reference) {
        record = CKRecord(recordType: "User")
        self.name = name
        self.skills = skills
        self.token = token
        self.imageRef = imageRef
        self.redApples = 0
        self.yellowApples = 0
        self.greenApples = 0
        self.money = 0
    }
    
    init(record: CKRecord) {
        self.record = record
    }
    
    func incrementeApple(type: AppleType) {
        switch type {
        case .red:
            self.redApples += 1
        case .yellow:
            self.yellowApples += 1
        default:
            self.greenApples += 1
        }
    }
    
}
