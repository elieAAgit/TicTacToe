//
//  TicTacToeModel.swift
//  TicTacToe
//
//  Created by Elie Arquier on 24/11/2021.
//

import Foundation

class TicTacToeModel {

    // MARK: - Properties

    // Three types of player
    private var host = UserPreferences.name
    private var guest = "Invité"
    private var iA = TicTacToeIA()
    // Order of play after drawing
    private var playerOne = ""
    private var playerTwo = ""
    // Define active player
    private var playerAttack = ""
    private var playerDefense = ""

    // Party continues
    private var isNotOver = true
    // Box target is empty
    private var isEmpty: Bool {
        return BoxStatus.boxStatus.contains(StatusEnum.isEmpty.rawValue)
    }
}

// MARK: - Methods
extension TicTacToeModel {
    /// Player choice: solo game or multiplayers game
    func playerChoice (sender: Int) {
        // Solo game
        if UserPreferences.numberPlayers == 0 {
            soloPlayer(sender: sender)
        // Multiplayer game
        } else if UserPreferences.numberPlayers == 1 {
            multiPlayer(sender: sender)
        // Error number of players
        } else {
            Notification.alertNotification(userInfo: .numberPlayersNotValid)
        }
    }

    /// Solo player against "IA"
    private func soloPlayer (sender: Int) {
        // If no box is empty, or game is over, the game cannot be continued
        guard isEmpty && isNotOver else {
            return Notification.alertNotification(userInfo: .noneEmpty)
        }

        // If selected box is not empty
        guard BoxStatus.boxStatus[sender] == StatusEnum.isEmpty.rawValue else {
            return Notification.alertNotification(userInfo: .notEmpty)
        }

        // If selected box is empty
        BoxStatus.boxStatus[sender] = StatusEnum.circle.rawValue
        Notification.ticTacToeNotification(image: BoxStatus.boxStatus[sender], sender: sender)

        // If player win the party
        if BoxStatus.winner() == true {
            Notification.ticTacToeInformationPlayer(condition: .winner, name: host)
            isNotOver = false
        }

        // If party is not over: "IA" turn
        if isEmpty && isNotOver {
            isNotOver = iA.play()
        }

        // If party is ending without winner
        if !isEmpty && isNotOver {
            Notification.ticTacToeInformationPlayer(condition: .equal, name: "")

        }
    }

    /// Multiplayer party
    private func multiPlayer (sender: Int) {
        var boxImage = ""

        // If no box is empty, or game is over, the game cannot be continued
        guard isEmpty && isNotOver else {
            return Notification.alertNotification(userInfo: .noneEmpty)
        }

        // Player one plays always with circle
        if playerAttack == playerOne {
            boxImage = StatusEnum.circle.rawValue
        // Player two plays always with cross
        } else if playerAttack == playerTwo {
            boxImage = StatusEnum.cross.rawValue
        } else {
            Notification.alertNotification(userInfo: .unkhnownPlayer)
        }

        // If selected box is not empty
        guard BoxStatus.boxStatus[sender] == StatusEnum.isEmpty.rawValue else {
            return Notification.alertNotification(userInfo: .notEmpty)
        }

        // If selected box is empty
        BoxStatus.boxStatus[sender] = boxImage
        Notification.ticTacToeNotification(image: BoxStatus.boxStatus[sender], sender: sender)

        // If player attacker win the party
        if BoxStatus.winner() == true {
            Notification.ticTacToeInformationPlayer(condition: .winnerMulti, name: playerAttack)
            isNotOver = false
        }
        
        // If party continu, display player defenser plays next round
        if isNotOver {
            Notification.ticTacToeInformationPlayer(condition: .turn, name: playerDefense)
        }

        // If party is ending without winner
        if !isEmpty && isNotOver {
            Notification.ticTacToeInformationPlayer(condition: .equal, name: "")
        }

        // Swpa player positions, defending player plays the next round
        swap(&playerAttack, &playerDefense)
    }

    /// New game
    func refresh() {
        // Refresh name display
        host = UserPreferences.name
        // Reboot continuation of the game
        isNotOver = true
        // Clean array to manage the user actions and to store the names of the images used
        BoxStatus.boxStatus = ["", "", "", "", "", "", "", "", ""]

        // Display cleaning
        for element in 0 ... 8 {
            Notification.ticTacToeNotification(image: BoxStatus.boxStatus[element], sender: element)
        }

        // Display presentation of new game
        Notification.ticTacToeInformationPlayer(condition: .initial, name: "")

        // If multi-players mode
        if UserPreferences.numberPlayers == 1 {
            // First player draw
            let random: Int = Int.random(in: 0 ... 1)

            // Host is player one
            if random == 0 {
                playerOne = host
                playerTwo = guest
            //Invite is player one
            } else if random == 1 {
                playerOne = guest
                playerTwo = host
            } else {
                Notification.alertNotification(userInfo: .numberPlayersNotValid)
            }

            // If no error when naming players, fixing first attacker
            if random == 0 || random == 1 {
                playerAttack = playerOne
                playerDefense = playerTwo
                Notification.ticTacToeInformationPlayer(condition: .draw, name: playerAttack)
            }
        }
    }
}

