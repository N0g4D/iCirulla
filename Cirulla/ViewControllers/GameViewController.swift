//
//  GameViewController.swift
//  Cirulla
//
//  Created by VFERREROW1 on 20/02/25.
//

import UIKit

class GameViewController: BaseViewController {
    
    private var viewModel = GameViewModel()
    
    // MARK: Button
    @IBOutlet weak var optionButton: UIButton!
    
    // MARK: Label
    @IBOutlet weak var roundPlayerLabel: UILabel!
    
    // MARK: ImageView G1
    @IBOutlet weak var g1Card1: UIImageView!
    @IBOutlet weak var g1Card2: UIImageView!
    @IBOutlet weak var g1Card3: UIImageView!
    
    // MARK: ImageView G2
    @IBOutlet weak var g2Card1: UIImageView!
    @IBOutlet weak var g2Card2: UIImageView!
    @IBOutlet weak var g2Card3: UIImageView!
    
    // MARK: ImageView deck & cardPlayed
    @IBOutlet weak var deck: UIImageView!
    @IBOutlet weak var cardPlayed: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewModel.shuffle()
        //self.showStartGameLabel(for: "Inizia!")
        
        addTapGesture(to: g1Card1)
        addTapGesture(to: g1Card2)
        addTapGesture(to: g1Card3)
    }

    override func setupUI() {
        self.view.backgroundColor = .systemGreen
        
        self.optionButton.layer.cornerRadius = 10
        self.optionButton.backgroundColor = .white
        self.setStyleCard([g1Card1,g1Card2,g1Card3,g2Card1,g2Card2,g2Card3,deck])
    }
    
    // Metodo per aggiungere il Gesture Recognizer alle carte
    private func addTapGesture(to card: UIImageView) {
        let tap = UITapGestureRecognizer(target: self, action: #selector(cardTapped(_:)))
        card.isUserInteractionEnabled = true // Abilita l’interazione
        card.addGestureRecognizer(tap)
    }
    
    // Metodo chiamato quando una carta viene tappata
    @objc private func cardTapped(_ sender: UITapGestureRecognizer) {
        guard let tappedCard = sender.view as? UIImageView else { return }
        
        // Converti la posizione della carta rispetto alla vista principale
        let cardFrameInMainView = tappedCard.superview?.convert(tappedCard.frame, to: self.view) ?? tappedCard.frame

        // Crea una copia della carta tappata
        let cardCopy = UIImageView(image: tappedCard.image)
        cardCopy.frame = cardFrameInMainView
        cardCopy.layer.cornerRadius = tappedCard.layer.cornerRadius
        cardCopy.layer.masksToBounds = tappedCard.layer.masksToBounds
        cardCopy.layer.shadowColor = tappedCard.layer.shadowColor
        cardCopy.layer.shadowOpacity = tappedCard.layer.shadowOpacity
        cardCopy.layer.shadowOffset = tappedCard.layer.shadowOffset
        cardCopy.layer.shadowRadius = tappedCard.layer.shadowRadius

        // Aggiungi la copia alla vista principale
        self.view.addSubview(cardCopy)

        // Anima la copia della carta verso il tavolo
        let tablePosition = cardPlayed.center
        playCardAnimation(cardView: cardCopy, toTablePosition: tablePosition) {
            self.cardPlayed.image = tappedCard.image
            cardCopy.removeFromSuperview()
        }
    }
    
    /*
    func showStartGameLabel(for label: String) {
        roundPlayerLabel.text = label
        roundPlayerLabel.alpha = 0
        // Partenza più in alto
        roundPlayerLabel.transform = CGAffineTransform(translationX: 0, y: -30)

        UIView.animate(withDuration: 0.5, animations: {
            self.roundPlayerLabel.alpha = 1
            self.roundPlayerLabel.transform = .identity
        })
    }
    */
    
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

    @IBAction func optionButtonTapped(_ sender: Any) {
        print("Tapped")
    }
}

