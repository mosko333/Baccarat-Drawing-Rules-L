//
//  UnitTest_HandSide.swift
//  UnitTests Bacc
//
//  Created by Adam Moskovich on 12/27/19.
//  Copyright © 2019 Adam Moskovich. All rights reserved.
//

import XCTest
@testable import Baccarat_Drawing_Rules_L

class UnitTest_HandSide: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_twoCardTotal() {
        // Test total under 10
        var hand = HandSide(sideName: .player, cardOne: mocCard(.five), cardTwo: mocCard(.ace))
        XCTAssertEqual(hand.twoCardTotal, 6)

        // Test total above 10 with a face
        hand = HandSide(sideName: .bank, cardOne: mocCard(.nine), cardTwo: mocCard(.eight))
        XCTAssertEqual(hand.twoCardTotal, 7)

        // Test total above 10 without a face
        hand = HandSide(sideName: .bank, cardOne: mocCard(.king), cardTwo: mocCard(.two))
        XCTAssertEqual(hand.twoCardTotal, 2)

        // Test total two face cards
        hand = HandSide(sideName: .player, cardOne: mocCard(.jack), cardTwo: mocCard(.ten))
        XCTAssertEqual(hand.twoCardTotal, 0)
    }

    func test_isNatrual() {
        // Test natrual '8' under 10
        var hand = HandSide(sideName: .player, cardOne: mocCard(.five), cardTwo: mocCard(.three))
        XCTAssertEqual(hand.isNatrual, true)

        // Test natrual '9' under 10
        hand = HandSide(sideName: .player, cardOne: mocCard(.four), cardTwo: mocCard(.five))
        XCTAssertEqual(hand.isNatrual, true)

        // Test NO natrual under 10
        hand = HandSide(sideName: .player, cardOne: mocCard(.five), cardTwo: mocCard(.ace))
        XCTAssertEqual(hand.isNatrual, false)

        // Test natrual '8' above 10
        hand = HandSide(sideName: .bank, cardOne: mocCard(.nine), cardTwo: mocCard(.nine))
        XCTAssertEqual(hand.isNatrual, true)

        // Test natrual '9' above 10
        hand = HandSide(sideName: .bank, cardOne: mocCard(.jack), cardTwo: mocCard(.nine))
        XCTAssertEqual(hand.isNatrual, true)

        // Test NO natrual above 10
        hand = HandSide(sideName: .player, cardOne: mocCard(.jack), cardTwo: mocCard(.three))
        XCTAssertEqual(hand.isNatrual, false)
    }

    // MARK: - helper methods

    private func mocCard(_ name: CardValueName) -> Card {
        Card(suit: CardSuit.random(), valueName: name)
    }

}
