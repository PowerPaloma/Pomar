//
//  UserTests.swift
//  PomarTests
//
//  Created by Mateus Rodrigues on 27/11/18.
//  Copyright © 2018 Paloma Bispo. All rights reserved.
//

import XCTest

import XCTest
import CloudKit
@testable import Pomar

class UserTests: XCTestCase {
    
    var user: User?
    var record: CKRecord?
    
    var testName: String?
    var testToken: String?
    var testProfileImage: UIImage?
    
    override func setUp() {
        
        testName = "Captain America"
        testToken = "token"
        testProfileImage = UIImage(named: "captain-america")
        
        user = User(name: testName!, token: testToken!, profileImage: nil)
        
        record = CKRecord(recordType: "User")
        record?.setValue(testName, forKey: "name")
        record?.setValue(testToken, forKey: "token")
        record?.setValue(0, forKey: "redApples")
        record?.setValue(0, forKey: "yellowApples")
        record?.setValue(0, forKey: "greenApples")
        record?.setValue(0, forKey: "money")
        
    }
    
    override func tearDown() {
        
    }
    
    func testInit() {
        XCTAssertEqual(user?.name, testName)
        XCTAssertEqual(user?.token, testToken)
        XCTAssertEqual(user?.redApples, 0)
        XCTAssertEqual(user?.yellowApples, 0)
        XCTAssertEqual(user?.greenApples, 0)
        XCTAssertEqual(user?.money, 0)
    }
    
    func testInitWithRecord() {
        user = User(record: record!)
        XCTAssertEqual(user?.name, testName)
        XCTAssertEqual(user?.token, testToken)
        XCTAssertEqual(user?.redApples, 0)
        XCTAssertEqual(user?.yellowApples, 0)
        XCTAssertEqual(user?.greenApples, 0)
        XCTAssertEqual(user?.money, 0)
    }
    
    func testIncrementApple() {
        user?.incrementeApple(type: .red)
        XCTAssertEqual(user?.redApples, 1)
        user?.incrementeApple(type: .yellow)
        XCTAssertEqual(user?.yellowApples, 1)
        user?.incrementeApple(type: .green)
        XCTAssertEqual(user?.greenApples, 1)
    }
    
}
