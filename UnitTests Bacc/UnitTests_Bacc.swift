//
//  UnitTests_Bacc.swift
//  UnitTests Bacc
//
//  Created by Adam Moskovich on 12/26/19.
//  Copyright © 2019 Adam Moskovich. All rights reserved.
//

import XCTest
@testable import Baccarat_Drawing_Rules_L

class UnitTests_Bacc: XCTestCase {

    let gameLogic = GameLogic()

    override func setUp() {
        self.setFirstFourHand(b1: 0, b2: 0, p1: 0, p2: 0)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    // MARK: - .areCardTotalsNatrual()

    func test_BankForNatrualTotals() {
        // test bank for positives (8 - 9 total)
        self.setFirstFourHand(b1: 4, b2: 4, p1: 2, p2: 3)
        XCTAssertEqual(gameLogic.areCardTotalsNatrual(), true)
        self.setFirstFourHand(b1: 4, b2: 5, p1: 2, p2: 3)
        XCTAssertEqual(gameLogic.areCardTotalsNatrual(), true)
        self.setFirstFourHand(b1: 5, b2: 4, p1: 2, p2: 3)
        XCTAssertEqual(gameLogic.areCardTotalsNatrual(), true)
        self.setFirstFourHand(b1: 0, b2: 8, p1: 2, p2: 3)
        XCTAssertEqual(gameLogic.areCardTotalsNatrual(), true)
        self.setFirstFourHand(b1: 9, b2: 9, p1: 2, p2: 3)
        XCTAssertEqual(gameLogic.areCardTotalsNatrual(), true)
        self.setFirstFourHand(b1: 8, b2: 0, p1: 2, p2: 3)
        XCTAssertEqual(gameLogic.areCardTotalsNatrual(), true)
        self.setFirstFourHand(b1: 8, b2: 1, p1: 5, p2: 3)
        XCTAssertEqual(gameLogic.areCardTotalsNatrual(), true)
    }

    func test_PlayerForNatrualTotals() {
        // test bank for positives (8 - 9 total)
        self.setFirstFourHand(b1: 1, b2: 2, p1: 4, p2: 4)
        XCTAssertEqual(gameLogic.areCardTotalsNatrual(), true)
        self.setFirstFourHand(b1: 1, b2: 2, p1: 4, p2: 5)
        XCTAssertEqual(gameLogic.areCardTotalsNatrual(), true)
        self.setFirstFourHand(b1: 1, b2: 2, p1: 5, p2: 4)
        XCTAssertEqual(gameLogic.areCardTotalsNatrual(), true)
        self.setFirstFourHand(b1: 1, b2: 2, p1: 0, p2: 8)
        XCTAssertEqual(gameLogic.areCardTotalsNatrual(), true)
        self.setFirstFourHand(b1: 1, b2: 2, p1: 9, p2: 0)
        XCTAssertEqual(gameLogic.areCardTotalsNatrual(), true)
        self.setFirstFourHand(b1: 3, b2: 6, p1: 8, p2: 1)
        XCTAssertEqual(gameLogic.areCardTotalsNatrual(), true)
    }

    func test_NoNatruals() {
        // test that neither hand totals 8 - 9
        self.setFirstFourHand(b1: 0, b2: 0, p1: 0, p2: 0)
        XCTAssertEqual(gameLogic.areCardTotalsNatrual(), false)
        self.setFirstFourHand(b1: 9, b2: 7, p1: 9, p2: 6)
        XCTAssertEqual(gameLogic.areCardTotalsNatrual(), false)
        self.setFirstFourHand(b1: 0, b2: 1, p1: 0, p2: 1)
        XCTAssertEqual(gameLogic.areCardTotalsNatrual(), false)
    }

    // MARK: - Test Helpers

    private func setFirstFourHand(b1: Int, b2: Int, p1: Int, p2: Int) {
        gameLogic.bankCard1Value = b1
        gameLogic.bankCard2Value = b2
        gameLogic.playerCard1Value = p1
        gameLogic.playerCard2Value = p2
    }

}
