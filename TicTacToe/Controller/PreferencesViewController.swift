//
//  PreferencesViewController.swift
//  TicTacToe
//
//  Created by Elie Arquier on 24/11/2021.
//

import UIKit

class PreferencesViewController: UIViewController {

    @IBOutlet weak var currentName: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var numberPlayers: UISegmentedControl!
    @IBOutlet weak var levelGame: UISegmentedControl!

    override func viewDidLoad() {
        super.viewDidLoad()

        nameTextField.delegate = self
    }

    override func viewDidAppear(_ animated: Bool) {
        // Loading current user preferences
        currentName.text = UserPreferences.name
        levelGame.selectedSegmentIndex = UserPreferences.level
        numberPlayers.selectedSegmentIndex = UserPreferences.numberPlayers
    }
}

// MARK: - Method
extension PreferencesViewController {
    /// Saving user preferences: name, number of player and difficulty
    @IBAction func savePreferences(_ sender: UIButton) {
        sender.animated()

        guard let nameChange = nameTextField.text else { return }

        UserPreferences.level = levelGame.selectedSegmentIndex
        UserPreferences.numberPlayers = numberPlayers.selectedSegmentIndex

        guard nameChange != "" else { return }
        
        currentName.text = nameChange
        UserPreferences.name = nameChange
    }
    
}

// MARK: - Dismiss Keyboard
extension PreferencesViewController: UITextFieldDelegate {
    /// Dismiss keyboard when user touch screen
    @IBAction func dissmissKeyboard(_ sender: UITapGestureRecognizer) {
        hideKeyboard()
    }

    /// Dismiss keyboard when 'return' button is pressed
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        hideKeyboard()

        return true
    }

    /// Dismiss keyboard
    private func hideKeyboard() {
        nameTextField.resignFirstResponder()
    }
}
