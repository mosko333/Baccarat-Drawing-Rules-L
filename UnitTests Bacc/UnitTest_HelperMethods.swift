//
//  UnitTest_HelperMethods.swift
//  UnitTests Bacc
//
//  Created by Adam Moskovich on 12/28/19.
//  Copyright © 2019 Adam Moskovich. All rights reserved.
//

import XCTest

class UnitTest_HelperMethods: XCTestCase {

    // MARK: - Uniqueness

    /// Tests that at least one unique value is created withing a set number of reps
    ///
    /// If the rep number is too low then this test might fail by pure chance
    static func test_uniqueness<T: Equatable>(numOfReps reps: Int, testingMethod: () -> (T)) {

        let currentValue = testingMethod()

        for _ in 0..<reps {
            if currentValue != testingMethod() {
                XCTAssert(true, "returned a different value")
                return
            }
        }
        // if the for loop ends and a unique value hasn't been achieved then the test fails
        XCTAssert(false, "returning the same value every time")
    }

}
