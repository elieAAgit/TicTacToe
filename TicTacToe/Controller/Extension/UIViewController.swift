//
//  UIViewController.swift
//  TicTacToe
//
//  Created by Elie Arquier on 24/11/2021.
//

import UIKit

extension UIViewController {
    /// Alerts user in case of error
    func alert(notification: Notification) {
        var title = ""
        var message = "error"

        guard let userInfo = notification.userInfo else { return }

        guard let error = userInfo["userInfo"] as? Notification.Alert else { return }

        // show the correct error
        switch error {
            case .notEmpty:
            message = "Cette case a déja été choisi."
            case .noneEmpty:
            title = "Cette partie est déja terminé!"
            message = "Vous devez commencer une nouvelle partie pour rejouer."
            case .numberPlayersNotValid:
            message = "Le nombre de joueurs n'est pas valide."
            case .unkhnownPlayer:
            message = "Ce joueur est inconnu."
        }

        alertVC(title: title, message: message)
    }

    /// Main alert function
    private func alertVC(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
