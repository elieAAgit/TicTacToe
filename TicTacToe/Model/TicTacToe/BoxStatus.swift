//
//  BoxStatus.swift
//  TicTacToe
//
//  Created by Elie Arquier on 24/11/2021.
//

import Foundation

struct BoxStatus {
    /// Array to manage the user actions and to store the names of the images used for the operation of the game.
    static var boxStatus = ["", "", "", "", "", "", "", "", ""]

    /// To define winner of the party, if three same symbol are consecutive in lines, column or diagonal
    static func winner() -> Bool {
        var winner = false

        // Winner by line
        if boxStatus[0] != "" && boxStatus[0] == boxStatus[1] && boxStatus[1] == boxStatus[2] {
            winner = true
        } else if boxStatus[3] != "" && boxStatus[3] == boxStatus[4] && boxStatus[4] == boxStatus[5] {
            winner = true
        } else if boxStatus[6] != "" && boxStatus[6] == boxStatus[7] && boxStatus[7] == boxStatus[8] {
            winner = true
        }

        // Winner by column
        if boxStatus[0] != "" && boxStatus[0] == boxStatus[3] && boxStatus[3] == boxStatus[6] {
            winner = true
        } else if boxStatus[1] != "" && boxStatus[1] == boxStatus[4] && boxStatus[4] == boxStatus[7] {
            winner = true
        } else if boxStatus[2] != "" && boxStatus[2] == boxStatus[5] && boxStatus[5] == boxStatus[8] {
            winner = true
        }

        // Winner by diagonal
        if boxStatus[0] != "" && boxStatus[0] == boxStatus[4] && boxStatus[4] == boxStatus[8] {
            winner = true
        } else if boxStatus[2] != "" && boxStatus[2] == boxStatus[4] && boxStatus[4] == boxStatus[6] {
            winner = true
        }

        return winner
    }
}

