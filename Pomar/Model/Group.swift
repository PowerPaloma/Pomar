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
    var date: Date?
    var isWeekly: Bool?
    
    init(name: String, description: String, tags: [String], schedule: [DaySchedule], date: Date, isWeekly: Bool) {
        self.name = name
        self.description = description
        self.tags = tags
        self.schedule = schedule
        self.date = date
        self.isWeekly = isWeekly
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
        self.date = record["date"] as? Date
        self.isWeekly = record["isWeekly"] as? Bool
        
        
        guard let schedule = record["schedule"] as? String else {
            return
        }
        
        let decoder = JSONDecoder()
        
        let data = schedule.data(using: .utf8)
        self.schedule = try? decoder.decode([DaySchedule].self, from: data!)
        
        
    }
    
}

extension CKRecord {
    convenience init(group: Group) {
        self.init(recordType: "Group")
        self["name"] = group.name!
        self["description"] = group.description!
        self["tags"] = group.tags!
        self["date"] = group.date!
        self["isWeekly"] = group.isWeekly! ? 1 : 0
        
        let encoder = JSONEncoder()
        let data = try? encoder.encode(group.schedule)
        let schedule = String(data: data!, encoding: .utf8)
        
        self["schedule"] = schedule
    }
}


