//
//  TopinAppTests.swift
//  TopinAppTests
//
//  Created by Cesar on 2/10/21.
//

import XCTest
@testable import TopinApp

class TopinAppTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testModelCreation() throws {
        // Test basic model creation
        
        let model = PintoGame<String>()
        
        XCTAssertNotNil(model.players)
        
        XCTAssertTrue(model.players.count == 2)
        
        XCTAssertTrue(model.getFaceDownCards(.p1).count == 3)
        
        XCTAssertTrue(model.getFaceUpCards(.p1).count == 3)
        
        XCTAssertTrue(model.getFaceDownCards(.p2).count == 3)
        
        XCTAssertTrue(model.getFaceUpCards(.p2).count == 3)
        
    }

}
