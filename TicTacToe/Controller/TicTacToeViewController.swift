//
//  TicTacToeViewController.swift
//  TicTacToe
//
//  Created by Elie Arquier on 24/11/2021.
//

import UIKit

class TicTacToeViewController: UIViewController {
    // Instance of TicTacToeModel
    var ticTacToeModel = TicTacToeModel()
    
    @IBOutlet weak var presentation: UILabel!
    @IBOutlet var playerChoiceButtons: [UIButton]!

    // View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Load a new grid at startup
        ticTacToeModel.refresh()

        presentation.text = "Bonjour " + UserPreferences.name

        // Fill in the box with the correct image
        NotificationCenter.default.addObserver(self, selector: #selector(ticTacToeAction(notification:)), name: .ticTacToeNotificationName, object: nil)

        // Inform player of game status
        NotificationCenter.default.addObserver(self, selector: #selector(ticTacToeInformation(notification:)), name: .ticTacToeInformationPlayerName, object: nil)

        // Alerts the player in case of error
        NotificationCenter.default.addObserver(self, selector: #selector(alertTTC(notification:)), name: .alertNotificationName, object: nil)
    }

    override func viewDidAppear(_ animated: Bool) {
        // Load changes in preferences
        ticTacToeModel.refresh()
        nameUser()
    }
}

// MARK: - User name
extension TicTacToeViewController {
    private func nameUser() {
        presentation.text = "Bonne chance " + UserPreferences.name
    }
}

// MARK: - Player choice function
extension TicTacToeViewController {
    /// When player chose box
    @IBAction func playerChoiceButtonTapped(_ sender: UIButton) {
        sender.animated()

        ticTacToeModel.playerChoice(sender: sender.tag)
    }

    /// Launch of a new game
    @IBAction func newGame(_ sender: Any) {
        ticTacToeModel = TicTacToeModel()
        ticTacToeModel.refresh()
    }
}

// MARK: - Notifications
extension TicTacToeViewController {
    /// Fill in the box with the correct image
    @objc private func ticTacToeAction(notification: Notification) {
        guard let userInfo = notification.userInfo else { return }

        guard let sender = userInfo["sender"] as? Int else { return }
        guard let image = userInfo["image"] as? String else { return }

        if image == StatusEnum.circle.rawValue || image == StatusEnum.cross.rawValue {
            playerChoiceButtons[sender].setImage(UIImage(named: image), for: UIControl.State.normal)
        } else if image == StatusEnum.isEmpty.rawValue {
            playerChoiceButtons[sender].setImage(nil, for: UIControl.State.normal)
        }
    }

    /// Inform player of game status
    @objc private func ticTacToeInformation(notification: Notification) {
        guard let userInfo = notification.userInfo else { return }

        guard let playerName = userInfo["name"] as? String else { return }

        guard let text = userInfo["text"] as? Notification.informationPlayer else { return }

        switch text {
            case .initial:
            presentation.text = "Nouvelle partie"
            case .winner:
            presentation.text = "Félicitations \(playerName), Vous avez gagné!"
            case .loser:
            presentation.text = "Vous avez perdu."
            case .equal:
            presentation.text = "Egalité!"
            case .winnerMulti:
            presentation.text = "\(playerName) gagne!"
            case .turn:
            presentation.text = "C'est a vous de jouer, \(playerName)."
            case .draw:
            presentation.text = "Tirage au sort ... \(playerName) commence!"
        }
    }

    /// Alerts the player in case of error
    @objc private func alertTTC (notification: Notification) {
        alert(notification: notification)
    }
}
