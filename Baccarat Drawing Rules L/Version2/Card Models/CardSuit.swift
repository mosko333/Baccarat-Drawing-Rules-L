//
//  CardSuit.swift
//  Baccarat Drawing Rules L
//
//  Created by Adam Moskovich on 12/27/19.
//  Copyright © 2019 Adam Moskovich. All rights reserved.
//

/// All the card suits
enum CardSuit: CaseIterable {
    case heart
    case club
    case dimond
    case spade

    /// Returns a random suit  from the availible cases
    static func returnRandom() -> CardSuit {
        CardSuit.allCases.randomElement()!
    }
}
