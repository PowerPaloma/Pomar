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
    
    var id: CKRecord.ID?
    var name: String?
    var description: String?
    var tags: [String]?
    var schedule: [DaySchedule]?
    
    init(name: String, description: String, tags: [String], schedule: [DaySchedule]) {
        self.name = name
        self.description = description
        self.tags = tags
        self.schedule = schedule
    }
    init() {
        self.name = ""
        self.description = ""
        self.tags = []
        self.schedule = []
    }
    
    
    init(record: CKRecord) {
        self.id = record.recordID
        self.name = record["name"] as? String
        self.description = record["description"] as? String
        self.tags = record["tags"] as? [String]
        
        
        guard let schedule = record["schedule"] as? String else {
            return
        }
        
        let decoder = JSONDecoder()
        
        let data = schedule.data(using: .utf8)
        self.schedule = try? decoder.decode([DaySchedule].self, from: data!)
        
        
    }
    
}

