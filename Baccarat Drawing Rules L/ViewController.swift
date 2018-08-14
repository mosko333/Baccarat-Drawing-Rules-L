//
//  ViewController.swift
//  Baccarat Drawing Rules L
//
//  Created by Adam on 03/03/2018.
//  Copyright © 2018 Adam Moskovich. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - Link Model

    /// contains the logic for the Baccarat game
    var gameLogic = GameLogic()

    // MARK: - IBOutlet Declarations

    @IBOutlet private weak var bank1ViewBackground: CustomizableImageView!
    @IBOutlet private weak var bank2ViewBackground: CustomizableImageView!
    @IBOutlet private weak var bank3ViewBackground: CustomizableImageView!
    @IBOutlet private weak var player1ViewBackground: CustomizableImageView!
    @IBOutlet private weak var player2ViewBackground: CustomizableImageView!
    @IBOutlet private weak var player3ViewBackground: CustomizableImageView!

    @IBOutlet private weak var bankCard1: UIImageView!
    @IBOutlet private weak var bankCard2: UIImageView!
    @IBOutlet private weak var bankCard3: UIImageView!
    @IBOutlet private weak var playerCard1: UIImageView!
    @IBOutlet private weak var playerCard2: UIImageView!
    @IBOutlet private weak var playerCard3: UIImageView!

    @IBOutlet private weak var messageBox: UIButton!

    // MARK: - viewDidLoad

    override func viewDidLoad() {
        super.viewDidLoad()

        resetHand()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Setup Hand Function

    /// Resets Hand, Fisrt two cards images and values are set to random numbers, the 3rd cards are set to 0
    private func resetHand() {

        messageBox.isHidden = true
        bank3ViewBackground.isHidden = true
        player3ViewBackground.isHidden = true

        gameLogic.bankCard3Value = 0
        gameLogic.playerCard3Value = 0

        var cardProperties = setCardFace()
        bankCard1.image = UIImage(named: cardProperties.cardName)
        gameLogic.bankCard1Value = cardProperties.cardNumericValue
        print("bankCard1Value is set to \(gameLogic.bankCard1Value)")

        cardProperties = setCardFace()
        bankCard2.image = UIImage(named: cardProperties.cardName)
        gameLogic.bankCard2Value = cardProperties.cardNumericValue
        print("bankCard2Value is set to \(gameLogic.bankCard2Value)")

        cardProperties = setCardFace()
        playerCard1.image = UIImage(named: cardProperties.cardName)
        gameLogic.playerCard1Value = cardProperties.cardNumericValue
        print("playerCard1Value is set to \(gameLogic.playerCard1Value)")

        cardProperties = setCardFace()
        playerCard2.image = UIImage(named: cardProperties.cardName)
        gameLogic.playerCard2Value = cardProperties.cardNumericValue
        print("playerCard2Value is set to \(gameLogic.playerCard2Value)")
        }

    /// Genrates a random image name and corresponding card value
    ///
    /// - Returns: Image name for card and it's value (0-9)
    private func setCardFace() -> (cardName: String, cardNumericValue: Int) {

        var cardName = "card"
        let randomCardNumber = Int(arc4random_uniform(52) + 1)
        let cardNumericValue = gameLogic.computeCardValue(cardNumber: randomCardNumber)
        cardName += String(randomCardNumber)

        return (cardName, cardNumericValue)
    }

    // MARK: - Checking Answer

    /// Checks if the hand is 'Natual'
    /// - If Yes the it changes to message box to the 'Natual' message
    ///
    /// - Returns: true for 'Natrual'
    private func checkForNatruals() -> Bool {
        if gameLogic.areCardTotalsNatrual() {
            messageBox.setImage(#imageLiteral(resourceName: "messageNaturalHand"), for: .normal)
            return true
        }
            return false
    }

    /// Checks if the player should take a 3rd card
    ///
    /// - Returns: returns 'true' for a 3rd card. 'false' for no 3rd card
    private func checkAnswerForPlayerDraw() -> Bool {
        if gameLogic.isPlayerDrawCorrect() {
            return true
        }
        messageBox.setImage(#imageLiteral(resourceName: "messagePlayerStands6AndUp"), for: .normal)
        return false
    }

    /// Checks if the banker should take a 3rd card
    ///
    /// - Returns: returns 'true' for a 3rd card. 'false' for no 3rd card
    private func checkAnswerForBankDraw() -> Bool {
        let answerCode: messageType = gameLogic.isBankDrawCorrect(isPlayers3rdViewHidden: player3ViewBackground.isHidden)
        switch answerCode {
        case .correct:
            return true
        case .playerDrawFirst:
            messageBox.setImage(#imageLiteral(resourceName: "messagePlayerDrawsFirst"), for: .normal)
            return false
        case .playerStand67:
            messageBox.setImage(#imageLiteral(resourceName: "messageBankStandsAgainced6or7"), for: .normal)
            return false
        case .bankRules:
            messageBox.setImage(#imageLiteral(resourceName: "messageBankDrawingRules"), for: .normal)
            return false
        case .error:
            messageBox.setImage(#imageLiteral(resourceName: "messageError"), for: .normal)
            return false
        }
    }

        /// Checks if the right number of cards have been drawn to determin the winner
        ///
        /// - Returns: 'true' if the card count is correct
        private func checkWinAnswer() -> Bool {
            if gameLogic.checkDraw(isBanks3rdViewHidden: bank3ViewBackground.isHidden, isPlayers3rdViewHidden: player3ViewBackground.isHidden) {
                return true
            }
            messageBox.setImage(#imageLiteral(resourceName: "messageDrawMoreCards"), for: .normal)
            return false
        }

    // MARK: - UIButtons

    /// Input for the 'Draw' Buttons
    ///
    /// - Parameter sender:
    /// - 0 - Bank Draw
    /// - 1 - Player Draw
    @IBAction private func drawCard(_ sender: UIButton) {
        if messageBox.isHidden {
            if checkForNatruals() {
                messageBox.isHidden = false
            } else {
                let cardProperties = setCardFace()
                switch (sender.tag) {

                // Bank Draw
                case 0:
                    if bank3ViewBackground.isHidden && checkAnswerForBankDraw() {
                        bankCard3.image = UIImage(named: cardProperties.cardName)
                        gameLogic.bankCard3Value = cardProperties.cardNumericValue
                        bank3ViewBackground.isHidden = false
                        print("Bank draws a \(cardProperties.cardNumericValue)")
                    } else if bank3ViewBackground.isHidden && !checkAnswerForBankDraw() {
                        messageBox.isHidden = false
                        print("Bank should not draw a card")
                    } else {
                        print("Bank has already drawn a card")
                    }

                // Player Draw
                case 1:
                    if player3ViewBackground.isHidden == true && checkAnswerForPlayerDraw() == true {
                        playerCard3.image = UIImage(named: cardProperties.cardName)
                        gameLogic.playerCard3Value = cardProperties.cardNumericValue
                        player3ViewBackground.isHidden = false
                        print("Player draws a \(cardProperties.cardNumericValue)")
                    } else if player3ViewBackground.isHidden == true && checkAnswerForPlayerDraw() == false {
                        messageBox.isHidden = false
                        print("Player should not draw a card")
                    } else {
                        print("Player has already drawn a card")
                    }
                default:
                    print("Something went wrong in the drawCard UIButton function")
                }
            }
        }
    }

    /// Input for which hand wins
    ///
    /// - Parameter sender:
    /// - 0 - Banker hand wins
    /// - 1 - Tie
    /// - 2 - Player hand wins
    @IBAction private func whoWins(_ sender: UIButton) {
        if messageBox.isHidden {
            if checkWinAnswer() || checkForNatruals() {
                switch (sender.tag) {
                case 0:
                    if gameLogic.bankTotalHand > gameLogic.playerTotalHand {
                        print("Bank Wins")
                        resetHand()
                    } else {
                        messageBox.setImage(#imageLiteral(resourceName: "messageWrongWinner"), for: .normal)
                        messageBox.isHidden = false
                    }
                case 1:
                    if gameLogic.bankTotalHand == gameLogic.playerTotalHand {
                        print("Tie Wins")
                        resetHand()
                    } else {
                        messageBox.setImage(#imageLiteral(resourceName: "messageWrongWinner"), for: .normal)
                        messageBox.isHidden = false
                    }
                case 2:
                    if gameLogic.playerTotalHand > gameLogic.bankTotalHand {
                        print("Player Wins")
                        resetHand()
                    } else {
                        messageBox.setImage(#imageLiteral(resourceName: "messageWrongWinner"), for: .normal)
                        messageBox.isHidden = false
                    }
                default:
                    print("Something went wrong in the whoWins UIButton function")
                }
            } else {
                messageBox.setImage(#imageLiteral(resourceName: "messageDrawMoreCards"), for: .normal)
                messageBox.isHidden = false
                print("wrong Number of cards")
            }
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>,
                               with event: UIEvent?) {
           messageBox.isHidden = true

    }

    /// Button that dismisses the message
    ///
    /// - Parameter sender: The user hits the button to return to the game after a message is made visible
    @IBAction private func messageButton(_ sender: UIButton) {
        messageBox.isHidden = true
    }
}
