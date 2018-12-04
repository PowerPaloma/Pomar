//
//  ApplesTests.swift
//  PomarTests
//
//  Created by Mateus Rodrigues on 01/12/18.
//  Copyright © 2018 Paloma Bispo. All rights reserved.
//

import XCTest
import CloudKit
@testable import Pomar

class ApplesTests: XCTestCase {
    
    var apples: Apples?
    var record: CKRecord?

    override func setUp() {
        record = CKRecord(recordType: "Apples")
        record?.setValue(1, forKey: "red")
        record?.setValue(1, forKey: "yellow")
        record?.setValue(1, forKey: "green")
        
    }

    override func tearDown() {
        
    }
    
    func testInitWithRecord() {
        apples = Apples(record: record!)
        XCTAssertEqual(apples?.red, 1)
        XCTAssertEqual(apples?.yellow, 1)
        XCTAssertEqual(apples?.green, 1)
    }
    
    func testDecrement() {
        apples = Apples(record: record!)
        apples?.decrement(.red)
        XCTAssertEqual(apples?.red, 0)
        apples?.decrement(.yellow)
        XCTAssertEqual(apples?.yellow, 0)
        apples?.decrement(.green)
        XCTAssertEqual(apples?.green, 0)
    }

}
