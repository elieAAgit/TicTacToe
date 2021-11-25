//
//  UserDefault.swift
//  TicTacToe
//
//  Created by Elie Arquier on 24/11/2021.
//

import Foundation

class UserPreferences {
    private struct Keys {
        static var name = "name"
        static var level = "level"
        static var numberPlayers = "numberPlayers"
    }

    /// To save the user name
    static var name: String {
        get {
            return UserDefaults.standard.string(forKey: Keys.name) ?? ""
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Keys.name)
        }
    }

    /// To manage the difficulty chosen by the user
    static var level: Int {
        get {
            return UserDefaults.standard.integer(forKey: Keys.level)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Keys.level)
        }
    }

    /// To manage the number of player chosen by the user
    static var numberPlayers: Int {
        get {
            return UserDefaults.standard.integer(forKey: Keys.numberPlayers)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Keys.numberPlayers)
        }
    }
}

