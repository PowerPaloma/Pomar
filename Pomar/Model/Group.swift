//
//  Group.swift
//  Pomar
//
//  Created by Mateus Rodrigues on 13/11/18.
//  Copyright © 2018 Paloma Bispo. All rights reserved.
//

import Foundation
import CloudKit

class GroupNew {
    
    var record: CKRecord
    
    var id: CKRecord.ID? {
        get {
            return record.recordID
        }
    }
    
    var name: String {
        set {
            record["name"] = newValue
        }
        get {
            return record["name"] as! String
        }
    }
    
    var description: String {
        set {
            record["description"] = newValue
        }
        get {
            return record["description"] as! String
        }
    }
    
    var tags: [String] {
        set {
            record["tags"] = newValue
        }
        get {
            return record["tags"] as! [String]
        }
    }
    
    init(name: String, description: String, tags: [String]) {
        record = CKRecord(recordType: "Group")
        self.name = name
        self.description = description
    }
    
    init(record: CKRecord) {
        self.record = record
    }
    
}

class Group {
    
    var id: CKRecord.ID?
    var name: String
    var description: String
    var tags: [String]
    var schedule: [DaySchedule]?
    var date: Date?
    var isWeekly: Bool
    
    var record: CKRecord?
    
    var createdAt: Date {
        return record!.creationDate!
    }
    
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
        self.schedule = nil
        self.date = nil
        self.isWeekly = false
        self.id = nil
        
    }
    
    
    init?(record: CKRecord){
        
        self.record = record
        
        self.id = record.recordID
        guard let name = record["name"] as? String , let description = record["description"]  as? String, let isWeekly = record["isWeekly"]  as? Bool, let tags = record["tags"] as? [String] else {return nil}
        self.name = name
        self.description = description
        self.isWeekly = isWeekly
        self.tags = tags
        
        self.date = record["date"] as? Date
        if let scheduleRecord = record["schedule"] as? String {
            let decoder = JSONDecoder()
            if let data = scheduleRecord.data(using: .utf8) {
                guard let schedule = try? decoder.decode([DaySchedule].self, from: data) else {return nil}
                self.schedule = schedule
            }else{
                return nil
            }
        }else{
            self.schedule = nil
        }
    }
    
}

extension CKRecord {
    convenience init(group: Group) {
        
        self.init(recordType: "Group")
        
        
        self["name"] = group.name
        self["description"] = group.description
        self["tags"] = group.tags
        self["isWeekly"] = group.isWeekly ? 1 : 0
        
        if let schedule = group.schedule {
            let encoder = JSONEncoder()
            let data = try? encoder.encode(schedule)
            let scheduleJson = String(data: data!, encoding: .utf8)
            self["schedule"] = scheduleJson
        }else{
            self["schedule"] = nil
        }
        self["date"] = group.date
        
    }
}


