//
//  CardValueName.swift
//  Baccarat Drawing Rules L
//
//  Created by Adam Moskovich on 12/27/19.
//  Copyright © 2019 Adam Moskovich. All rights reserved.
//

/// All card names inside the suits,
///
/// i.e `ace`, `five`, `queen`
enum CardValueName: Int, CaseIterable {
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

    /// rawValue starts at 0, the cards face values start at 1. So to get the face value we need to add 1
    private var faceValue: Int {
        self.rawValue + 1
    }

    /// The max value returned in baccarat is always 10
    var gameValue: Int {
        self.faceValue <= 10 ? self.faceValue : 10
    }

    /// Returns a random card name from the availible cases
    static func random() -> CardValueName {
        CardValueName.allCases.randomElement()!
    }
}
