//
//  Card.swift
//  Baccarat Drawing Rules L
//
//  Created by Adam Moskovich on 12/27/19.
//  Copyright © 2019 Adam Moskovich. All rights reserved.
//

struct Card: Equatable {

    let suit: CardSuit
    let valueName: CardValueName

    /// Returns the cards numeric value for this game
    var gameValue: Int {
        valueName.gameValue
    }

    /// Returns the name of the image
    var imageName: String {
        CardImageName.of(self)
    }
}
