//
//  CKManager.swift
//  Pomar
//
//  Created by Mateus Rodrigues on 14/11/18.
//  Copyright © 2018 Paloma Bispo. All rights reserved.
//

import Foundation
import CloudKit

final class CKManager {
    
    static let shared = CKManager()
    
    private init() {
        
    }
    
    func createGroup(group: Group) {
        
        let record = CKRecord(group: group)
        
        CKContainer.default().publicCloudDatabase.save(record) { (record, error) in
            guard let record = record, error == nil else {
                print(error!.localizedDescription)
                return
            }
            print(record)
        }
        
    }
    
    func fetchGroups(completion: @escaping ([Group]) -> Void){
        
        var grupos = [Group]()
        
        let query = CKQuery(recordType: "Group", predicate: NSPredicate(value: true))
        
        CKContainer.default().publicCloudDatabase.perform(query, inZoneWith: nil) { (records, error) in
            records?.forEach({ (record) in
                if let group = Group(record: record)  {
                     grupos.append(group)
                }
               
            })
            completion(grupos)
        }
        
    }
    
    func fetchAllUsers(completion: @escaping ([User]) -> Void){
        
        var users = [User]()
        
        let query = CKQuery(recordType: "User", predicate: NSPredicate(value: true))
        
        CKContainer.default().publicCloudDatabase.perform(query, inZoneWith: nil) { (records, error) in
            records?.forEach({ (record) in
                users.append(User(record: record))
            })
            completion(users)
        }
        
    }
    
    func fetchUsers( groupID: CKRecord.ID, completion: @escaping ([User]) -> Void){
        
        var users = [User]()
        
        let ref = CKRecord.Reference(recordID: groupID, action: .none)
        let predicate = NSPredicate(format: "%K CONTAINS %@", "groups", ref)
        let query = CKQuery(recordType: "User", predicate: predicate)
        
        CKContainer.default().publicCloudDatabase.perform(query, inZoneWith: nil, completionHandler: { (records, error) in
            
            guard let records = records, error == nil else {
                print(error!.localizedDescription)
                return
            }
            
            records.forEach({ (record) in
                users.append(User(record: record))
            })
            completion(users)
        })
        
    }
    
}
