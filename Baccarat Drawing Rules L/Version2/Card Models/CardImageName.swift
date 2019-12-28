//
//  CardImageName.swift
//  Baccarat Drawing Rules L
//
//  Created by Adam Moskovich on 12/27/19.
//  Copyright © 2019 Adam Moskovich. All rights reserved.
//

struct CardImageName {

    // MARK: - Retrieve

    /// Retruns the name of the image of a card
    ///
    /// Can be used with `UIImage(named: )`
    /// - Parameter card: An instance of the Card model
    static func of(_ card: Card) -> String {
        guard let imageNameByFaceName = imageNameBySuitAndCardValueName[card.suit],
            let imageName = imageNameByFaceName[card.valueName] else {
                assert(false, "The cards was not found in the dictionary")
                return ""
        }
        return imageName
    }

    // MARK: - Data

    /// dictionary of all the image names of the cards
    static private let imageNameBySuitAndCardValueName: [CardSuit: [CardValueName: String]] =
        [.heart: [
            .ace: "card1",
            .two: "card2",
            .three: "card3",
            .four: "card4",
            .five: "card5",
            .six: "card6",
            .seven: "card7",
            .eight: "card8",
            .nine: "card9",
            .ten: "card10",
            .jack: "card11",
            .queen: "card12",
            .king: "card13"
            ],
         .club: [
            .ace: "card14",
            .two: "card15",
            .three: "card16",
            .four: "card17",
            .five: "card18",
            .six: "card19",
            .seven: "card20",
            .eight: "card21",
            .nine: "card22",
            .ten: "card23",
            .jack: "card24",
            .queen: "card25",
            .king: "card26"
            ],
         .dimond: [
            .ace: "card27",
            .two: "card28",
            .three: "card29",
            .four: "card30",
            .five: "card31",
            .six: "card32",
            .seven: "card33",
            .eight: "card34",
            .nine: "card35",
            .ten: "card36",
            .jack: "card37",
            .queen: "card38",
            .king: "card39"
            ],
         .spade: [
            .ace: "card40",
            .two: "card41",
            .three: "card42",
            .four: "card43",
            .five: "card44",
            .six: "card45",
            .seven: "card46",
            .eight: "card47",
            .nine: "card48",
            .ten: "card49",
            .jack: "card50",
            .queen: "card51",
            .king: "card52"
            ]
    ]
}
