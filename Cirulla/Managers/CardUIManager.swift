//
//  CardUIManager.swift
//  Cirulla
//
//  Created by VFERREROW1 on 17/03/25.
//

import UIKit

class CardUIManager {
    
    static let shared = CardUIManager()
    
    func setStyleCard(_ card: [UIImageView]) {
        for c in card {
            c.layer.cornerRadius = 8
            c.layer.shadowColor = UIColor.black.cgColor
            c.layer.shadowOpacity = 0.5
            c.layer.shadowOffset = CGSize(width: 3, height: 3)
            c.layer.shadowRadius = 5
            c.layer.masksToBounds = false
        }
    }
    
    func playCardAnimation(cardView: UIView, toTablePosition: CGPoint, completion: (() -> Void)? = nil) {
        UIView.animate(withDuration: 0.2, animations: {
            cardView.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        }) { _ in
            UIView.animate(withDuration: 0.4, animations: {
                cardView.center = toTablePosition
                cardView.transform = CGAffineTransform(rotationAngle: CGFloat.random(in: -0.1...0.1)) // Leggera inclinazione casuale
            }, completion: { _ in
                completion?() // Esegue il codice passato dopo l'animazione
            })
        }
    }
    
}
