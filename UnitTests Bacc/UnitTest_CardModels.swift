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
                let imageName = Card(suit: suit, valueName: valueName).imageName
                XCTAssert(!imageName.isEmpty, "The is no imageName for this card")
            }
        }
    }

    // MARK: - test CardSuit

    func test_CardSuitRandom() {
        // Loop over the method 100 times to make sure
        // it returns at least one unique value
        UnitTest_HelperMethods.test_uniqueness(numOfReps: 100, testingMethod: CardSuit.random)
    }

    // MARK: - Test CardValueName

    func test_CardNameRandom() {
        // Loop over the method 100 times to make sure
        // it returns at least one unique value
        UnitTest_HelperMethods.test_uniqueness(numOfReps: 100, testingMethod: CardValueName.random)
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

    // MARK: - Test cardShoe

    func test_cardShoeInitWithUnlimitedCards() {
        // test cards in unlimited shoe no decks
        var cardShoe = CardShoe(withUnlimitedCards: true)
        XCTAssert(cardShoe.finiteCardsInShoe.isEmpty, "A CardShoe with unlimited cards doesn't need any finite cards")

        // test cards in unlimited shoe with decks
        cardShoe = CardShoe(withUnlimitedCards: true, numberOfDecks: 4)
        XCTAssert(cardShoe.finiteCardsInShoe.isEmpty, "A CardShoe with unlimited cards doesn't need any finite cards")
    }

    func test_cardShoeInitWithFiniteCards() {
        // test cards in 4 deck finite shoe
        var cardShoe = CardShoe(withUnlimitedCards: false, numberOfDecks: 4)
        self.testHelper_cardShoeFiniteCardCount(cardShoe, numOfDecks: 4)

        // test cards in 6 deck finite shoe
        cardShoe = CardShoe(withUnlimitedCards: false, numberOfDecks: 6)
        self.testHelper_cardShoeFiniteCardCount(cardShoe, numOfDecks: 6)

        // test cards in 8 deck finite shoe
        cardShoe = CardShoe(withUnlimitedCards: false, numberOfDecks: 8)
        self.testHelper_cardShoeFiniteCardCount(cardShoe, numOfDecks: 8)
    }

    func test_createNewShoe() {
        // test with initial unlimited shoe
        var shoe = CardShoe(withUnlimitedCards: true)
        shoe.createNewShoeWith(numberOfDecks: 7)
        testHelper_cardShoeFiniteCardCount(shoe, numOfDecks: 7)
        XCTAssertEqual(shoe.hasUnlimitedCards, false)

        // test with initial finite shoe
        shoe = CardShoe(withUnlimitedCards: false, numberOfDecks: 9)
        shoe.createNewShoeWith(numberOfDecks: 6)
        testHelper_cardShoeFiniteCardCount(shoe, numOfDecks: 6)
        XCTAssertEqual(shoe.hasUnlimitedCards, false)
    }

    private func testHelper_cardShoeFiniteCardCount(_ cardShoe: CardShoe, numOfDecks: Int) {
        // get the current number of finite cards in the shoe
        let numInShoe = Double(cardShoe.finiteCardsInShoe.count)

        // work out the inital expected count based on 52 cards in a deck
        var expectedNum = Double(numOfDecks * 52)
        // cards are burned of the rop of the deck, this can be from 2 - 11 cards
        // so mid point is 6.5 with an accuracy of 4.5
        expectedNum -= 6.5

        // test that we are within the expected range
        XCTAssertEqual(numInShoe, expectedNum, accuracy: 4.5)
    }

    func test_cardShoeDrawUnlimited() {
        let cardShoe = CardShoe(withUnlimitedCards: true)

        // testing randomness is tricky, so instead we loop over the
        // method 20 times to make sure it's not returning the same
        // value every time
        UnitTest_HelperMethods.test_uniqueness(numOfReps: 20, testingMethod: cardShoe.drawCard)
    }

    func test_cardShoeDrawFinite() {
        let cardShoe = CardShoe(withUnlimitedCards: false, numberOfDecks: 4)
        // with only 4 decks, the same card should never appear 5 times
        UnitTest_HelperMethods.test_uniqueness(numOfReps: 5, testingMethod: cardShoe.drawCard)
    }

    func test_isLastHand() {
        // make a small shoe
        let shoe = CardShoe(numberOfDecks: 3)

        while shoe.finiteCardsInShoe.count >= 13 {
            XCTAssertEqual(shoe.isLastHand, false, "It should only be the last hand if less than 13 cards are left")
            _ = shoe.drawCard()
        }
        XCTAssertEqual(shoe.isLastHand, true)
    }
}
