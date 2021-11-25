//
//  UIButton.swift
//  TicTacToe
//
//  Created by Elie Arquier on 24/11/2021.
//

import UIKit

extension UIButton {
    /// Add method to UIButton for animate user action's
    func animated() {
        UIView.animate(withDuration: 0.1, delay: 0, usingSpringWithDamping: 0.9,
                       initialSpringVelocity: 0.5, options: .curveEaseIn, animations: {
            self.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }) {(_) in
            self.transform = .identity
        }
    }
}
