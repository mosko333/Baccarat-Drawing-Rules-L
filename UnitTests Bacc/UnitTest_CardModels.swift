//
//  UnitTest_CardModels.swift
//  UnitTests Bacc
//
//  Created by Adam Moskovich on 12/27/19.
//  Copyright © 2019 Adam Moskovich. All rights reserved.
//

import XCTest
@testable import Baccarat_Drawing_Rules_L

class UnitTest_CardModels: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    // MARK: - test Card

    // Check that all cards have imageNames
    // Different than the test bellow because it checks the static method
    // From the CardImageName Model
    func test_CardImageNameFromImageName() {
        for suit in CardSuit.allCases {
            for valueName in CardValueName.allCases {
                let card = Card(suit: suit, valueName: valueName)
                let imageName = CardImageName.of(card)
                XCTAssert(!imageName.isEmpty, "The is no imageName for this card")
            }
        }
    }

    // Check that all cards have imageNames
    // Different than the test above because it checks the method on the card itself
    func test_CardImageNameFromCard() {
        for suit in CardSuit.allCases {
            for valueName in CardValueName.allCases {
                let imageName = Card(suit: suit, valueName: valueName).imageName()
                XCTAssert(!imageName.isEmpty, "The is no imageName for this card")
            }
        }
    }

    // MARK: - test CardSuit

    func test_CardSuitRandom() {
        let currentSuit = CardSuit.random()

        // testing randomness is tricky, so instead we loop over the
        // method 100 times to make sure it's not returning the same
        // value every time
        for _ in 0..<100 {
            if currentSuit != CardSuit.random() {
                XCTAssert(true, "CardSuit.random returned a different value")
                return
            }
        }
        // if the for loop ends and a unique value has never been achieved then the test fails
        XCTAssert(false, "CardSuit is returning the same value every time")
    }

    // MARK: - Test CardValueName

    func test_CardNameRandom() {
        let currentName = CardValueName.random()

        // testing randomness is tricky, so instead we loop over the
        // method 100 times to make sure it's not returning the same
        // value every time
        for _ in 0..<100 {
            if currentName != CardValueName.random() {
                XCTAssert(true, "CardValueName.random returned a different value")
                return
            }
        }
        // if the for loop ends and a unique value has never been achieved then the test fails
        XCTAssert(false, "CardValueName is returning the same value every time")
    }

    // test that all the game values are returned as expected
    func test_CardNameGameValueReturned() {
        XCTAssertEqual(CardValueName.ace.gameValue, 1)
        XCTAssertEqual(CardValueName.two.gameValue, 2)
        XCTAssertEqual(CardValueName.three.gameValue, 3)
        XCTAssertEqual(CardValueName.four.gameValue, 4)
        XCTAssertEqual(CardValueName.five.gameValue, 5)
        XCTAssertEqual(CardValueName.six.gameValue, 6)
        XCTAssertEqual(CardValueName.seven.gameValue, 7)
        XCTAssertEqual(CardValueName.eight.gameValue, 8)
        XCTAssertEqual(CardValueName.nine.gameValue, 9)
        XCTAssertEqual(CardValueName.ten.gameValue, 10)
        XCTAssertEqual(CardValueName.jack.gameValue, 10)
        XCTAssertEqual(CardValueName.queen.gameValue, 10)
        XCTAssertEqual(CardValueName.king.gameValue, 10)
    }

    // MARK: - Test CardDeck

    func test_CardDeckDraw() {
        let cardDeck = CardDeck()
        let currentCard = cardDeck.drawCard()

        // testing randomness is tricky, so instead we loop over the
        // method 100 times to make sure it's not returning the same
        // value every time
        for _ in 0..<100 {
            if currentCard != cardDeck.drawCard() {
                XCTAssert(true, "CardDeck().drawCard() returned a different value")
                return
            }
        }
        // if the for loop ends and a unique card has never been achieved then the test fails
        XCTAssert(false, "CardDeck().drawCard() is returning the same value every time")
    }

}
