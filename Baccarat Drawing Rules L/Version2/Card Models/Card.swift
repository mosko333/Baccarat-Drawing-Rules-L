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

    /// Returns the name of the image
    func imageName() -> String {
        CardImageName.of(self)
    }
}
