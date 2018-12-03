//
//  GroupTests.swift
//  PomarTests
//
//  Created by Mateus Rodrigues on 19/11/18.
//  Copyright © 2018 Paloma Bispo. All rights reserved.
//

import XCTest
import CloudKit
@testable import Pomar

class GroupTests: XCTestCase {
    
    var testName: String?
    var testDescription: String?
    var testTags: [String]?
    var testDate: Date?
    var testSchedule: [DaySchedule]?
    var testScheduleString: String?
    var testIsWeekly: Bool?
    
    override func setUp() {
        testName = "name"
        testDescription = "description"
        testTags = ["tag1", "tag2"]
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-DD HH:mm:ss"
        testDate = dateFormatter.date(from: "2018-11-19 15:00:00")
        testSchedule = [DaySchedule(day: "monday", hour: "14:00"), DaySchedule(day: "friday", hour: "14:00")]
        testScheduleString = "[{\"day\":\"monday\",\"hour\":\"14:00\"},{\"day\":\"friday\",\"hour\":\"14:00\"}]"
        testIsWeekly = true
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testInitRecordWithGroup() {
        let group = Group(name: testName!, description: testDescription!, tags: testTags!, schedule: testSchedule!, date: testDate!, isWeekly: testIsWeekly!)
        let record = CKRecord(group: group)
        XCTAssertEqual(record["name"] as? String, testName)
        XCTAssertEqual(record["description"] as? String, testDescription)
        XCTAssertEqual(record["tags"] as? [String], testTags)
        XCTAssertEqual(record["date"] as? Date, testDate)
        XCTAssertEqual(record["schedule"] as? String, testScheduleString)
        XCTAssertEqual(record["isWeekly"] as? Bool, testIsWeekly)
        
    }
    func testInitGroupWithRecord() {
        let record = CKRecord(recordType: "Group")
        record["name"] = testName
        record["description"] = testDescription
        record["tags"] = testTags
        record["date"] = testDate
        record["schedule"] = testScheduleString
        record["isWeekly"] = testIsWeekly! ? 1 : 0
        let group = Group(record: record)
        XCTAssertEqual(group?.name, testName)
        XCTAssertEqual(group?.description, testDescription)
        XCTAssertEqual(group?.tags, testTags)
        XCTAssertEqual(group?.date!, testDate)
        XCTAssertEqual(group?.schedule!, testSchedule)
        XCTAssertEqual(group?.isWeekly, testIsWeekly)
        
    }
    
}
