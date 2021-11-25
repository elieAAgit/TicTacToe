//
//  Notification.swift
//  TicTacToe
//
//  Created by Elie Arquier on 24/11/2021.
//

import Foundation

extension Notification {
    /// Inform player of game status
    enum informationPlayer {
        case initial, winner, loser, equal, winnerMulti, turn, draw
    }

    /// Alerts Cases
    enum Alert {
        case notEmpty, noneEmpty, numberPlayersNotValid, unkhnownPlayer
    }

    /// Fill in the box with the correct image
    static func ticTacToeNotification(image: String, sender: Int) {
        NotificationCenter.default.post(name: .ticTacToeNotificationName, object: nil, userInfo: ["image": image, "sender": sender])
    }

    /// Inform player of game status
    static func ticTacToeInformationPlayer(condition: informationPlayer, name: String) {
        NotificationCenter.default.post(name: .ticTacToeInformationPlayerName, object: nil, userInfo: ["text": condition, "name": name])
    }

    /// Alerts the player in case of error
    static func alertNotification(userInfo: Alert) {
        NotificationCenter.default.post(name: .alertNotificationName, object: nil, userInfo: ["userInfo": userInfo])
    }
}

