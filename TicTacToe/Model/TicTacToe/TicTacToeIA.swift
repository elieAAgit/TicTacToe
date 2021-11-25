//
//  TicTacToeIA.swift
//  TicTacToe
//
//  Created by Elie Arquier on 24/11/2021.
//

import Foundation

class TicTacToeIA {

// MARK: - Properties
    let boxes = 9
    let emptyCase = StatusEnum.isEmpty.rawValue
    let circleCase = StatusEnum.circle.rawValue
    let crossCase = StatusEnum.cross.rawValue
    let attackAction = "attack"
    let defenseAction = "defense"
}

// MARK: - Methods
extension TicTacToeIA {
    // IA round play
    func play() -> Bool {
        // PROVISOIRE
        var levelGame: Bool!

            // First level of difficultyirst level
            if UserPreferences.level == 0 {
                levelGame = dumb()
            // Second level of difficulty
            } else if UserPreferences.level == 1 {
                levelGame = evolve()
            }

        return levelGame
    }

    /// IA with no reflexions
    private func dumb() -> Bool {
        var resolvingFunction = false
        var isNotOver = true

        repeat {
            // Random choice of a box
            let random: Int = Int.random(in: 0 ... boxes - 1)
            let chooseCase = BoxStatus.boxStatus[random]

            var defaultChoice: Bool {
                return chooseCase == emptyCase
            }

            // if the selected box is empty, then there is resolution of the action of
            if defaultChoice  {
                resolvingFunction = resolution(random: random)
            }
        } while resolvingFunction != true

        // if IA win, player lose
        if BoxStatus.winner() == true {
            Notification.ticTacToeInformationPlayer(condition: .loser, name: "")
            isNotOver = false
        }

        return isNotOver
    }

    /// IA with programmed actions
    func evolve() -> Bool {
        var isNotOver = true

        // The three possibilities for AI on a line, column, diagonal
        var firstPossibility: Int? = nil
        var secondPossibility: Int? = nil
        var thirdPossibility: Int? = nil

// MARK: - Attack Lines
        // If two of the three boxes on the line are occupied by the AI, then the latter plays the free box to win
        var attackLineOne: Bool {
            return actionIA(boxeOne: 0, boxeTwo: 1, boxeThree: 2, status: attackAction)
        }

        var attackLineTwo: Bool {
            return actionIA(boxeOne: 3, boxeTwo: 4, boxeThree: 5, status: attackAction)
        }

        var attackLineThree: Bool {
            return actionIA(boxeOne: 6, boxeTwo: 7, boxeThree: 8, status: attackAction)
        }

// MARK: - Attack Column
        var attackColumnOne: Bool {
            return actionIA(boxeOne: 0, boxeTwo: 3, boxeThree: 6, status: attackAction)
        }

        var attackColumnTwo: Bool {
            return actionIA(boxeOne: 1, boxeTwo: 4, boxeThree: 7, status: attackAction)
        }

        var attackColumnThree: Bool {
            return actionIA(boxeOne: 2, boxeTwo: 5, boxeThree: 8, status: attackAction)
        }

// MARK: - Attack Diagonal
        var attackDiagonalOne: Bool {
            return actionIA(boxeOne: 0, boxeTwo: 4, boxeThree: 8, status: attackAction)
        }

        var attackDiagonalTwo: Bool {
            return actionIA(boxeOne: 2, boxeTwo: 4, boxeThree: 6, status: attackAction)
        }

// MARK: - Defense Lines
        // If two of the three boxes on the line are occupied by the player, then the latter plays the free box to win
        var defenseLineOne: Bool {
            return actionIA(boxeOne: 0, boxeTwo: 1, boxeThree: 2, status: defenseAction)
        }

        var defenseLineTwo: Bool {
            return actionIA(boxeOne: 3, boxeTwo: 4, boxeThree: 5, status: defenseAction)
        }

        var defenseLineThree: Bool {
            return actionIA(boxeOne: 6, boxeTwo: 7, boxeThree: 8, status: defenseAction)
        }

// MARK: - Defense Column
        var defenseColumnOne: Bool {
            return actionIA(boxeOne: 0, boxeTwo: 3, boxeThree: 6, status: defenseAction)
        }

        var defenseColumnTwo: Bool {
            return actionIA(boxeOne: 1, boxeTwo: 4, boxeThree: 7, status: defenseAction)
        }

        var defenseColumnThree: Bool {
            return actionIA(boxeOne: 2, boxeTwo: 5, boxeThree: 8, status: defenseAction)
        }

// MARK: - Defense Diagonal
        var defenseDiagonalOne: Bool {
            return actionIA(boxeOne: 0, boxeTwo: 4, boxeThree: 8, status: defenseAction)
        }

        var defenseDiagonalTwo: Bool {
            return actionIA(boxeOne: 2, boxeTwo: 4, boxeThree: 6, status: defenseAction)
        }

// MARK: -Priority action
        // First the attack action, then the defense action and finally the default action
        if attackLineOne {
            firstPossibility = 0
            secondPossibility = 1
            thirdPossibility = 2
        } else if attackLineTwo {
            firstPossibility = 3
            secondPossibility = 4
            thirdPossibility = 5
        } else if attackLineThree {
            firstPossibility = 6
            secondPossibility = 7
            thirdPossibility = 8
        } else if attackColumnOne {
            firstPossibility = 0
            secondPossibility = 3
            thirdPossibility = 6
        } else if attackColumnTwo {
            firstPossibility = 1
            secondPossibility = 4
            thirdPossibility = 7
        } else if attackColumnThree {
            firstPossibility = 2
            secondPossibility = 5
            thirdPossibility = 8
        } else if attackDiagonalOne {
            firstPossibility = 0
            secondPossibility = 4
            thirdPossibility = 8
        } else if attackDiagonalTwo {
            firstPossibility = 2
            secondPossibility = 4
            thirdPossibility = 6
        } else if defenseLineOne {
            firstPossibility = 0
            secondPossibility = 1
            thirdPossibility = 2
        } else if defenseLineTwo {
            firstPossibility = 3
            secondPossibility = 4
            thirdPossibility = 5
        } else if defenseLineThree {
            firstPossibility = 6
            secondPossibility = 7
            thirdPossibility = 8
        } else if defenseColumnOne {
            firstPossibility = 0
            secondPossibility = 3
            thirdPossibility = 6
        } else if defenseColumnTwo {
            firstPossibility = 1
            secondPossibility = 4
            thirdPossibility = 7
        } else if defenseColumnThree {
            firstPossibility = 2
            secondPossibility = 5
            thirdPossibility = 8
        } else if defenseDiagonalOne {
            firstPossibility = 0
            secondPossibility = 4
            thirdPossibility = 8
        } else if defenseDiagonalTwo {
            firstPossibility = 2
            secondPossibility = 4
            thirdPossibility = 6
        }

        if firstPossibility != nil && secondPossibility != nil && thirdPossibility != nil {
            boxeChoice(first: firstPossibility!, second: secondPossibility!, third: thirdPossibility!)
        } else {
            defaultAction()
        }

        // if IA win, player lose
        if BoxStatus.winner() == true {
            Notification.ticTacToeInformationPlayer(condition: .loser, name: "")
            isNotOver = false
        }

        return isNotOver
    }

    private func actionIA(boxeOne: Int, boxeTwo: Int, boxeThree: Int, status: String) -> Bool {
        var action = false
        var boxeImage: String {
            var image = emptyCase

            if status == attackAction {
                image = crossCase
            } else if status == defenseAction {
                image = circleCase
            }

            return image
        }

        if BoxStatus.boxStatus.count == boxes && (BoxStatus.boxStatus[boxeOne] == emptyCase || BoxStatus.boxStatus[boxeTwo] == emptyCase || BoxStatus.boxStatus[boxeThree] == emptyCase)
            && ((BoxStatus.boxStatus[boxeOne] == boxeImage && BoxStatus.boxStatus[boxeTwo] == boxeImage)
                || (BoxStatus.boxStatus[boxeTwo] == boxeImage && BoxStatus.boxStatus[boxeThree] == boxeImage)
                || (BoxStatus.boxStatus[boxeOne] == boxeImage && BoxStatus.boxStatus[boxeThree] == boxeImage) ) {
            action = true
        }

        return action
    }

    private func boxeChoice (first: Int, second: Int, third: Int) {
        var choice: Int!
        let arrayPossibility = [first, second, third]

        for possibility in arrayPossibility {
            if loopChoice(possibility: possibility) {
                choice = possibility
            }
        }

        BoxStatus.boxStatus[choice] = crossCase
        Notification.ticTacToeNotification(image: BoxStatus.boxStatus[choice], sender: choice)
    }
    
    private func loopChoice(possibility: Int) -> Bool {
        let chooseCase = BoxStatus.boxStatus[possibility]
        var loopSuccess = false

        var defaultChoice: Bool {
            return chooseCase == emptyCase
        }
        
        if defaultChoice  {
            loopSuccess = true
        }
        
        return loopSuccess
    }

    /// If there is no programmed priority action to perform
    private func defaultAction() {
        var resolvingFunction = false

        // Loop until empty box has found for 'IA' action
        repeat {
            let random: Int = Int.random(in: 0 ... boxes - 1)
            let chooseCase = BoxStatus.boxStatus[random]

            var defaultChoice: Bool {
                return chooseCase == emptyCase
            }

            if defaultChoice  {
                resolvingFunction = resolution(random: random)
            }
        } while resolvingFunction != true
    }

    /// Positive resolution of 'IA' action
    private func resolution(random: Int) -> Bool {
        BoxStatus.boxStatus[random] = crossCase
        Notification.ticTacToeNotification(image: BoxStatus.boxStatus[random], sender: random)

        return true
    }
}
