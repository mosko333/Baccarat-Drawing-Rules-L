//
//  CardShoe.swift
//  Baccarat Drawing Rules L
//
//  Created by Adam Moskovich on 12/27/19.
//  Copyright © 2019 Adam Moskovich. All rights reserved.
//

class CardShoe {

    // MARK: - Properties

    /// True - unlimited random cards passed back from the shoe
    /// False - shoe will contain a finite number of cards that are shuffled and passed back
    private(set) var hasUnlimitedCards: Bool
    /// An array of all the cards in the shoe
    private(set) var finiteCardsInShoe: [Card] = []
    // the min number of cards that need to be in the shoe to cantinue dealing
    private let minCardCout = 25

    /// A Bool indicating if anymore hands can be dealt after this one
    var isLastHand: Bool {
        // if cards are unlimited then the shoe will never run out of cards
        guard !hasUnlimitedCards else { return false }
        // otherwise when a min number is reached it will return true
        return finiteCardsInShoe.count < minCardCout
    }

    // MARK: - init

    init(withUnlimitedCards unlimitedCards: Bool = false, numberOfDecks: Int = 8) {
        self.hasUnlimitedCards = unlimitedCards
        // if the shoe is returning unlimited random cards then it doesn't need to create a finite shoe
        if !self.hasUnlimitedCards {
            self.createNewShoeWith(numberOfDecks: numberOfDecks)
        }
    }

    // MARK: - Draw Card

    /// Method will draw a randomly generated card or a card from the shoe based on the shoes setup
    func drawCard() -> Card {
        self.hasUnlimitedCards ? self.drawUnlimitedRandomCards() : self.drawCardFromShoe()
    }

    // - MARK: - Unlimited shoe methods

    // MARK: - Draw Unlimited

    private func drawUnlimitedRandomCards() -> Card {
        Card(suit: CardSuit.random(), valueName: CardValueName.random())
    }

    // - MARK: - Finite shoe methods

    // MARK: - Shoe Setup

    /// Does complete shoe setup:
    ///
    /// - Adds all the cards to the shoe,
    /// - Shuffles
    /// - Discards the 'burn cards'
    func createNewShoeWith(numberOfDecks: Int) {
        // a new shoe uses a finite number of cards
        self.hasUnlimitedCards = false
        // resets the shoe to empty
        self.finiteCardsInShoe = []

        // adds all the cards to the shoe
        for suit in CardSuit.allCases {
            for valueName in CardValueName.allCases {
                let card = (Card(suit: suit, valueName: valueName))
                finiteCardsInShoe.append(contentsOf: repeatElement(card, count: numberOfDecks))
            }
        }

        self.finiteCardsInShoe.shuffle()
        // the rules of the game requite a certain number of cards be discarded at the start
        self.burnCards()
    }

    /// A random number of cards are discarded at the start of a new shoe
    private func burnCards() {
        let burnCard = self.drawCardFromShoe()
        for _ in 0..<burnCard.gameValue {
            self.drawCardFromShoe()
        }
    }

    // MARK: - Draw Finite

    /// Removes and returns the last card in the shoe
    @discardableResult
    private func drawCardFromShoe() -> Card {
        assert(!finiteCardsInShoe.isEmpty, "This method shouldn't be called on an empty shoe")
        return self.finiteCardsInShoe.removeLast()
    }
}
