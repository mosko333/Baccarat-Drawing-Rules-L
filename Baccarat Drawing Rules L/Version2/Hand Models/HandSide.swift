//
//  HandSide.swift
//  Baccarat Drawing Rules L
//
//  Created by Adam Moskovich on 12/27/19.
//  Copyright © 2019 Adam Moskovich. All rights reserved.
//

struct HandSide {

    // MARK: - Properties

    let sideName: SideName

    // Cards
    private(set) var cardOne: Card?
    private(set) var cardTwo: Card?
    private(set) var cardThree: Card?

    // MARK: - Return Info

    /// Int representing the total of the first two cards when %10
    var twoCardTotal: Int? {
        // if the side has no cards yet then it needs to return nil
        guard let cardOne = cardOne, let cardTwo = cardTwo else { return nil }
        // the rules of baccarat always return %10 totals
        return (cardOne.gameValue + cardTwo.gameValue) % 10
    }

    /// Returns the final %10 value of the side regardless of how many cards have been drawn
    var finalTotal: Int? {
        // if the side has no cards yet then it needs to return nil
        guard let twoCardTotal = twoCardTotal else { return nil }
        // a third card isn't needed for a valid total
        return (twoCardTotal + (cardThree?.gameValue ?? 0)) % 10
    }

    /// Bool expressing if the first two cards total 8 or 9
    var isNatrual: Bool? {
        guard let twoCardTotal = twoCardTotal else { return nil }
        return twoCardTotal == 8 || twoCardTotal == 9 ? true : false
    }

    // MARK: - Change Card Methods

    /// Resets to a new hand
    mutating func drawNewHandWith(firstCard: Card, secondCard: Card) {
        cardOne = firstCard
        cardTwo = secondCard
        cardThree = nil
    }

    /// Adds a third card to the hand
    mutating func drawThirdCard(_ card: Card) {
        cardThree = card
    }
}
