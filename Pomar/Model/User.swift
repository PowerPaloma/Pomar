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
    
    var id: CKRecord.ID?
    var name: String
    var token: String
    var profileImage: UIImage?
    var groups: [CKRecord.Reference]?
    
    init(name: String, image: UIImage, token: String) {
        self.name = name
        self.token = token
        self.profileImage = image
    }
    
    init(record: CKRecord) {
        self.id = record.recordID
        self.name = record["name"] as! String
        self.token = record["token"] as! String
        self.groups = (record["groups"] as? [CKRecord.Reference])
        if let asset = record["profileImage"] as? CKAsset {
            do {
                let data = try Data(contentsOf: asset.fileURL)
                self.profileImage = UIImage(data: data)
            } catch {
                print(error)
            }
        }
    }
    
}

extension CKRecord {
    convenience init(user: User) {
        self.init(recordType: "User")
        self["name"] = user.name
        
        let data = user.profileImage?.jpegData(compressionQuality: 0.1)
        let url = NSURL.fileURL(withPath: NSTemporaryDirectory()).appendingPathComponent(NSUUID().uuidString+".png")
        do {
            try data!.write(to: url)
        } catch let e as NSError {
            self["profileImage"] = CKAsset(fileURL: url)
            print("Error! \(e)")
        }
        self["token"] = user.token
    }
}
