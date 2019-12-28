//
//  CardName.swift
//  Baccarat Drawing Rules L
//
//  Created by Adam Moskovich on 12/27/19.
//  Copyright © 2019 Adam Moskovich. All rights reserved.
//

/// All card names inside the suits,
///
/// i.e `ace`, `five`, `queen`
enum CardName: Int, CaseIterable {
    case ace
    case two
    case three
    case four
    case five
    case six
    case seven
    case eight
    case nine
    case ten
    case jack
    case queen
    case king

    /// The max value returned in baccarat is always 10
    var gameValue: Int {
        self.rawValue >= 10 ? self.rawValue : 10
    }

    /// Returns a random card name from the availible cases
    static func returnRandom() -> CardName {
        CardName.allCases.randomElement()!
    }
}
