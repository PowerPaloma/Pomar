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
        collectionView.delegate = self
        collectionView.dataSource = self
        
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
                
                let predicate = NSPredicate(format: "recordID IN %@", members )
                
                let query = CKQuery(recordType: "User", predicate: predicate)
                
                CKContainer.default().publicCloudDatabase.perform(query, inZoneWith: nil, completionHandler: { (records, error) in
                    guard let recordas = records?.first else {return}
                    print(recordas["name"])
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


extension StudyGroupsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        <#code#>
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        <#code#>
    }
    
    
    
}
