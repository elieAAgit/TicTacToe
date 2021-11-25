//
//  TicTacToeModelTests.swift
//  TicTacToeTests
//
//  Created by Elie Arquier on 24/11/2021.
//

import XCTest
@testable import TicTacToe

class TicTacToeModelTests: XCTestCase {
    var model: TicTacToeModel!
    var controller: TicTacToeViewController!

    func refresh() {
        BoxStatus.boxStatus = ["", "", "", "", "", "", "", "", ""]
    }

    override func setUp() {
        super.setUp()

        model = TicTacToeModel()
        controller = TicTacToeViewController()
    }

    // Solo party: none boxes empty
    func testGivenSoloPlayerParty_whenNoneBoxesIsEmpty_then() {
        refresh()

        UserPreferences.numberPlayers = 0
        UserPreferences.level = 0

        BoxStatus.boxStatus = ["circle", "circle", "circle", "circle", "circle", "circle", "circle", "circle", "circle"]

        model.playerChoice(sender: 1)
    }

// MARK: - Multiplayer

    // multiplayer party: none boxes empty
     func testGivenMultiPlayerParty_whenNoneBoxesIsEmpty_then() {
         refresh()

         UserPreferences.numberPlayers = 1
         UserPreferences.level = 0

         BoxStatus.boxStatus = ["circle", "circle", "circle", "circle", "circle", "circle", "circle", "circle", "circle"]

         model.playerChoice(sender: 1)
     }
}
