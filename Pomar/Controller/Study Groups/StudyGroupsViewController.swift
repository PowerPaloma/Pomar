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
    
    @IBOutlet weak var collectionView: UICollectionView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchGrupos { (groups) in
            print(groups)
            groups.forEach({ (group) in
                group.fetchMembers(completion: { (members) in
                    print(members!)
                })
            })
        }

        
    }
    
    
    func fetchGrupos(completion: @escaping ([Group]) -> Void){
        
        var grupos = [Group]()
        
        let query = CKQuery(recordType: "Group", predicate: NSPredicate(value: true))
        
        CKContainer.default().publicCloudDatabase.perform(query, inZoneWith: nil) { (records, error) in
            //print(records)
            records?.forEach({ (record) in
                
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
