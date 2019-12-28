//
//  Card.swift
//  Baccarat Drawing Rules L
//
//  Created by Adam Moskovich on 12/27/19.
//  Copyright © 2019 Adam Moskovich. All rights reserved.
//

struct Card {

    let faceName: CardValueName
    let suit: CardSuit

    /// Returns the name of the image
    func imageName() -> String {
        CardImageName.of(self)
    }
}
