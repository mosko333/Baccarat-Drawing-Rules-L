//
//  ViewController.swift
//  Baccarat Drawing Rules L
//
//  Created by Adam on 03/03/2018.
//  Copyright © 2018 Adam Moskovich. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //Mark: - Link Model
    
    /// contains the logic for the Baccarat game
    var gameLogic = GameLogic()
    
    
    //MARK: - IBOutlet Declarations
    
    @IBOutlet weak var bank1ViewBackground: CustomizableImageView!
    @IBOutlet weak var bank2ViewBackground: CustomizableImageView!
    @IBOutlet weak var bank3ViewBackground: CustomizableImageView!
    @IBOutlet weak var player1ViewBackground: CustomizableImageView!
    @IBOutlet weak var player2ViewBackground: CustomizableImageView!
    @IBOutlet weak var player3ViewBackground: CustomizableImageView!
    
    @IBOutlet weak var bankCard1: UIImageView!
    @IBOutlet weak var bankCard2: UIImageView!
    @IBOutlet weak var bankCard3: UIImageView!
    @IBOutlet weak var playerCard1: UIImageView!
    @IBOutlet weak var playerCard2: UIImageView!
    @IBOutlet weak var playerCard3: UIImageView!
    
    @IBOutlet weak var messageBox: UIButton!
    
    //MARK: - viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()

        resetHand()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: - Card Layout Functions
    
    /// Rotates the 3rd cards 90 degrees
    func rotateCard(){
        //rotate rect
        bank3ViewBackground.transform = CGAffineTransform(rotationAngle: .pi / 2); //90 degree//rotation in radians
    }
    
    /// Rounds the corners of the cards
    ///
    /// - Parameter cornerRadius: This is the degree to which it rounds them
    func cornerRadiusOfCards(cornerRadius: CGFloat){
        bank1ViewBackground.layer.cornerRadius = cornerRadius
        bank2ViewBackground.layer.cornerRadius = cornerRadius
        bank3ViewBackground.layer.cornerRadius = cornerRadius
        player1ViewBackground.layer.cornerRadius = cornerRadius
        player2ViewBackground.layer.cornerRadius = cornerRadius
        player3ViewBackground.layer.cornerRadius = cornerRadius
    }
    
    //MARK: - Setup Hand Function
    
    
    /// Resets Hand, Fisrt two cards images and values are set to random numbers, the 3rd cards are set to 0
    func resetHand() {
        
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
    func setCardFace() -> (cardName: String, cardNumericValue: Int) {
        
        var cardName = "card"
        let randomCardNumber = Int(arc4random_uniform(52) + 1)
        let cardNumericValue = gameLogic.computeCardValue(cardNumber: randomCardNumber)
        cardName += String(randomCardNumber)
        
        return (cardName, cardNumericValue)
    }

    
    //MARK: - Checking Answer

    /// Checks if the hand is 'Natual'
    /// - If Yes the it changes to message box to the 'Natual' message
    ///
    /// - Returns: true for 'Natrual'
    func checkForNatruals() -> Bool {
        if gameLogic.areCardTotalsNatrual() {
            messageBox.setImage(#imageLiteral(resourceName: "messageNaturalHand"), for: .normal)
            return true
        }
            return false
    }

    
    /// Checks if the player should take a 3rd card
    ///
    /// - Returns: returns 'true' for a 3rd card. 'false' for no 3rd card
    func checkAnswerForPlayerDraw() -> Bool {
        if gameLogic.isPlayerDrawCorrect() {
            return true
        }
        messageBox.setImage(#imageLiteral(resourceName: "messagePlayerStands6AndUp"), for: .normal)
        return false
    }

    /// Checks if the banker should take a 3rd card
    ///
    /// - Returns: returns 'true' for a 3rd card. 'false' for no 3rd card
    func checkAnswerForBankDraw() -> Bool {
        let answerCode = gameLogic.isBankDrawCorrect(isPlayers3rdViewHidden: player3ViewBackground.isHidden)
        switch answerCode {
        case 0:
            return true
        case 1:
            messageBox.setImage(#imageLiteral(resourceName: "messagePlayerDrawsFirst"), for: .normal)
            return false
        case 2:
            messageBox.setImage(#imageLiteral(resourceName: "messageBankStandsAgainced6or7"), for: .normal)
            return false
        case 3:
            messageBox.setImage(#imageLiteral(resourceName: "messageBankDrawingRules"), for: .normal)
            return false
        case 666:
            messageBox.setImage(#imageLiteral(resourceName: "messageError"), for: .normal)
            return false
        default:
            print("probem with value returned to checkAnswerForBankDraw() in main VC")
            messageBox.setImage(#imageLiteral(resourceName: "messageError"), for: .normal)
            return false
        }
    }
    
        /// Checks if the right number of cards have been drawn to determin the winner
        ///
        /// - Returns: 'true' if the card count is correct
        func checkWinAnswer() -> Bool {
            if gameLogic.checkDraw(isBanks3rdViewHidden: bank3ViewBackground.isHidden, isPlayers3rdViewHidden: player3ViewBackground.isHidden) {
                return true
            }
            messageBox.setImage(#imageLiteral(resourceName: "messageDrawMoreCards"), for: .normal)
            return false
        }

    
    //MARK: - UIButtons
    
    /// Input for the 'Draw' Buttons
    ///
    /// - Parameter sender:
    /// - 0 - Bank Draw
    /// - 1 - Player Draw
    @IBAction func drawCard(_ sender: UIButton) {
        if messageBox.isHidden{
            if checkForNatruals() {
                messageBox.isHidden = false
            }
            else {
                let cardProperties = setCardFace()
                switch (sender.tag) {
                    
                // Bank Draw
                case 0:
                    if bank3ViewBackground.isHidden && checkAnswerForBankDraw() {
                        bankCard3.image = UIImage(named: cardProperties.cardName)
                        gameLogic.bankCard3Value = cardProperties.cardNumericValue
                        bank3ViewBackground.isHidden = false
                        print("Bank draws a \(cardProperties.cardNumericValue)")
                    }
                    else if bank3ViewBackground.isHidden && !checkAnswerForBankDraw() {
                        messageBox.isHidden = false
                        print("Bank should not draw a card")
                    }
                    else {
                        print("Bank has already drawn a card")
                    }

                // Player Draw
                case 1:
                    if player3ViewBackground.isHidden == true && checkAnswerForPlayerDraw() == true {
                        playerCard3.image = UIImage(named: cardProperties.cardName)
                        gameLogic.playerCard3Value = cardProperties.cardNumericValue
                        player3ViewBackground.isHidden = false
                        print("Player draws a \(cardProperties.cardNumericValue)")
                    }
                    else if player3ViewBackground.isHidden == true && checkAnswerForPlayerDraw() == false {
                        messageBox.isHidden = false
                        print("Player should not draw a card")
                    }
                    else {
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
    @IBAction func whoWins(_ sender: UIButton) {
        if messageBox.isHidden {
            if checkWinAnswer() || checkForNatruals() {
                switch (sender.tag) {
                case 0:
                    if gameLogic.bankTotalHand > gameLogic.playerTotalHand {
                        print("Bank Wins")
                        resetHand()
                    }
                    else {
                        messageBox.setImage(#imageLiteral(resourceName: "messageWrongWinner"), for: .normal)
                        messageBox.isHidden = false
                    }
                case 1:
                    if gameLogic.bankTotalHand == gameLogic.playerTotalHand {
                        print("Tie Wins")
                        resetHand()
                    }
                    else {
                        messageBox.setImage(#imageLiteral(resourceName: "messageWrongWinner"), for: .normal)
                        messageBox.isHidden = false
                    }
                case 2:
                    if gameLogic.playerTotalHand > gameLogic.bankTotalHand {
                        print("Player Wins")
                        resetHand()
                    }
                    else {
                        messageBox.setImage(#imageLiteral(resourceName: "messageWrongWinner"), for: .normal)
                        messageBox.isHidden = false
                    }
                default:
                    print("Something went wrong in the whoWins UIButton function")
                }
            }
            else {
                messageBox.setImage(#imageLiteral(resourceName: "messageDrawMoreCards"), for: .normal)
                messageBox.isHidden = false
                print("wrong Number of cards")
            }
        }
    }
    
    
    /// Button that dismisses the message
    ///
    /// - Parameter sender: The user hits the button to return to the game after a message is made visible
    @IBAction func messageButton(_ sender: UIButton) {
        messageBox.isHidden = true
    }
}




