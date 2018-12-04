//
//  AppleTypeTests.swift
//  PomarTests
//
//  Created by Mateus Rodrigues on 02/12/18.
//  Copyright © 2018 Paloma Bispo. All rights reserved.
//

import XCTest
@testable import Pomar

class AppleTypeTests: XCTestCase {

    var type: AppleType?
    
    override func setUp() {
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testColor() {
        type = AppleType.red
        XCTAssertEqual(type?.color(), UIColor.red)
        type = AppleType.yellow
        XCTAssertEqual(type?.color(), UIColor.orange)
        type = AppleType.green
        XCTAssertEqual(type?.color(), UIColor.green)
    }

}
