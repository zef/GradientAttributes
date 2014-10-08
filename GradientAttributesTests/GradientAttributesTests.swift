//
//  GradientAttributesTests.swift
//  GradientAttributesTests
//
//  Created by Zef Houssney on 10/7/14.
//  Copyright (c) 2014 Made by Kiwi. All rights reserved.
//

import UIKit
import XCTest

class GradientAttributesTests: XCTestCase {
    var attributes = GradientAttributes()

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.

    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testNoLocations() {
        attributes.stops = [
            GradientAttributes.Stop(.redColor()),
            GradientAttributes.Stop(.greenColor()),
            GradientAttributes.Stop(.blueColor()),
        ]

        XCTAssertNil(attributes.locations(), "Locations should return nil when omitted")
    }

    func testMissingLocations() {
        attributes.stops = [
            GradientAttributes.Stop(.redColor()),
            GradientAttributes.Stop(.greenColor(), location: 0.2),
            GradientAttributes.Stop(.blueColor()),
        ]

        XCTAssertNil(attributes.locations(), "For now, locations will return nil unless they are all provided.")
    }
    
    func testProvidedLocations() {
        attributes.stops = [
            GradientAttributes.Stop(.redColor(), location: 0),
            GradientAttributes.Stop(.greenColor(), location: 0.2),
            GradientAttributes.Stop(.blueColor(), location: 1),
        ]

        XCTAssertEqual(attributes.locations()!.count, 3, "Locations should be returned.")
    }
}
