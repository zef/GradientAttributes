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

    }

    override func tearDown() {
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
            GradientAttributes.Stop(.blackColor()),
            GradientAttributes.Stop(.whiteColor()),
            GradientAttributes.Stop(.blackColor(), location: 0.2),
            GradientAttributes.Stop(.whiteColor(), location: 0.9),
            GradientAttributes.Stop(.blackColor()),
            GradientAttributes.Stop(.whiteColor()),
        ]

        let first = attributes.locations()!.first as Double
        XCTAssertEqual(first, 0, "Initial value of 0 should be added.")

        let last = attributes.locations()!.last as Double
        XCTAssertEqual(last, 1, "Final value of 1 should be added.")

        let firstGroup = attributes.locations()![1] as Double
        XCTAssertEqual(firstGroup, 0.1, "Mid-points should be interpolated if any location is provided")

        let secondGroup = attributes.locations()![4] as Double
        XCTAssertEqual(secondGroup, 0.95, "Mid-points should be interpolated if any location is provided")
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
