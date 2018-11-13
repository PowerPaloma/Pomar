//
//  StudyGroupsViewController.swift
//  Pomar
//
//  Created by Paloma Bispo on 13/11/18.
//  Copyright © 2018 Paloma Bispo. All rights reserved.
//

import UIKit
import CloudKit

class StudyGroupsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchGrupos { (groups) in
            print(groups)
        }

        
    }
    
    
    func fetchGrupos(completion: @escaping ([Group]) -> Void){
        
        var grupos = [Group]()
        
        let query = CKQuery(recordType: "Group", predicate: NSPredicate(value: true))
        
        CKContainer.default().publicCloudDatabase.perform(query, inZoneWith: nil) { (records, error) in
            //print(records)
            records?.forEach({ (record) in
                let members = record["members"] as! [CKRecord.Reference]
                
                let predicate = NSPredicate(format: "$k IN %@", record["recordName"] as! String, members)
                
                let query = CKQuery(recordType: "User", predicate: predicate)
                
                CKContainer.default().publicCloudDatabase.perform(query, inZoneWith: nil, completionHandler: { (records, error) in
                    print(records)
                })
                
//                members.forEach({ (reference) in
//                    CKContainer.default().publicCloudDatabase.fetch(withRecordID: reference.recordID, completionHandler: { (record, error) in
//                        print(record)
//                    })
//                })
               
                grupos.append(Group(record: record))
            })
            completion(grupos)
        }
        
        
    }
    

}
