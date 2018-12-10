//
//  CKManager.swift
//  Pomar
//
//  Created by Mateus Rodrigues on 14/11/18.
//  Copyright © 2018 Paloma Bispo. All rights reserved.
//

import Foundation
import CloudKit
import UIKit

final class CKManager {
    
    static let shared = CKManager()
    
    private init() {}
    
    var container = CKContainer(identifier: "iCloud.Paloma-Bispo.Pomar")
    
    var publicDatabase = CKContainer(identifier: "iCloud.Paloma-Bispo.Pomar").publicCloudDatabase
    
    //MARK: - User functions
    
    func iCloudUserID(completion: @escaping (String?, Error?) -> Void) {
        
        container.fetchUserRecordID() { recordID, error in
            
            guard let recordID = recordID, error == nil else {
                completion(nil, error)
                return
            }
            
            completion(recordID.recordName, nil)
        }
    }
    
    public func createUser(user: User, completion: @escaping (CKRecord?, Error?) -> Void) {
        
        let record = user.record
        
        publicDatabase.save(record) { (record, error) in
            completion(record, error)
        }
        
    }
    
    func fetchAllUsers(completion: @escaping ([User]?, Error?) -> Void) {
        
        let query = CKQuery(recordType: "User", predicate: NSPredicate(value: true))
        
        publicDatabase.perform(query, inZoneWith: nil) { (records, error) in
            
            guard let records = records, error == nil else {
                completion(nil, error)
                return
            }
            
            let users = records.map({ (record) -> User in
                let user = User(record: record)
                return user
            })
            
            completion(users, nil)
        }
        
    }
    
    func fetchUsers( groupID: CKRecord.ID, completion: @escaping ([User]?, Error?) -> Void) {
        
        let ref = CKRecord.Reference(recordID: groupID, action: .none)
        let predicate = NSPredicate(format: "%K CONTAINS %@", "groups", ref)
        let query = CKQuery(recordType: "User", predicate: predicate)
        
        publicDatabase.perform(query, inZoneWith: nil, completionHandler: { (records, error) in
            
            guard let records = records, error == nil else {
                completion(nil, error)
                return
            }
            
            let users = records.map({ (record) -> User in
                let user = User(record: record)
                return user
            })
            
            completion(users, nil)
        })
        
    }
    
    func fetchUser(token: String, completion: @escaping (CKRecord?, User?, Error?) -> Void) {
        
        let predicate = NSPredicate(format: "token = %@", token)
        
        let query = CKQuery(recordType: "User", predicate: predicate)
        
        publicDatabase.perform(query, inZoneWith: nil) { (records, error) in
            
            guard let record = records?.first else {
                completion(nil, nil, error)
                return
            }
            
            let user = User(record: record)
            completion(record, user, nil)
        }
        
    }
    
    func fetchUser(id: CKRecord.ID, completion: @escaping (CKRecord?, User?, Error?) -> Void) {
        
        let predicate = NSPredicate(format: "recordID = %@", id)
        
        let query = CKQuery(recordType: "User", predicate: predicate)
        
        publicDatabase.perform(query, inZoneWith: nil) { (records, error) in
            
            guard let record = records?.first else {
                completion(nil, nil, error)
                return
            }
            
            let user = User(record: record)
            completion(record, user, nil)
        }
        
    }
    
    func join(userID: CKRecord.ID, groupID: CKRecord.ID, completion: @escaping (CKRecord?, Error?) -> Void) {
        
        publicDatabase.fetch(withRecordID: userID) { (record, error) in
            
            guard let record = record, error == nil else {
                completion(nil, error)
                return
            }
            
            let groupReference = CKRecord.Reference(recordID: groupID, action: .none)
            
            var groups: [CKRecord.Reference]
            
            if record["groups"] != nil {
                groups = record["groups"] as! [CKRecord.Reference]
            } else {
                groups = []
            }
            
            if !groups.contains(groupReference) {
                groups.append(groupReference)
            }
            
            record["groups"] = groups
            
            CKContainer.default().publicCloudDatabase.save(record) { (record, error) in
                print("joined!")
                completion(record, error)
            }
            
        }
        
    }
    
    //MARK: - Image Functions
    
    func saveimage(_ image: UIImage,  completion: @escaping (CKRecord?, Error?) -> Void) {
        
        let record = CKRecord(recordType: "Image")
        
        if let data = image.jpegData(compressionQuality: 0.1) {
            let url = NSURL.fileURL(withPath: NSTemporaryDirectory()).appendingPathComponent(NSUUID().uuidString+".png")
            do {
                try data.write(to: url)
                record["asset"] = CKAsset(fileURL: url)
                publicDatabase.save(record) { (record, error) in
                    completion(record, error)
                }
                
            } catch {
                completion(nil, error)
            }
        }
        
    }
    
    func fetchImage(reference: CKRecord.Reference, completion: @escaping (UIImage?, Error?) -> Void) {
        publicDatabase.fetch(withRecordID: reference.recordID) { (record, error) in
            
            var image: UIImage? = nil
            
            guard let record = record, error == nil else {
                completion(image, error)
                return
            }
            
            if let asset = record["asset"] as? CKAsset {
                do {
                    let data = try Data(contentsOf: asset.fileURL)
                    image = UIImage(data: data)
                } catch {
                    completion(image, error)
                }
            }
            
            completion(image, nil)
        }
    }
    
    //MARK: - Group functions
    
    func createGroup(group: Group, completion: @escaping (CKRecord?, Error?) -> Void) {
        
        let record = CKRecord(group: group)
        
        CKContainer.default().publicCloudDatabase.save(record) { (record, error) in
            if error != nil {
                completion(nil, error)
            } else {
                completion(record, nil)
            }
        }
        
    }
    
    func fetchGroups(completion: @escaping ([Group]?, Error?) -> Void) {
        
        let query = CKQuery(recordType: "Group", predicate: NSPredicate(value: true))
        
        publicDatabase.perform(query, inZoneWith: nil) { (records, error) in
            
            guard let records = records, error == nil else {
                completion(nil, error)
                return
            }
            
            let groups = records.map({ (record) -> Group in
                let group = Group(record: record)
                return group!
            })
            
            completion(groups, nil)
        }
        
    }
    
    func fetchGroups(userID: CKRecord.ID, completion: @escaping ([Group]?, Error?) -> Void) {
        
        publicDatabase.fetch(withRecordID: userID) { (record, error) in
            guard let record = record else {
                completion(nil, error)
                return
            }
            
            let user = User(record: record)
            
            let groups = user.groups
            
            let predicate = NSPredicate(format: "%K IN %@", "recordID", groups!)
            let query = CKQuery(recordType: "Group", predicate: predicate)
            
            self.publicDatabase.perform(query, inZoneWith: nil, completionHandler: { (records, error) in
                guard let records = records else {
                    completion(nil, error)
                    return
                }
                let groups = records.map({ (record) -> Group in
                    return Group(record: record)!
                })
                
                completion(groups, nil)
            })
            
        }
        
    }
    
    //MARK: - Apples Functions
    
    func createApples(userID: CKRecord.ID, groupID: CKRecord.ID, completion: @escaping (CKRecord?, Error?) -> Void) {
        
        let userRef = CKRecord.Reference(recordID: userID, action: .none)
        let groupRef = CKRecord.Reference(recordID: groupID, action: .none)
        
        let record = CKRecord(recordType: "Apples")
        
        fetchUsers(groupID: groupID) { (users, error) in
            
            guard let count = users?.count else {
                completion(nil, error)
                return
            }
            
            record["user"] = userRef
            record["group"] = groupRef
            record["red"] = count-1
            record["yellow"] = 1
            record["green"] = 1
            
            self.publicDatabase.save(record, completionHandler: { (record, error) in
                completion(record, error)
            })
            
        }
        
    }
    
    func updateApples(groupID: CKRecord.ID, completion: @escaping ([CKRecord]?, Error?) -> Void) {
        
        let ref = CKRecord.Reference(recordID: groupID, action: .none)
        let predicate = NSPredicate(format: "group = %@", ref)
        let query = CKQuery(recordType: "Apples", predicate: predicate)
        
        fetchUsers(groupID: groupID) { (users, error) in
            guard let count = users?.count, error == nil else {
                completion(nil, error)
                return
            }
            
            self.publicDatabase.perform(query, inZoneWith: nil) { (records, error) in
                
                guard let records = records else {
                    completion(nil, error)
                    return
                }
                
                records.forEach({ (record) in
                    record["red"] = count-1
                })
                
                let operation = CKModifyRecordsOperation(recordsToSave: records, recordIDsToDelete: nil)
                
                operation.completionBlock = {
                    completion(records, nil)
                }
                
                self.publicDatabase.add(operation)
                
            }
            
        }
        
    }
    
    func available(userID: CKRecord.ID, groupID: CKRecord.ID, completion: @escaping (Apples?, Error?) -> Void) {
        
        let userRef = CKRecord.Reference(recordID: userID, action: .none)
        let groupRef = CKRecord.Reference(recordID: groupID, action: .none)
        
        let predicate = NSPredicate(format: "group = %@ AND user = %@", groupRef, userRef)
        let query = CKQuery(recordType: "Apples", predicate: predicate)
        
        publicDatabase.perform(query, inZoneWith: nil) { (records, error) in
            guard let record = records?.first, error == nil else {
                completion(nil, error)
                return
            }
            let apples = Apples(record: record)
            completion(apples, nil)
            
        }
        
    }
    
    func incrementUserApple(userID: CKRecord.ID, type: AppleType, completion: @escaping (CKRecord?, Error?) -> Void) {
        
        fetchUser(id: userID) { (record, user, error) in
            
            guard let record = record else {
                completion(nil, error)
                return
            }
            
            let user = User(record: record)
            user.incrementeApple(type: type)
            
            self.publicDatabase.save(user.record, completionHandler: { (record, error) in
                completion(record, error)
            })
        }
        
    }
    
    func decrementApples(applesID: CKRecord.ID, type: AppleType, completion: @escaping (CKRecord?, Error?) -> Void){
        publicDatabase.fetch(withRecordID: applesID) { (record, error) in
            guard let record = record else {
                completion(nil, error)
                return
            }
            let apples = Apples(record: record)
            apples.decrement(type)
            self.publicDatabase.save(apples.record, completionHandler: { (record, error) in
                completion(record, error)
            })
            
        }
    }
    
    func update(records: [CKRecord], completion: @escaping ([CKRecord]?, Error?) -> Void) {
        let operation = CKModifyRecordsOperation(recordsToSave: records, recordIDsToDelete: nil)
        
        operation.completionBlock = {
            completion(records, nil)
        }
        
        self.publicDatabase.add(operation)
    }
    
    
    
}
