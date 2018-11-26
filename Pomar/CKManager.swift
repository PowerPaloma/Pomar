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
    
    var container = CKContainer.default()
    
    var publicDatabase = CKContainer.default().publicCloudDatabase
    
    func iCloudUserID(completion: @escaping (CKRecord.ID?, Error?) -> Void) {
        let container = CKContainer.default()
        
        container.fetchUserRecordID() { recordID, error in
            if error != nil {
                completion(nil, error)
            } else {
                completion(recordID, nil)
            }
        }
    }
    
    public func createUser(user: User, completion: @escaping (CKRecord?, Error?) -> Void) {
        
        let record = CKRecord(user: user)
        
        publicDatabase.save(record) { (record, error) in
            if error != nil {
                completion(nil, error)
            } else {
                completion(record, nil)
            }
        }
        
    }
    
    func fetchAllUsers(completion: @escaping ([User]) -> Void) {
        
        var users = [User]()
        
        let query = CKQuery(recordType: "User", predicate: NSPredicate(value: true))
        
        publicDatabase.perform(query, inZoneWith: nil) { (records, error) in
            
            guard let records = records, error == nil else {
                print(error!.localizedDescription)
                return
            }
            
            records.forEach({ (record) in
                users.append(User(record: record))
            })
            
            completion(users)
        }
        
    }
    
    func fetchAllUsers(profileImage: Bool, completion: @escaping ([User]) -> Void) {
        
        var users = [User]()
        
        let query = CKQuery(recordType: "User", predicate: NSPredicate(value: true))
        
        let operation : CKQueryOperation = CKQueryOperation()
        operation.query = query
        operation.resultsLimit = 50
        operation.desiredKeys = ["recordName", "name", "token", "groups"]
        operation.qualityOfService = .userInteractive
        
        operation.recordFetchedBlock = { record in
            let user = User(record: record)
            users.append(user)
        }
        
        operation.queryCompletionBlock = { (cursor, error) in
            
            if error != nil {
                print(error)
            } else {
                completion(users)
            }
        }
        
        publicDatabase.add(operation)
        
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
    
    func fetchUser(token: String, completion: @escaping (User?, Error?) -> Void) {
        
        let predicate = NSPredicate(format: "token = %@", token)
        
        let query = CKQuery(recordType: "User", predicate: predicate)
        
        publicDatabase.perform(query, inZoneWith: nil) { (records, error) in
            
            guard let record = records?.first else {
                completion(nil, error)
                return
            }
            
            let user = User(record: record)
            completion(user, nil)
        }
        
    }
    
    func fetchUserWithoutImage(token: String, completion: @escaping (User?) -> Void) {
        
        var user: User?
        
        let predicate = NSPredicate(format: "token = %@", token)
        
        let query = CKQuery(recordType: "User", predicate: predicate)
        
        let operation = CKQueryOperation(query: query)
        operation.resultsLimit = 1
        operation.desiredKeys = ["recordName", "name", "token", "groups"]
        operation.qualityOfService = .default
        
        operation.recordFetchedBlock = { record in
            user = User(record: record)
        }
        
        operation.completionBlock = {
            completion(user)
        }
        
        publicDatabase.add(operation)
        
    }
    
    
    func fetchUserProfileImage(userID: CKRecord.ID, completion: @escaping (UIImage?) -> Void) {
        
        var profileImage: UIImage?
        
        let predicate = NSPredicate(format: "recordID = %@", userID)
        
        let query = CKQuery(recordType: "User", predicate: predicate)
        
        let operation = CKQueryOperation(query: query)
        operation.resultsLimit = 1
        operation.desiredKeys = ["profileImage"]
        operation.qualityOfService = .userInteractive
        
        operation.recordFetchedBlock = { record in
            if let asset = record["profileImage"] as? CKAsset {
                do {
                    let data = try Data(contentsOf: asset.fileURL)
                    profileImage = UIImage(data: data)
                } catch {
                    print(error.localizedDescription)
                }
            } else {
                profileImage = nil
            }
        }
        
        operation.completionBlock = {
            completion(profileImage)
        }
        
        publicDatabase.add(operation)
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
                return group
            })
            
            completion(groups, nil)
        }
        
    }
    
}
