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
    var cardOne: Card?
    var cardTwo: Card?
    var cardThree: Card?

    /// Int representing the total of the first two cards when %10
    var twoCardTotal: Int {
        guard let cardOne = cardOne, let cardTwo = cardTwo else { return 0 }
        return (cardOne.gameValue + cardTwo.gameValue) % 10
    }

    /// Bool expressing if the first two cards total 8 or 9
    var isNatrual: Bool {
        twoCardTotal == 8 || twoCardTotal == 9 ? true : false
    }

    // MARK: - Change Card Methods

    // MARK: - Return Info Methods

}
