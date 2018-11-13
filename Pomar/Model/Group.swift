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
    var members = [CKRecord.Reference]()
    
    
    init(record: CKRecord) {
        self.name = record["name"] as? String
        self.tags = record["tags"] as? [String]
        self.members = record["members"] as! [CKRecord.Reference]
        
    }
    
    func fetchMembers(completion: @escaping ([User]?) -> Void) {
        
        var users = [User]()
        
        let predicate = NSPredicate(format: "recordID IN %@", self.members)
        
        let query = CKQuery(recordType: "User", predicate: predicate)
        
        CKContainer.default().publicCloudDatabase.perform(query, inZoneWith: nil, completionHandler: { (records, error) in
            records?.forEach({ (record) in
                users.append(User(record: record))
            })
            completion(users)
        })
    }
    
    
    
}

