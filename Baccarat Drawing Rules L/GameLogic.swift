//
//  gameLogic.swift
//  Baccarat Drawing Rules L
//
//  Created by Adam on 25/03/2018.
//  Copyright © 2018 Adam Moskovich. All rights reserved.
//

import Foundation

enum MessageType {
    case correct
    case playerDrawFirst
    case playerStand67
    case bankRules
    case error
}

class GameLogic {

    // MARK: - Declare instance variables here

    var bankCard1Value: Int = 0
    var bankCard2Value: Int = 0
    var bankCard3Value: Int = 0

    var playerCard1Value: Int = 0
    var playerCard2Value: Int = 0
    var playerCard3Value: Int = 0

    // MARK: - Computer properties

    // We are using %10 to get the first digit, Baccarat only uses the first digit
    var bankFirstTwoCardTotal: Int {
        return (bankCard1Value + bankCard2Value) % 10
    }
    var playerFirstTwoCardTotal: Int {
        return (playerCard1Value + playerCard2Value) % 10
    }
    var bankTotalHand: Int {
        return (bankFirstTwoCardTotal + bankCard3Value) % 10
    }
    var playerTotalHand: Int {
        return (playerFirstTwoCardTotal + playerCard3Value) % 10
    }

    // MARK: - Setup Hand Function

    /// Takes the randomly generated number 1 - 52, converts to card value with 10's and faces equaling 0
    ///
    /// - Parameter cardNumber: randomly generated number between 1 - 52
    /// - Returns: Value of the face image with 10s and faces equalling 0
    func computeCardValue(cardNumber: Int) -> Int {
        let number = cardNumber % 13
        let cardValue = number < 10 ? number : 0
        return cardValue
    }

    // MARK: - Checking Answer

    /// Checks if there is a 'Natrual"
    /// - If the first two cards of either hand have a total that ends in 8 or 9
    ///
    /// - Returns: If the hand is 'Natrual' returns true
    func areCardTotalsNatrual() -> Bool {
        if bankFirstTwoCardTotal == 8 ||
            bankFirstTwoCardTotal == 9 ||
            playerFirstTwoCardTotal == 8 ||
            playerFirstTwoCardTotal == 9 {

            print("Fail - hand is natrual")
            return true
        }
        return false
    }

    /// Checks if player draw is correct
    ///
    /// - Returns: 'true' if draw is correct, 'false' if not
    func isPlayerDrawCorrect() -> Bool {
        if playerFirstTwoCardTotal <= 5 {
            print("Correct! isPlayerDrawCorrect shows first two player cards are <= 5, playerFirstTwoCardTotal = \(playerFirstTwoCardTotal)")
            return true
        }
        print("Fail! isPlayerDrawCorrect shows first two player cards are bigger than 5, playerFirstTwoCardTotal = \(playerFirstTwoCardTotal)")
        return false
    }
    /// Checks if bank draw is correct
    ///
    ///
    /// - Returns: enum messageType:
    /// - correct
    /// - playerDrawFirst
    /// - playerStand67
    /// - bankRules
    /// - error
    func isBankDrawCorrect(isPlayers3rdViewHidden players3rdViewIsHidden: Bool) -> MessageType {
        if players3rdViewIsHidden && (playerFirstTwoCardTotal != 6 && playerFirstTwoCardTotal != 7) {
            if playerFirstTwoCardTotal <= 5 {
                print("Fail - Player should draw, they have \(playerFirstTwoCardTotal)")
                return MessageType.playerDrawFirst
            } else {
                print("Player total is not 6 - 7 or 0 - 5, somthing is wrong")
                return MessageType.error
            }
        } else if players3rdViewIsHidden && (playerFirstTwoCardTotal == 6 || playerFirstTwoCardTotal == 7) {
            if bankFirstTwoCardTotal <= 5 {
                return MessageType.correct
            } else {
                print("Fail - When the player stands with a 6 - 7, the bank only draws with 0 - 5")
                return MessageType.playerStand67
            }
        } else {

            switch (bankFirstTwoCardTotal) {

            case 0...2 :
                print("Bank draws, 0 - 2")
                return MessageType.correct
            case 3 :
                if playerCard3Value != 8 {
                    print("Back draws, it has 3 and the player is has not drawn an 8")
                    return MessageType.correct
                } else {
                    print("Fail - Bank doesn't draw since it has a 3 and the player had an 8")
                    return MessageType.bankRules
                }
            case 4 :
                let cardValueArray = [2, 3, 4, 5, 6, 7]
                if cardValueArray.contains(playerCard3Value) {
                    print("Bank draws because it has 4 and player draw a 2-7")
                    return MessageType.correct
                } else {
                    print("Fail - Bank doesn't draw since it has a 4 and the player didn't draw 2-7")
                    return MessageType.bankRules
                }
            case 5 :
                let cardValueArray = [4, 5, 6, 7]
                if cardValueArray.contains(playerCard3Value) {
                    print("Bank draws because it has 5 and player draw a 4-7")
                    return MessageType.correct
                } else {
                    print("Fail - Bank doesn't draw since it has a 5 and the player didn't draw 4-7")
                    return MessageType.bankRules
                }
            case 6 :
                let cardValueArray = [6, 7]
                if cardValueArray.contains(playerCard3Value) {
                    print("Bank draws because it has 6 and player draw a 6-7")
                    return MessageType.correct
                } else {
                    print("Fail - Bank doesn't draw since it has a 6 and the player didn't draw 6-7")
                    return MessageType.bankRules
                }
            case 7 :
                print("Fail - Bank doesn't draw on 7")
                return MessageType.bankRules
            default :
                print("Bank third card rule didn't work")
                return MessageType.error
            }

        }

    }

    /// When the user selects a winner, this function checks if the right number of cards have been drawn
    ///
    /// - Parameters:
    ///   - banks3rdViewisHidden: Is the banker 3rd card visible? Enter: "bank3ViewBackground.isHidden"
    ///   - players3rdViewIsHidden: Is the player 3rd card visible? Enter: "player3ViewBackground.isHidden"
    /// - Returns: returns 'true' if the draws are correct, 'false' if not
    func checkDraw(isBanks3rdViewHidden banks3rdViewisHidden: Bool, isPlayers3rdViewHidden players3rdViewIsHidden: Bool) -> Bool {

        if !banks3rdViewisHidden && !players3rdViewIsHidden {
            return true
        } else if players3rdViewIsHidden {
            if !isPlayerDrawCorrect() {
                if  !banks3rdViewisHidden {
                    print("Player card is hidden !isPlayerDrawCorrect and bank 3rd card is shown")
                    return true
                } else if isBankDrawCorrect(isPlayers3rdViewHidden: players3rdViewIsHidden) != MessageType.correct {
                    print("Player card hidden and Bank card is hidden and check agrees")
                    return true
                } else {
                    print("Player card hidden and Bank card is hidden and check doesn't agrees")
                    return false
                }
            } else {
                return false
            }
        } else {
            if isBankDrawCorrect(isPlayers3rdViewHidden: players3rdViewIsHidden) != MessageType.correct {
                return true
            } else {
                return false
            }
        }
    }

}
