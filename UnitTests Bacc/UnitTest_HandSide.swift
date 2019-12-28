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
        // Test empty hand
        var hand = HandSide(sideName: .player)
        XCTAssertEqual(hand.twoCardTotal, nil)

        // Test total under 10
        hand.drawNewHandWith(firstCard: mocCard(.five), secondCard: mocCard(.ace))
        XCTAssertEqual(hand.twoCardTotal, 6)

        // Test total above 10 with a face
        hand.drawNewHandWith(firstCard: mocCard(.nine), secondCard: mocCard(.eight))
        XCTAssertEqual(hand.twoCardTotal, 7)

        // Test total above 10 without a face
        hand.drawNewHandWith(firstCard: mocCard(.king), secondCard: mocCard(.two))
        XCTAssertEqual(hand.twoCardTotal, 2)

        // Test total two face cards
        hand.drawNewHandWith(firstCard: mocCard(.jack), secondCard: mocCard(.ten))
        XCTAssertEqual(hand.twoCardTotal, 0)
    }

    func test_isNatrual() {
        // Test empty hand
        var hand = HandSide(sideName: .bank)
        XCTAssertEqual(hand.isNatrual, nil)

        // Test natrual '8' under 10
        hand.drawNewHandWith(firstCard: mocCard(.five), secondCard: mocCard(.three))
        XCTAssertEqual(hand.isNatrual, true)

        // Test natrual '9' under 10
        hand.drawNewHandWith(firstCard: mocCard(.four), secondCard: mocCard(.five))
        XCTAssertEqual(hand.isNatrual, true)

        // Test NO natrual under 10
        hand.drawNewHandWith(firstCard: mocCard(.five), secondCard: mocCard(.ace))
        XCTAssertEqual(hand.isNatrual, false)

        // Test natrual '8' above 10
        hand.drawNewHandWith(firstCard: mocCard(.nine), secondCard: mocCard(.nine))
        XCTAssertEqual(hand.isNatrual, true)

        // Test natrual '9' above 10
        hand.drawNewHandWith(firstCard: mocCard(.jack), secondCard: mocCard(.nine))
        XCTAssertEqual(hand.isNatrual, true)

        // Test NO natrual above 10
        hand.drawNewHandWith(firstCard: mocCard(.jack), secondCard: mocCard(.three))
        XCTAssertEqual(hand.isNatrual, false)
    }

    func test_drawThirdCardWith() {
        // Test empty hand
        var hand = HandSide(sideName: .bank)
        XCTAssertEqual(hand.cardThree, nil)

        // Test hand without third card
        hand.drawNewHandWith(firstCard: mocCard(.ace), secondCard: mocCard(.ten))
        XCTAssertEqual(hand.cardThree, nil)

        // Test that third card is entered correctly
        let card = mocCard(.seven)
        hand.drawThirdCard(card)
        XCTAssertEqual(hand.cardThree, card)

        // Test the third card is reset with a new hand
        hand.drawNewHandWith(firstCard: mocCard(.ace), secondCard: mocCard(.ten))
        XCTAssertEqual(hand.cardThree, nil)
    }

    // MARK: - Helper Methods

    private func mocCard(_ name: CardValueName) -> Card {
        Card(suit: CardSuit.random(), valueName: name)
    }
}
